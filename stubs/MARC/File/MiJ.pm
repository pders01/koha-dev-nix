# STUB: MARC::File::MiJ (MARC-in-JSON) is not in nixpkgs
package MARC::File::MiJ;
use strict;
use warnings;
use MARC::Record;

our $VERSION = '999.0';

sub new { bless {}, shift }
sub decode { MARC::Record->new }
sub encode { '{}' }
sub to_mij { '{}' }

1;
