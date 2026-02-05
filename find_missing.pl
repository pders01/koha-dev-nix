#!/usr/bin/env perl
use strict;
use warnings;

my %missing;

# Try loading many Koha modules and capture all missing deps
my @mods = qw(
  C4::Context C4::Biblio C4::Auth C4::Circulation C4::Items
  C4::Members C4::Reserves C4::Search C4::Letters C4::Overdues
  C4::Serials C4::Budgets C4::Koha C4::Charset C4::Languages
  C4::ClassSource C4::Installer C4::Accounts C4::Stats
  Koha::Patrons Koha::Items Koha::Biblios Koha::Libraries
  Koha::Database Koha::Object Koha::Objects Koha::Account
  Koha::I18N Koha::Token Koha::Auth::TwoFactorAuth
  Koha::Plugins Koha::REST::V1
);

for my $mod (@mods) {
  my $output = `perl -I../koha -Istubs -e "use $mod" 2>&1`;
  while ($output =~ /Can't locate (\S+)\.pm/g) {
    my $m = $1;
    $m =~ s/\//\:\:/g;
    $missing{$m} = 1 unless $m =~ /^(Koha|C4)::/;
  }
}

print "$_\n" for sort keys %missing;
