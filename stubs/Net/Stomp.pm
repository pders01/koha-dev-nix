# STUB: Net::Stomp is not in nixpkgs
package Net::Stomp;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless {}, shift }
sub connect { 1 }
sub disconnect { }
sub send { 1 }
sub subscribe { 1 }
sub unsubscribe { 1 }
sub receive_frame { }
sub can_read { 0 }
sub ack { 1 }
sub nack { 1 }

1;
