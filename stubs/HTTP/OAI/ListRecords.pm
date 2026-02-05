# STUB: HTTP::OAI::ListRecords for inheritance support
package HTTP::OAI::ListRecords;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless { items => [] }, shift }
sub next { }
sub record { }
sub resumptionToken { }
sub toDOM { }

1;
