# STUB: HTTP::OAI::Identify for inheritance support
package HTTP::OAI::Identify;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless {}, shift }
sub repositoryName { }
sub baseURL { }
sub protocolVersion { }
sub adminEmail { }
sub earliestDatestamp { }
sub deletedRecord { }
sub granularity { }
sub compression { }
sub description { }
sub toDOM { }

1;
