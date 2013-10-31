use CNTI::Spider::State;
use CNTI::Spider::UA;
use CNTI::Spider::UrlList;

my $params = {};

$params->{base} = 'http://www.cantv.com.ve';
$params->{prof} = 10;
$params->{numero} = 10;

my $spider = CNTI::Spider::State->new(
				      base  => $params->{base},
				      depth => $params->{prof},
				      num   => $params->{numero},
				      dir   => 0
				     );
if ($spider->run){
  printf "Id: %s\n", $spider->id;
}
