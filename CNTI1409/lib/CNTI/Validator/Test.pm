package CNTI::Validator::Test;
use Moose;

has url => ( is => 'ro', isa => 'CNTI::Validator::Monitor::URL', required => 1 );
has task => (
    is       => 'ro',
    isa      => 'CNTI::Validator::Tests',
    required => 1,
    handles  => { job => 'job', cache => 'cache' }
);
has events => (
    is      => 'ro',
    isa     => 'ArrayRef[HashRef]',
    default => sub { [] },
    traits  => ['Array'],
    handles => { event_add => "push", event_list => 'elements', event_count => 'count' }
);

sub ok {
    my $self = shift;
    my $cond = shift;
    my $result
        = $self->url->add_child( { pass => ( $cond ? 'pass' : 'fail' ), name => $self->name } );
    $result->add_children( $self->event_list ) if $self->event_count;
}

sub event_log {
    my ( $self, $class, $mesg, $data ) = @_;
    my $ev = { class => $class, message => $mesg };
    $ev->{'data'} = shift if $data;
    $self->event_add($ev);
}

sub name {
    my $self = shift;
    my $name = ref($self);
    $name =~ s/.*://;
    $name;
}

package CNTI::Validator::Test::Domain;
use Moose;
use URI;

extends 'CNTI::Validator::Test';

sub run {
    my $self = shift;
    my $uri  = URI->new( $self->job->site );
    $self->ok( $uri->authority =~ /\.gob\.ve$/, "Dominio incorrecto" );
}

package CNTI::Validator::Test::Title;
use Moose;
use CNTI::Validator::LibXML;
use HTML::TreeBuilder;

extends 'CNTI::Validator::Test';

sub run {
    my $self  = shift;
    my $cache = $self->cache;
    $cache->get( $self->job->site . $self->url->path );

    my $tree = HTML::TreeBuilder->new;
    $tree->parse( $cache->response->content );
    my $node = $tree->find('html');
    unless ($node) {
        $self->event_log( 'error', 'No es HTML' );
        return $self->ok(0);
    }
    $node = $node->find('head');
    unless ($node) {
        $self->event_log( 'error', 'No tiene HEAD' );
        return $self->ok(0);
    }
    $node = $node->find('title');
    unless ($node) {
        $self->event_log( 'error', 'No tiene TITLE' );
        return $self->ok(0);
    }
    my @cont = $node->content_list;
    if ( @cont == 1 and !ref $cont[0] ) {
        return $self->ok(1);
    }
    else {
        $self->event_log( 'error', 'TITLE mal formado: ' . $node->as_HTML );
        return $self->ok(0);
    }
}

package CNTI::Validator::Test::UTF8;
use Moose;
use CNTI::Validator::LibXML;
use HTML::TreeBuilder;
use Encode;

extends 'CNTI::Validator::Test';

sub run {
    my $self  = shift;
    my $cache = $self->cache;
    $cache->get( $self->job->site . $self->url->path );
    my $resp = $cache->response;

    my $ct_charset = $resp->content_type_charset;
    my $content;
    my @errors;
    my @warnings;
    if ($ct_charset) {
        if ( $ct_charset =~ /^UTF-?8$/ ) {
            $content = eval { decode( "utf8", $resp->content, Encode::FB_CROAK ) };
            push @errors, $@ if $@;
        }
        else {
            push @warnings, "HTTP charset: $ct_charset";
        }
    }
    else {
        push @warnings, "No HTTP Charset";
    }
    $content ||= $resp->content;

    my $tree = HTML::TreeBuilder->new;
    $tree->parse($content);
    my $node = $tree->find('html');
    unless ($node) {
        $self->event_log( 'error', 'No es HTML' );
        return $self->ok(0);
    }
    $node = $node->find('head');
    unless ($node) {
        $self->event_log( 'error', 'No tiene HEAD' );
        return $self->ok(0);
    }
    my @metas = $node->look_down( _tag => 'meta', 'http-equiv' => qr/^Content-Type$/i );
    for my $m (@metas) {
        my $c = $m->attr('content');
        if ( $c =~ /^([^;]+)(?:;\s*charset=(\S+))?/ ) {
            push @errors, "HTTP charset '$ct_charset' does not match META charset '$2'"
                if lc($ct_charset) ne lc($2);
        }
    }
    $self->event_log( warnings => $_ ) for @warnings;
    if (@errors) {
        $self->event_log( error => $_ ) for @errors;
        $self->ok(0);
    }
    else {
        $self->ok(1);
    }
}

