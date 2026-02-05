#!/usr/bin/env perl
use strict;
use warnings;
use File::Find;
use FindBin qw($RealBin);

my %missing;
my %failed;
my $total = 0;
my $ok = 0;

# Use KOHA_SRC env var (required)
my $koha_src = $ENV{KOHA_SRC} or die "KOHA_SRC environment variable is not set\n";
my $stubs_dir = "$RealBin/../stubs";

die "Koha source not found at $koha_src\n" unless -d "$koha_src/Koha";

# Find all .pm files in Koha and C4
my @files;
find(sub {
    return unless /\.pm$/;
    return if $File::Find::dir =~ /\/\.git|\/blib\/|\/t\//;
    push @files, $File::Find::name;
}, "$koha_src/Koha", "$koha_src/C4");

my $file_count = scalar(@files);
my $current = 0;

for my $file (@files) {
    # Convert file path to module name
    my $mod = $file;
    $mod =~ s{^\Q$koha_src/\E}{};
    $mod =~ s{/}{::}g;
    $mod =~ s{\.pm$}{};

    $total++;
    $current++;

    # Progress indicator
    print "\r\033[KTesting $mod ($current/$file_count)...";

    my $output = `perl -I"$koha_src" -I"$stubs_dir" -e "use $mod" 2>&1`;

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

print "\r\033[K";  # Clear progress line

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
