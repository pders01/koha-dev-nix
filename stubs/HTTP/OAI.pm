# STUB: HTTP::OAI is not in nixpkgs
# Note: Base classes for inheritance are in separate .pm files
package HTTP::OAI;
use strict;
use warnings;

our $VERSION = '999.0';

# Load separate stub files for inheritance support
use HTTP::OAI::Repository;
use HTTP::OAI::SAXHandler;
use HTTP::OAI::ListRecords;
use HTTP::OAI::ListIdentifiers;
use HTTP::OAI::ListSets;
use HTTP::OAI::ListMetadataFormats;
use HTTP::OAI::ResumptionToken;
use HTTP::OAI::Identify;
use HTTP::OAI::GetRecord;
use HTTP::OAI::Record;

package HTTP::OAI::Harvester;
sub new { bless {}, shift }
sub repository { }
sub ListRecords { HTTP::OAI::Response->new }
sub ListIdentifiers { HTTP::OAI::Response->new }
sub ListSets { HTTP::OAI::Response->new }
sub GetRecord { HTTP::OAI::Response->new }
sub Identify { HTTP::OAI::Response->new }

package HTTP::OAI::Response;
sub new { bless { items => [] }, shift }
sub is_error { 0 }
sub errors { () }
sub next { }
sub toDOM { }

package HTTP::OAI::Header;
sub new { bless {}, shift }
sub identifier { '' }
sub datestamp { '' }
sub status { '' }

1;
