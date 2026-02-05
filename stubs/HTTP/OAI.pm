# STUB: HTTP::OAI is not in nixpkgs
package HTTP::OAI;
use strict;
use warnings;

our $VERSION = '999.0';

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

package HTTP::OAI::Record;
sub new { bless {}, shift }
sub header { HTTP::OAI::Header->new }
sub metadata { }

package HTTP::OAI::Header;
sub new { bless {}, shift }
sub identifier { '' }
sub datestamp { '' }
sub status { '' }

package HTTP::OAI::Metadata::OAI_DC;
sub new { bless {}, shift }
sub dc { {} }

package HTTP::OAI::SAXHandler;
sub new { bless {}, shift }

package HTTP::OAI::Repository;
sub new { bless {}, shift }
sub Identify { HTTP::OAI::Response->new }
sub ListMetadataFormats { HTTP::OAI::Response->new }
sub ListSets { HTTP::OAI::Response->new }
sub ListIdentifiers { HTTP::OAI::Response->new }
sub ListRecords { HTTP::OAI::Response->new }
sub GetRecord { HTTP::OAI::Response->new }

1;
