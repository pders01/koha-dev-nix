# STUB: Authen::CAS::Client is not in nixpkgs
package Authen::CAS::Client;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless { cas_url => $_[1] // '' }, shift }
sub login_url { '' }
sub logout_url { '' }
sub validate { Authen::CAS::Client::Response->new }
sub service_validate { Authen::CAS::Client::Response->new }
sub proxy_validate { Authen::CAS::Client::Response->new }

package Authen::CAS::Client::Response;
sub new { bless { is_success => 0 }, shift }
sub is_success { shift->{is_success} }
sub is_failure { !shift->is_success }
sub user { '' }
sub doc { }

1;
