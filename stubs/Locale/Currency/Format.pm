# STUB: Locale::Currency::Format is not in nixpkgs
package Locale::Currency::Format;
use strict;
use warnings;
use Exporter 'import';

our $VERSION = '999.0';
our @EXPORT_OK = qw(currency_format currency_symbol decimal_precision FMT_SYMBOL FMT_COMMON FMT_NAME FMT_STANDARD);

use constant FMT_SYMBOL   => 1;
use constant FMT_COMMON   => 2;
use constant FMT_NAME     => 3;
use constant FMT_STANDARD => 4;

sub currency_format { $_[1] // '' }
sub currency_symbol { '$' }
sub decimal_precision { 2 }

1;
