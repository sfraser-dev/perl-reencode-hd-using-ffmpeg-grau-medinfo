#!/usr/bin/perl -w
use strict;
use warnings;
use feature qw(say);
use File::Find; 
use File::Basename;
use Cwd;

my $vidName;
my $vidOriginalLocation;
my $binDir;

my $binExist;
my $origExist;

my $vidCount=0;

my $fileIn = "copyVidsUpdated.log";
open (my $fh_in, "<", $fileIn) || die "Could not open file: $!";

my $fileOut = "countParseFixMP4s.log";
open (my $fh_out, ">", $fileOut) || die "Couldn't open '".$fileOut."'for writing because: ".$!;

while (my $line = <$fh_in>) {
    $vidCount+=1;
	chomp $line;
	my @arr = split /=/, $line;
	$vidName = $arr[0];
	$vidOriginalLocation = "$arr[1]$arr[0]";
	$binDir = $arr[2]."repaired\\"."$arr[0]";

    if (-e $binDir){
        $binExist="YYES";
    }
    else {
        $binExist="NNO";
    }
    if (-e $vidOriginalLocation){
        $origExist="YYES";
    }
    else {
        $origExist="NNO";
    }

    say $fh_out "$vidName";

    #say $fh_out "$vidName";
    #say $fh_out "$vidOriginalLocation";
    #say $fh_out "$origExist";
    #say $fh_out "$binDir";
    #say $fh_out "$binExist\n";

	# repaired output folder

	# rename: move $binName$vidName $binName$newName
	
	# move $binDir$newName $vidOriginalLocation
	
}
say "vidCount = $vidCount";
close $fh_in;
close $fh_out;
exit;
