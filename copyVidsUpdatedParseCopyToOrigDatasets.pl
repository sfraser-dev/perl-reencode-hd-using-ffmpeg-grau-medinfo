#!/usr/bin/perl -w
use strict;
use warnings;
use feature qw(say);
use File::Find; 
use File::Basename;
use Cwd;

# original video directory (full path)
my $vidOriginalDir;
# name of the video, eg: XXX.mp4 (same for both original and repaired)
my $vidName;
# original video name (full path)
my $vidOriginal;
# fixed video name (full path)
my $vidFixed;
# move the "broken" original video to a new name (XXXmp4.original1)
my $vidMoveName;

my $fileIn = "copyVidsUpdated.log";
open (my $fh_in, "<", $fileIn) || die "Could not open file: $!";

my $fileOut = "countParseCopyMP4sToOrigDatasets.log";
open (my $fh_out, ">", $fileOut) || die "Couldn't open '".$fileOut."'for writing because: ".$!;

# read the copy log to know which dataset a repaired file belongs to
while (my $line = <$fh_in>) {
	chomp $line;
    # spilt each line of the copy log file I created at "=" signs
	my @arr = split /=/, $line;
	$vidName = $arr[0];
    $vidOriginalDir="$arr[1]";
	$vidOriginal = "$arr[1]$arr[0]";
	$vidFixed = $arr[2]."repaired\\"."$arr[0]";
    $arr[0] =~ s/\.mp4/mp4/g;
    $vidMoveName = "$arr[1]$arr[0]"."\.original1";
    chomp $vidName;
    chomp $vidOriginal;
    chomp $vidFixed;
    chomp $vidMoveName;

    #say $fh_out "Original DIR loctaion= $vidOriginalDir";
    #say $fh_out "Original video name = $vidName";
    #say $fh_out "Original name full path = $vidOriginal";
    #say $fh_out "Fixed name full path = $vidFixed";
    #say $fh_out "Backup name full path = $vidMoveName\n";
    say "$vidFixed=$vidMoveName";
    say $fh_out "$vidFixed=$vidMoveName";

	# rename original video XXX.mp4 to XXXmp4.original1 as a backup
    system("move \/Y $vidOriginal $vidMoveName");
	
	# copy the repaired file the original dataset (this repaired file has the original name)
    system("copy \/Y $vidFixed $vidOriginalDir");
}

close $fh_in;
close $fh_out;
exit;
