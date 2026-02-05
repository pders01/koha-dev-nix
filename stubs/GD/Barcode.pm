# STUB: GD::Barcode is not in nixpkgs
package GD::Barcode;
use strict;
use warnings;

our $VERSION = '999.0';

sub new { bless {}, shift }
sub plot { }
sub barcode { '' }

package GD::Barcode::QRcode;
sub new { bless {}, shift }
sub plot { }
sub barcode { '' }

package GD::Barcode::Code128;
sub new { bless {}, shift }
sub plot { }
sub barcode { '' }

package GD::Barcode::Code39;
sub new { bless {}, shift }
sub plot { }
sub barcode { '' }

package GD::Barcode::UPCE;
sub new { bless {}, shift }
sub plot { }
sub barcode { '' }

package GD::Barcode::EAN13;
sub new { bless {}, shift }
sub plot { }
sub barcode { '' }

1;
