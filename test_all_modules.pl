#!/usr/bin/env perl
use strict;
use warnings;
use File::Find;

my %missing;
my %failed;
my $total = 0;
my $ok = 0;

# Find all .pm files in Koha and C4
my @files;
find(sub {
    return unless /\.pm$/;
    return if $File::Find::dir =~ /\.git|blib|t\//;
    push @files, $File::Find::name;
}, '../koha/Koha', '../koha/C4');

for my $file (@files) {
    # Convert file path to module name
    my $mod = $file;
    $mod =~ s{^\.\./koha/}{};
    $mod =~ s{/}{::}g;
    $mod =~ s{\.pm$}{};

    $total++;

    my $output = `perl -I../koha -Istubs -e "use $mod" 2>&1`;

    if ($? == 0) {
        $ok++;
    } else {
        # Extract missing module if any
        while ($output =~ /Can't locate (\S+)\.pm/g) {
            my $m = $1;
            $m =~ s/\//\:\:/g;
            next if $m =~ /^(Koha|C4)::/;  # Skip internal modules
            $missing{$m}++;
        }
        $failed{$mod} = 1;
    }
}

print "=" x 60 . "\n";
print "RESULTS: $ok / $total modules loaded successfully\n";
print "=" x 60 . "\n";

if (%missing) {
    print "\nMISSING EXTERNAL MODULES:\n";
    for my $m (sort { $missing{$b} <=> $missing{$a} } keys %missing) {
        printf "  %-40s (needed by %d modules)\n", $m, $missing{$m};
    }
}

print "\nFailed modules: " . scalar(keys %failed) . "\n";
