# STUB: HTTP::OAI::Record for inheritance support
package HTTP::OAI::Record;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless {}, shift }
sub header { HTTP::OAI::Header->new }
sub metadata { }
sub about { }
sub toDOM { }

1;
