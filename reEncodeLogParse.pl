#!/usr/bin/perl -w
use strict;
use warnings;
use feature qw(say);
use File::Find; 
use File::Basename;
use Cwd;

my $vidName;
my $vidOriginalLocation;
my $slotDir;

my $fileName = "test.log";
open my $fh, $fileName or die "Could not open file: $!";

while (my $line = <$fh>) {
	chomp $line;
	my @arr = split /=/, $line;
	$vidName = $arr[0];
	$vidOriginalLocation = $arr[1];
	$slotDir = $arr[2];
	say "$vidName\n$vidOriginalLocation\n$slotDir\n";

	# grau repaired output folder

	# rename: move $slotName$vidName $slotName$newName
	
	# move $slotDir$newName $vidOriginalLocation
	
}
close $fh;
