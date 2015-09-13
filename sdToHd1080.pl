#!/usr/bin/perl -w
use strict;
use warnings;
use feature qw(say);
use File::Find; 
use File::Basename;
use Cwd;

my $name;
my $fileDir;
my $ext;
my $cwdPath;
my $fout;
my $fh_out;
my @content;
my $originalFileNameFullPath;
my $tempFileNameFullPath;
my $newFileNameFullPath;

$fout = "sdToHd1080.log";
open ($fh_out, ">", $fout) || die "Couldn't open '".$fout."'for writing because: ".$!;

find( \&fileWanted, '.'); 
foreach my $vidName (@content) {
	($name,$fileDir,$ext) = fileparse($vidName,'\..*');
	$fileDir=~s/\.//g;
	$fileDir=~s/\//\\/g;
	$cwdPath = cwd();
	$cwdPath=~s/\//\\/g;
	if ( ($vidName =~ /Ch2/) && (($ext =~ /\.mp4/) || ($ext =~ /\.orig/)) ){
		$originalFileNameFullPath="$cwdPath$fileDir$name$ext";
		$originalFileNameFullPath=~s/\//\\/g;
		$ext=~s/\.//g;
		$tempFileNameFullPath="$cwdPath"."$fileDir$name$ext"."TempFFMPEGsd2Hd\.mp4";
		$newFileNameFullPath="$cwdPath"."$fileDir$name$ext"."\.1080pb";
		say $fh_out "$originalFileNameFullPath";
		system("ffmpeg -y -i $originalFileNameFullPath -c:v libx264 -b:v 2000k -s 1920x1080 -aspect 1920:1080 -c:a libmp3lame -b:a 64k $tempFileNameFullPath");
		system("move /Y $tempFileNameFullPath $newFileNameFullPath");
	}
}

close $fh_out;
close $fout;
exit;

# Look for filenames with "mp4" anywhere in them (not necessarily in the extension)
sub fileWanted {
    if ($File::Find::name =~ /mp4/){
        push @content, $File::Find::name;
    }
    return;
}
