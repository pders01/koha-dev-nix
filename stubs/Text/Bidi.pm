# STUB: Text::Bidi is not in nixpkgs
package Text::Bidi;
use strict;
use warnings;
use Exporter 'import';

our $VERSION = '999.0';
our @EXPORT_OK = qw(log2vis);

sub new { bless {}, shift }
sub log2vis { $_[0] }

1;
