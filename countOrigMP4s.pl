#!/usr/bin/perl -w
use strict;
use warnings;
use feature qw(say);
use File::Find; 
use File::Basename;
use Cwd;

my $fileCounter=0;
my @content;

my $name;
my $fileDir;
my $ext;
my $cwdPath;
my $fullPath;

my $fout;
my $fh_out;

$fout = "countOrigMP4s.log";
open ($fh_out, ">", $fout) || die "Couldn't open '".$fout."'for writing because: ".$!;


find( \&mp4Wanted, '.'); 
foreach my $vidName (@content) {
    ($name,$fileDir,$ext) = fileparse($vidName,'\..*');
	$fileDir=~s/\.//g;
	$fileDir=~s/\//\\/g;
	$cwdPath = cwd();
	$cwdPath=~s/\//\\/g;
    $fullPath="$cwdPath$fileDir$name$ext";
	$fullPath=~s/\//\\/g;

    if ( ($vidName !~ /Ch2/) && ($vidName !~ /orig/) ){
        say $fh_out "$name$ext";
        $fileCounter+=1;
    }
}
say "mp4 count = $fileCounter";
close $fh_out;
exit;

sub mp4Wanted {
    if ($File::Find::name =~ /\.mp4/){
        push @content, $File::Find::name;
    }
    return;
}
