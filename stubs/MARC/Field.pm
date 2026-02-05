# STUB: MARC::Field is not in nixpkgs
package MARC::Field;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless { tag => $_[1], subfields => [] }, shift }
sub tag { shift->{tag} }
sub indicator { '' }
sub subfield { '' }
sub subfields { () }
sub data { '' }
sub as_string { '' }
sub clone { shift->new('000') }
sub update { }
sub replace_with { }
sub delete_subfield { }
sub add_subfields { }

1;
