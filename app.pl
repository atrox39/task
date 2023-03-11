use Mojolicious::Lite -signatures;
use MongoDB;
use JSON;
use Data::Dumper;

my $client = MongoDB::MongoClient->new(
  host => 'mongodb://localhost:27017'
);
my $taskCollection = $client->ns('perl.tasks');

get '/' => sub ($c) {
  my @rows = $taskCollection->find->all;
  $c->render(json=>{
    'rows' => [@rows],
    'total' => scalar @rows,
  });
};

post '/' => sub ($c) {
  $taskCollection->insert_one({
    'title' => 'Test 1',
    'description' => 'Description 1'
  });
  $c->render(json=>{
    'rows' => [],
  });
};

app->start;
