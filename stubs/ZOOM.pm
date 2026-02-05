# STUB: This module is a placeholder for LSP/IDE support only.
# The real Net::Z3950::ZOOM requires the YAZ library which is not in nixpkgs.
# See TODO.md for details.
package ZOOM;
use strict;
use warnings;

our $VERSION = '999.0';

# Stub classes that Koha references
package ZOOM::Connection;
sub new { bless {}, shift }
sub search { }
sub option { }
sub destroy { }
sub errmsg { '' }
sub errcode { 0 }
sub diagset { '' }

package ZOOM::Query::CCL2RPN;
sub new { bless {}, shift }

package ZOOM::Query::CQL;
sub new { bless {}, shift }

package ZOOM::Query::PQF;
sub new { bless {}, shift }

package ZOOM::ResultSet;
sub new { bless {}, shift }
sub size { 0 }
sub record { }
sub destroy { }

package ZOOM::Record;
sub new { bless {}, shift }
sub raw { '' }
sub render { '' }

package ZOOM::Event;
use constant ZEND => 0;
use constant NONE => 0;
use constant CONNECT => 1;
use constant SEND_DATA => 2;
use constant RECV_DATA => 3;
use constant TIMEOUT => 4;
use constant UNKNOWN => 5;
use constant SEND_APDU => 6;
use constant RECV_APDU => 7;
use constant RECV_RECORD => 8;
use constant RECV_SEARCH => 9;
sub new { bless {}, shift }

1;
