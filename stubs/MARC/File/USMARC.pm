# STUB: MARC::File::USMARC is not in nixpkgs
package MARC::File::USMARC;
use strict;
use warnings;
use MARC::Record;

our $VERSION = '999.0';

sub new { bless {}, shift }
sub decode { MARC::Record->new }
sub encode { '' }
sub next { }
sub in { bless {}, shift }

1;
