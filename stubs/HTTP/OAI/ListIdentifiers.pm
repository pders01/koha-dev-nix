# STUB: HTTP::OAI::ListIdentifiers for inheritance support
package HTTP::OAI::ListIdentifiers;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless { items => [] }, shift }
sub next { }
sub identifier { }
sub resumptionToken { }
sub toDOM { }

1;
