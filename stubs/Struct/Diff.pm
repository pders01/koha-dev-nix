# STUB: Struct::Diff is not in nixpkgs
# See TODO.md
package Struct::Diff;
use strict;
use warnings;
use Exporter 'import';

our $VERSION = '999.0';
our @EXPORT_OK = qw(diff patch valid_diff);

sub diff { {} }
sub patch { $_[0] }
sub valid_diff { 1 }

1;
