#!/usr/bin/perl -w
use strict;
use warnings;
use feature qw(say);
use File::Find; 
use File::Basename;
use Cwd;

my $name;
my $dir;
my $ext;
my $filePath;
my $fileDataset;
my $fileSubProject;
my $filePathName;
my @content;
my $fout;
my $fh_out;

my $duration = "";
my $durationsecs = "";
my $framecount = "";
my $fps = "";
my $encoded_date = "";

$fout = "DurationFrames.csv";
open ($fh_out, ">", $fout) || die "Couldn't open '".$fout."'for writing because: ".$!;

# Write a file header
say $fh_out "Filename, Frame Count, Duration, Seconds, Framerate (fps)";

# find .mp4 files recursively from this directory
my $filecount=0;
find( \&mp4Wanted, '.');
foreach my $mp4Name (@content) {
	# file path and name
	($name,$dir,$ext) = fileparse($mp4Name,'\..*');
	$filePath = cwd();
	$fileSubProject = substr $dir, 2;
	$fileDataset = "$filePath/$fileSubProject";
	#$filePathName = "$filePath/.../$name$ext";
	$filePathName = "$fileDataset/.../$name$ext";
	$filecount ++;
	$duration = "";
	$encoded_date = "";
    
	#Use MediaInfo to get duration as formatted text (String3), duration in milliseconds, and number of frames
	$duration = `mediainfo --Output=General;%Duration/String3% $mp4Name`;
	$durationsecs = `mediainfo --Output=General;%Duration% $mp4Name`;
	$framecount = `mediainfo -f "--Inform=Video;%FrameCount%" $mp4Name`;
	chomp $duration;
	chomp $durationsecs;
	chomp $framecount;

	#Calculate duration in seconds
	$durationsecs = $durationsecs/1000;
	
	#Calculate frames per second to two decimal places
	$fps = sprintf("%0.2f", $framecount / $durationsecs);
	
	
	# write to output file
	say $fh_out "$name,$framecount,$duration,$durationsecs,$fps";
	say "$filePathName ... done";
	
    
}
close $fh_out;
close $fout;
exit;

# subroutine to recursively find all files with ".mp4" extension
sub mp4Wanted {
    if ($File::Find::name =~ /.mp4/){
        push @content, $File::Find::name;
    }
    return;
}


