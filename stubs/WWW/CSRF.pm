# STUB: WWW::CSRF is not in nixpkgs
package WWW::CSRF;
use strict;
use warnings;
use Exporter 'import';

our $VERSION = '999.0';
our @EXPORT_OK = qw(generate_csrf_token check_csrf_token CSRF_OK);

use constant CSRF_OK => 1;

sub generate_csrf_token { 'stub_csrf_token' }
sub check_csrf_token { CSRF_OK }

1;
