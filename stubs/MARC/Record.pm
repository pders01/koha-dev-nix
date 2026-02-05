# STUB: MARC::Record is not in nixpkgs
# See TODO.md
package MARC::Record;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless { fields => [] }, shift }
sub leader { '' }
sub append_fields { }
sub insert_fields_before { }
sub insert_fields_after { }
sub delete_fields { }
sub field { }
sub fields { () }
sub subfield { '' }
sub title { '' }
sub author { '' }
sub as_usmarc { '' }
sub as_formatted { '' }
sub clone { shift->new }
sub encoding { 'UTF-8' }
sub warnings { () }

1;
