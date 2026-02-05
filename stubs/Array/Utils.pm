# STUB: Array::Utils is not in nixpkgs
package Array::Utils;
use strict;
use warnings;
use Exporter 'import';

our $VERSION = '999.0';
our @EXPORT_OK = qw(unique array_minus array_diff intersect);

# Array::Utils takes array refs as arguments
sub unique { my %seen; grep { !$seen{$_}++ } @{$_[0]} }
sub array_minus {
    my ($arr1, $arr2) = @_;
    return () unless ref $arr1 eq 'ARRAY';
    return @$arr1 unless ref $arr2 eq 'ARRAY';
    my %h = map { $_ => 1 } @$arr2;
    return grep { !$h{$_} } @$arr1;
}
sub array_diff { array_minus(@_) }
sub intersect {
    my ($arr1, $arr2) = @_;
    return () unless ref $arr1 eq 'ARRAY' && ref $arr2 eq 'ARRAY';
    my %h = map { $_ => 1 } @$arr2;
    return grep { $h{$_} } @$arr1;
}

1;
