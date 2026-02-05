# STUB: HTTP::OAI::ResumptionToken for inheritance support
package HTTP::OAI::ResumptionToken;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless {}, shift }
sub resumptionToken { shift->{resumptionToken} }
sub cursor { shift->{cursor} }
sub completeListSize { shift->{completeListSize} }
sub expirationDate { shift->{expirationDate} }

1;
