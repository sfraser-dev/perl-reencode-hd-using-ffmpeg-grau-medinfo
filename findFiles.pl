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

$fout = "findFiles.log";
open ($fh_out, ">", $fout) || die "Couldn't open '".$fout."'for writing because: ".$!;

find( \&fileWanted, '.'); 
foreach my $vidName (@content) {
	($name,$fileDir,$ext) = fileparse($vidName,'\..*');
	$fileDir=~s/\.//g;
	$fileDir=~s/\//\\/g;
	$cwdPath = cwd();
	$cwdPath=~s/\//\\/g;
    #if ( ($ext =~ /\.mp4/) || ($ext =~ /\.orig/) ){
		$originalFileNameFullPath="$cwdPath$fileDir$name$ext";
		$originalFileNameFullPath=~s/\//\\/g;
		say $fh_out "$originalFileNameFullPath";
    #}
}

close $fh_out;
close $fout;
exit;

# Look for filenames with "mp4" anywhere in them (not necessarily in the extension)
sub fileWanted {
    if ($File::Find::name =~ /orig/){
        push @content, $File::Find::name;
    }
    return;
}
