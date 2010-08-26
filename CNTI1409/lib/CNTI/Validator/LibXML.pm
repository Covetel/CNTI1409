package CNTI::Validator::LibXML;
use Moose;
use XML::LibXML '1.69';

has xpc => ( is => 'ro' );
has doc => ( is => 'ro' );

around BUILDARGS => sub {
    # $DB::single = 1;
    my $orig  = shift;
    my $class = shift;
    my %args  = @_;
    unless ( $args{'doc'} ) {
        $args{'doc'} = sub {

            # Create and configure the parser.
            my $parser = XML::LibXML->new;

            # Apply any parser options.
            if ( my $opts = delete $args{'options'} ) {
                while ( my ( $k, $v ) = each %{$opts} ) {
                    $parser->$k($v);
                }
            }

            # Parse and return the document.
            if ( my $xml = delete $args{'xml'} ) {
                return delete $args{'is_html'}
                    ? $parser->parse_html_string($xml)
                    : $parser->parse_string($xml);
            }

            if ( my $file = delete $args{'file'} ) {
                return delete $args{'is_html'}
                    ? $parser->parse_html_file($file)
                    : $parser->parse_file($file);
            }

            require Carp;
            Carp::carp('Test::XPath->new requires the "xml", "file", or "doc" parameter');
        }->();
    }
    $args{'xpc'} = XML::LibXML::XPathContext->new( $args{'doc'}->documentElement );
    if ( my $ns = delete $args{'xmlns'} ) {
        while ( my ( $k, $v ) = each %{$ns} ) {
            $args{'xpc'}->registerNs( $k => $v );
        }
    }
    return \%args;
};

1;
