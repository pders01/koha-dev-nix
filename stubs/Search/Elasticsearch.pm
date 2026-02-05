# STUB: Search::Elasticsearch is not in nixpkgs
package Search::Elasticsearch;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless {}, shift }
sub transport { }
sub cluster { Search::Elasticsearch::Client::Direct->new }
sub indices { Search::Elasticsearch::Client::Direct::Indices->new }
sub search { {} }
sub index { {} }
sub bulk { Search::Elasticsearch::Bulk->new }
sub delete { {} }
sub get { {} }
sub count { { count => 0 } }

package Search::Elasticsearch::Client::Direct;
sub new { bless {}, shift }
sub health { {} }

package Search::Elasticsearch::Client::Direct::Indices;
sub new { bless {}, shift }
sub exists { 0 }
sub create { {} }
sub delete { {} }
sub put_mapping { {} }
sub get_mapping { {} }
sub refresh { {} }

package Search::Elasticsearch::Bulk;
sub new { bless {}, shift }
sub index { }
sub flush { }

1;
