# STUB: MARC::File::XML is not in nixpkgs
package MARC::File::XML;
use strict;
use warnings;
use MARC::Record;

our $VERSION = '999.0';

sub new { bless {}, shift }
sub decode { MARC::Record->new }
sub encode { '' }
sub record { MARC::Record->new }
sub header { '' }
sub footer { '' }

1;
