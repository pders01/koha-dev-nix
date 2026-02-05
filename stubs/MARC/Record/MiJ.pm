# STUB: MARC::Record::MiJ is not in nixpkgs
package MARC::Record::MiJ;
use strict;
use warnings;
use MARC::Record;

our $VERSION = '999.0';

sub new { bless {}, shift }
sub to_mij { '{}' }
sub from_mij { MARC::Record->new }

1;
