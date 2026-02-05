# STUB: MARC::Charset is not in nixpkgs
package MARC::Charset;
use strict;
use warnings;
use Exporter 'import';

our $VERSION = '999.0';
our @EXPORT_OK = qw(marc8_to_utf8 utf8_to_marc8);

sub new { bless {}, shift }
sub marc8_to_utf8 { $_[1] }
sub utf8_to_marc8 { $_[1] }
sub to_utf8 { $_[1] }

1;
