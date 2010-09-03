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
			#$DB::single = 1;
    $self->ok( $self->uri->authority =~ /\.gob\.ve$/i );
}

package CNTI::Validator::Test::Meta;
use Moose;
use HTML::TreeBuilder;
use CNTI::Validator::Schema;

extends 'CNTI::Validator::Test';

sub run {
    my $self = shift;
    my $errcount = 0;
    my @metas;
    my @rs_metas = CNTI::Validator::Schema->resultset('Param')->search( { disposicion => 'Meta' } );
    my %hash;
    for my $meta (@rs_metas) {
        $hash{$meta->get_column('parametro')} = 0;
    }
    my @node = $self->htmlt->find('meta');
    unless (@node) {
        $self->event_log( error => "No tiene etiqueta meta");
        $errcount++;
    }
    for my $father (@node) {
        unless ($father->parent->tag eq 'head') {
            $self->event_log( error => "La etiqueta meta no está dentro del tag head");
            $errcount++;
        }
        if ($father->attr('name')) {
            my @rs = CNTI::Validator::Schema->resultset('Param')->search( { disposicion => 'Meta', parametro => $father->attr('name') } );
            if ($#rs < 0) {
                # push @metas, $father->attr('name');
                $errcount++;
            } else {
                $hash{$father->attr('name')} = 1;
            }
        } else {
            $self->event_log( error => "Solo está definida la meta http-equiv" );
            $errcount++;
        }
    }
    my @keys_with_values = grep { $hash{$_} == 0 } keys %hash;
    if ($errcount) {
        $self->event_log( error => "No está definida la meta $_" ) for @keys_with_values;
    }
    $self->ok( $errcount == 0);
}

package CNTI::Validator::Test::Layout;
use Moose;

extends 'CNTI::Validator::Test';

