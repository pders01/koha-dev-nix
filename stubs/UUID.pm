# STUB: UUID is not in nixpkgs (use Data::UUID instead if possible)
package UUID;
use strict;
use warnings;
use Exporter 'import';

our $VERSION = '999.0';
our @EXPORT_OK = qw(uuid uuid4);

sub uuid { '00000000-0000-0000-0000-000000000000' }
sub uuid4 { '00000000-0000-0000-0000-000000000000' }
sub generate { '00000000-0000-0000-0000-000000000000' }

1;
