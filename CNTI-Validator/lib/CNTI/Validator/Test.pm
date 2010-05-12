package CNTI::Validator::Test;
use Moose;

has url => ( is => 'ro', isa => 'CNTI::Validator::Monitor::URL', required => 1, handles => { uri => "uri" } );
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
has response => (is => "ro", isa => "HTTP::Response", lazy => 1, builder => "_build_response");
has content => (is => "ro", isa => "Str", lazy => 1, builder => "_build_content");
has htmlt => (is => "ro", isa => "HTML::TreeBuilder", lazy => 1, builder => "_build_htmlt" );

sub _build_response {
    my $self = shift;
    my $cache = $self->cache;
    $cache->get( $self->uri );
    return $cache->response;
}

sub _build_content {
    my $self = shift;
    unless ( $self->response->code =~ /^2*/ ) {
        $self->event_log( fatal => "HTTP Error: " . $self->response->code );
        $self->ok(0);
        die;
    }
    $self->response->content;
}

sub _build_htmlt {
    my $self = shift;
    my $tree = HTML::TreeBuilder->new;
    $tree->parse( $self->content );
    return $tree;
}

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
    $self->ok( $self->uri->authority =~ /\.gob\.ve$/i );
}

package CNTI::Validator::Test::Title;
use Moose;
use CNTI::Validator::LibXML;
use HTML::TreeBuilder;

extends 'CNTI::Validator::Test';

sub run {
    my $self  = shift;

    my $node = $self->htmlt->find('html');
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
        $DB::single = 1;
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
    my $resp = $self->response;

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

    my $node = $self->htmlt->find('html');
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

    my $mm   = File::MMagic->new();
    my @images = $self->htmlt->find('img');
    my $errors = 0;
    for my $img (@images) {
        my $src = $img->attr('src');
        my $uri = URI->new_abs( $src, $self->uri );
        $self->cache->get($uri);
        my $type = $mm->checktype_contents( $self->cache->response->content );
        unless ( $type eq 'image/png' ) {
            $self->event_log( error => "Tipo de imagen ilegal $type" );
            $errors++;
        }
    }
    $self->ok( $errors == 0 );
}
sub run2 {
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

extends 'CNTI::Validator::Test';

sub run {
    my $self  = shift;

    my @images   = $self->htmlt->find('img');
    my $errors   = 0;
    my $warnings = 0;
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

extends 'CNTI::Validator::Test';

sub run {
    my $self  = shift;

    my @scripts   = $self->htmlt->find('script');
    my $errors    = 0;
    my $warnings  = 0;
    my $lang_flag = 0;
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

extends 'CNTI::Validator::Test';

sub run {
    my $self  = shift;

    my @scripts  = $self->htmlt->find('script');
    my $errors   = 0;
    my $warnings = 0;
    my $count    = 0;
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

package CNTI::Validator::Test::HTML4;
use Moose;

extends 'CNTI::Validator::Test';

sub run {
    my $self  = shift;

    my $decl = $self->htmlt->{_decl}{text} || '';    # TODO: fix this
    my $type = '';
    if ( $decl =~ s!DOCTYPE \s+ html!!x ) {
        if ( $decl =~ s!^\s*PUBLIC!!x ) {
            if ( $decl =~ s!^\s*"([^"]+)"!!x ) {
                my $reg = $1;
                $type = "HTML-4.01" if $reg =~ m!-//W3C//DTD \s+ HTML \s+ 4.01!x;
                $type = "XHTML-1.0" if $reg =~ m!-//W3C//DTD \s+ XHTML \s+ 1.0!x;
                $type = "XHTML-1.1" if $reg =~ m!-//W3C//DTD \s+ XHTML \s+ 1.1!x;
            }
            if ( $decl =~ s!^\s*"[^"]+"!! ) {
            }
        }
        elsif ( $decl =~ m!^\s*$! ) {
            $type = "HTML-5";
        }
    }
    if ( $type eq "HTML-4.01" or $type eq "XHTML-1.0" ) {
        $self->ok(1);
    }
    else {
        $self->event_log( error => "El tipo de documento es: $type" ) if $type;
        $self->ok(0);
    }
}

1;