sub run {
    my $self = shift;
    my $errcount = 0;
    my $tblcount = 0;

    my @frames = $self->htmlt->find('frame');
    my $numframes = $#frames + 1;
    $self->event_log( error => "Se ha encontrado $numframes etiquetas de tipo <frame> " ) if ($#frames >= 0);
    $errcount++ if ($#frames >= 0);
    my @iframes = $self->htmlt->find('iframe');
    my $numiframes = $#iframes + 1;
    $self->event_log( error => "Se ha encontrado $numiframes etiquetas de tipo <frame> " ) if ($#iframes >= 0);
    $errcount++ if ($#iframes >= 0);
    
    my @nodes = $self->htmlt->find('table');
    if ($#nodes >= 0) {
        for my $table (@nodes) {
            my @hijos = $table->descendants();
            for my $hijo (@hijos) {
                my @tblchild = $hijo->find('table');
                if ($#tblchild >= 3) {
                    $errcount++;
                    $tblcount++;
                }
            }
        }
    }
    $self->event_log( error => "Posible maquetado por tablas, demasiadas tablas anidadas" ) if $tblcount;
    $self->ok( $errcount == 0 );
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
        #$DB::single = 1;
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
        if ( $ct_charset =~ /^UTF-?8$/i ) {
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
        if ( $c =~ /^([^;]+)(?:;\s*charset=(\S+))?/i ) {
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
        unless ( lc($type) eq 'image/png' ) {
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
            if ( $lang =~ m!text/javascript(?:;(\S+))?!i ) {
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

package CNTI::Validator::Test::Plugins;
use Moose;

extends 'CNTI::Validator::Test';

# $DB::single = 1;
sub run {
    my $self  = shift;

    my @plugins = $self->htmlt->find('object');
    my $activex = 0;
    my $flashhtml5 = 0;
    for my $plugin (@plugins) {
        if ( $plugin->attr('classid') =~ /clsid:/i ) {
            $activex++;
        } elsif ( $plugin->attr('data') =~ /\.swf/i ) {
            $flashhtml5++;
        }
    }
    my @embed = $self->htmlt->find('embed');
    for my $flash (@embed) {
        if ( $flash->attr('src') =~ /swf/i or $flash->attr('type') =~ /flash/i or $flash->attr('src') =~ /youtube/ ) {
            $flashhtml5++;
        }
    }

    $self->event_log( error => "Hay $activex controles ActiveX" ) if ($activex);
    $self->event_log( error => "Hay $flashhtml5 controles Flash declarados" ) if ($flashhtml5);

    $self->ok( $activex == 0  and $flashhtml5 == 0);
}

package CNTI::Validator::Test::Fonts;
use Moose;
use CNTI::Validator::Schema;
use CNTI::Validator::CSS;
use WWW::Mechanize;
# use CNTI::Validator::CSS;
use URI;
   
extends 'CNTI::Validator::Test';

sub httpurl {
    my ($uri, $urlcss, $href) = @_;
    my $url;
    if ( $urlcss->path =~ /^\//) {
        $url = $href if $urlcss->authority;
        $url = "http://" . $uri->authority . $urlcss->path if !($urlcss->authority);
    } else {
        $url = $href if $urlcss->authority;
        $url = "http://" . $uri->authority . "/" . $urlcss->path if !($urlcss->authority);
    }
    return $url;
}

sub checkfonts {
    my $content= shift;
    my $fontcount = 0;
    my $errorcount = 0;
    my @fonts;
    my $css = CNTI::Validator::CSS->new();
    $css = CNTI::Validator::CSS->read_string($content);
    for my $style ( values %{$css} ) {
        if ($style->{'font-family'}) {
            my $fuentes = $style->{'font-family'};
            my @fnt = split /,[\ ?]*/, $fuentes;
            foreach my $a (@fnt) {
                $fontcount++;
                my @rs = CNTI::Validator::Schema->resultset('Param')->search( { disposicion => "Fonts", parametro => $a } );
                if ( $#rs < 0 ) {
                    push @fonts, $a;
                    $errorcount++;
                }
            }
        }
    }
    return ($fontcount, $errorcount, @fonts);
}

sub run {
    my $self = shift;
    my $css = CNTI::Validator::CSS->new();
    my $mech = WWW::Mechanize->new; 
    $mech->add_header(Accept => "*/*");
    my @styles = $self->htmlt->find('link');
    my $fontcount = 0;
    my $errorcount = 0;
    my $uri = $self->uri;
    for my $css (@styles) {
        # Revision en hojas de estilo externas
        if ($css->attr('rel') eq 'stylesheet') {
            if ($css->attr('href')) {
                my $href = $css->attr('href');
                # my $urlcss = URI->new($href);
                # my $url = httpurl $uri, $urlcss, $href;
                my $url = URI->new_abs( $href, $self->uri );
                $mech->get($url);
                my $content = $mech->content;
                my ($errcount, $fntcount, @fuentes) = checkfonts $content;
                if ($#fuentes >= 0) {
                    for my $fuente (@fuentes) {
                        $self->event_log( error => "La fuente $fuente no es libre en el CSS $url");
                    }
                }
                $errorcount = $errorcount + $errcount;
                $fontcount = $fontcount + $fntcount;
                my @contenido = split /\n/, $mech->content;
                for my $lineas (@contenido) {
                    if ($lineas =~ /\@import\s+(url|)\(?["|'](.*)["|']\)?/i) {
                        # my $cssuri = URI->new($2);
                        # my $cssurl = httpurl $uri, $cssuri, $href;
                        my $hre = $2;
                        my $cssurl = URI->new_abs( $hre, $self->uri );
                        my $mech2 = WWW::Mechanize->new();
                        $mech2->add_header(Accept => "*/*");
                        $mech2->get($cssurl);
                        my $content2 = $mech2->content;
                        my ($ercnt, $fntcnt, @subfonts) = checkfonts $content2;
                        if ($#subfonts >= 0) {
                            for my $subfont (@subfonts) {
                                $self->event_log( error => "La fuente $subfont no es libre en el CSS $cssurl");
                            }
                        }
                        $errorcount = $errorcount + $ercnt;
                        $fontcount = $fontcount + $fntcnt; 
                    }
                }
            } else {
                $self->event_log( warning => "Atributo link de tipo stylesheet con href vacio" );
                $errorcount++;
            }
        }
        # Revision en etiqueta style
        my @styletags = $self->htmlt->find('style'); 
        for my $styletag (@styletags) {
            my @lines = $styletag->content_list;
            my $stylecontent = join ("\n", @lines);
            my ($styerrorcount, $styfontcount, @styfonts) = checkfonts $stylecontent;
            if ($#styfonts >= 0) {
                for my $styfont (@styfonts) {
                    $self->event_log( error => "La fuente $styfont no es libre, embebido en el HTML" );
                }
            }
            $errorcount = $errorcount + $styerrorcount;
            $fontcount = $fontcount + $styfontcount;
            for my $line (@lines) {
                if ($line =~ /\@import\s+(url|)\(?["|'](.*)["|']\)?/i) {
                    # my $styuri = URI->new($2);
                    # my $styurl = httpurl $uri, $styuri, "";
                    my $resource = $2;
                    my $styurl = URI->new_abs( $resource, $self->uri );
                    my $stymech = WWW::Mechanize->new();
                    $stymech->add_header(Accept => "*/*");
                    $stymech->get($styurl);
                    my $stycontent = $stymech->content;
                    my ($styercnt, $styfntcnt, @styimportfonts) = checkfonts $stycontent;
                    if ($#styimportfonts >= 0) {
                        for my $styimportfont (@styimportfonts) {
                            $self->event_log( error => "La fuente $styimportfont no es libre en el CSS $styurl");
                        }
                    }
                    $errorcount = $errorcount + $styercnt;
                    $fontcount = $fontcount + $styfntcnt; 
                }
            }
        }

    }
    if ($fontcount <= 0) {
        $self->event_log( error => "No se han encontrado fuentes en las hojas de estilo, las fuentes deben ser declaradas en hojas de estilo y no en el HTML" );
        $errorcount++;
    }
    $self->ok( $errorcount == 0 );
}

package CNTI::Validator::Test::Formatos;
use Moose;

extends 'CNTI::Validator::Test';

sub run {
    my $self = shift;
    my $errcount = 0;
     
    my @nodes = $self->htmlt->find('a');
    if ($#nodes >= 0) {
        for my $node (@nodes) {
            my $f = $node->attr('href');
            if ($node->attr('href')) {
                if ($f =~ /(\.doc|\.docx|\.ppt|\.pptx|\.xls|\.xlsx)/i ) {
                    $self->event_log( error => "El archivo $f no tiene un formato libre" );
                    $errcount++;
                }
            }
        }
    }
    $self->ok( $errcount == 0 );
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