package CNTI::Validator::Test::Img;
use Moose;
use HTML::TreeBuilder;
use File::MMagic;

extends 'CNTI::Validator::Test';

sub run {
    my $self  = shift;
    my $cache = $self->cache;
    $cache->get( $self->job->site . $self->url->path );
    my $resp = $cache->response;

    my $mm   = File::MMagic->new();
    my $tree = HTML::TreeBuilder->new;
    $tree->parse( $resp->content );
    my @images = $tree->find('img');
    my $errors = 0;
    for my $img (@images) {
        my $src = $img->attr('src');
        my $uri = URI->new_abs( $src, $self->job->site . $self->url->path );
        $cache->get($uri);
        $resp = $cache->response;
        my $type = $mm->checktype_contents( $resp->content );
        unless ( $type eq 'image/png' ) {
            $self->event_log( error => "Tipo de imagen ilegal $type" );
            $errors++;
        }
    }
    $self->ok( $errors == 0 );
}

package CNTI::Validator::Test::Alt;
use Moose;
use HTML::TreeBuilder;
use File::MMagic;

extends 'CNTI::Validator::Test';

sub run {
    my $self  = shift;
    my $cache = $self->cache;
    $cache->get( $self->job->site . $self->url->path );
    my $resp = $cache->response;

    my $mm   = File::MMagic->new();
    my $tree = HTML::TreeBuilder->new;
    $tree->parse( $resp->content );
    my @images   = $tree->find('img');
    my $errors   = 0;
    my $warnings = 0;
    $DB::single = 1;
    for my $img (@images) {
        my $alt = $img->attr('alt');
        if ( defined $alt ) { $warnings++ unless $alt }
        else { $errors++ }
    }
    $self->event_log( error   => "Hay $errors imagenes sin atributo ALT" )          if $errors;
    $self->event_log( warning => "Hay $warnings imagenes con atributo ALT vacío" ) if $warnings;
    $self->ok( $errors == 0 );
}

package CNTI::Validator::Test::JS;
use Moose;
use HTML::TreeBuilder;
use File::MMagic;

extends 'CNTI::Validator::Test';

sub run {
    my $self  = shift;
    my $cache = $self->cache;
    $cache->get( $self->job->site . $self->url->path );
    my $resp = $cache->response;

    my $mm   = File::MMagic->new();
    my $tree = HTML::TreeBuilder->new;
    $tree->parse( $resp->content );
    my @scripts   = $tree->find('script');
    my $errors    = 0;
    my $warnings  = 0;
    my $lang_flag = 0;
    $DB::single = 1;
    for my $script (@scripts) {

        if ( my $lang = $script->attr('language') ) {
            $lang_flag = 1;
            $warnings++;
            $self->event_log( warning => "Atributo obsoleto 'language'" );
            unless ( $lang =~ /^javascript$/i ) {
                $errors++;
                $self->event_log( error => "Lenguaje ilegal: $lang" );
            }
        }
        if ( my $lang = $script->attr('type') ) {
            $lang_flag = 2;
            if ( $lang =~ m!text/javascript(?:;(\S+))?! ) {
            }
            else {
                $errors++;
                $self->event_log( error => "Lenguaje ilegal: $lang" );
            }
        }
        unless ($lang_flag) {
            $errors++;
            $self->event_log( error => "No se especifica el lenguaje" );
        }
    }
    $self->ok( $errors == 0 );
}

package CNTI::Validator::Test::JS_inc;
use Moose;
use HTML::TreeBuilder;
use File::MMagic;

extends 'CNTI::Validator::Test';

sub run {
    my $self  = shift;
    my $cache = $self->cache;
    $cache->get( $self->job->site . $self->url->path );
    my $resp = $cache->response;

    my $mm   = File::MMagic->new();
    my $tree = HTML::TreeBuilder->new;
    $tree->parse( $resp->content );
    my @scripts  = $tree->find('script');
    my $errors   = 0;
    my $warnings = 0;
    my $count    = 0;
    $DB::single = 1;
    for my $script (@scripts) {

        if ( $script->attr('src') ) {
            if ( $script->attr('src') =~ /\.js$/ ) {
                $count++;
            }
            else {
                $errors++;
                $self->event_log( error => "El archivo externo no tiene extension .js" );
            }
        }
        else {
            $errors++;
            $self->event_log( error => "Script en línea" );
        }
    }
    unless ($count) {
        $errors++;
        $self->event_log( error => "No se usan archivos con extensión .js" );
    }
    $self->ok( $errors == 0 );
}

1;