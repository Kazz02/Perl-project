#!/usr/bin/perl
use strict;
use warnings;

# Configuration
my $log_file = 'access.log';

# Data structures to hold statistics
my %ip_counts;
my %status_counts;
my %url_counts;

# Open the log file
open(my $fh, '<', $log_file) or die "Could not open file '$log_file' $!";

print "Analyzing $log_file...\n";

while (my $line = <$fh>) {
    chomp $line;
    
    # Regex to parse Common Log Format
    # Format: IP - - [Date] "Method URL Protocol" Status Size
    if ($line =~ /^(\S+) \S+ \S+ \[.*?\] "(\S+) (\S+) \S+" (\d+) (\S+)/) {
        my $ip = $1;
        my $method = $2;
        my $url = $3;
        my $status = $4;
        my $size = $5;

        # Update counters
        $ip_counts{$ip}++;
        $status_counts{$status}++;
        $url_counts{$url}++;
    }
}

close($fh);

# Prints results 

print "\n--- Report ---\n";

print "\nTop 5 IP Addresses:\n";
my $ip_limit = 5;
foreach my $ip (sort { $ip_counts{$b} <=> $ip_counts{$a} } keys %ip_counts) {
    printf "  %-15s : %d requests\n", $ip, $ip_counts{$ip};
    $ip_limit--;
    last if $ip_limit == 0;
}

print "\nStatus Codes:\n";
foreach my $status (sort keys %status_counts) {
    printf "  Code %-4s : %d times\n", $status, $status_counts{$status};
}

print "\nMost Requested URLs:\n";
my $limit = 5;
foreach my $url (sort { $url_counts{$b} <=> $url_counts{$a} } keys %url_counts) {
    printf "  %-30s : %d requests\n", $url, $url_counts{$url};
    $limit--;
    last if $limit == 0;
}
