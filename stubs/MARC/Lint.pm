# STUB: MARC::Lint is not in nixpkgs
package MARC::Lint;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless { warnings => [] }, shift }
sub check_record { }
sub warnings { () }
sub clear_warnings { }

1;
