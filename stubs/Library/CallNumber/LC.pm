# STUB: Library::CallNumber::LC is not in nixpkgs
package Library::CallNumber::LC;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless { call_number => $_[1] // '' }, shift }
sub normalize { '' }
sub call_number { shift->{call_number} }
sub components { () }

1;
