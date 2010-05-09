use CNTI::Validator::Schema;
use CNTI::Validator::Jobs;
use CNTI::Validator::Tests;

use common::sense;

sub validate {
    my $it = CNTI::Validator::Jobs->search_jobs( { state => 'new' }, { order_by => 'ctime' } );
    return unless $it;

    my $job = $it->();
    return unless $job;
    
    $job->set_state('open');
    my $url_it = $job->children;
    return unless $url_it;

    while ( my $url = $url_it->() ) {
        CNTI::Validator::Tests->run( $job, $url );
    }

    $job->set_state('done');
}

validate();
