# STUB: HTTP::OAI::ListSets for inheritance support
package HTTP::OAI::ListSets;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless { items => [] }, shift }
sub next { }
sub set { }
sub resumptionToken { }
sub toDOM { }

1;
