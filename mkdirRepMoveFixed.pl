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
my @content;
my $originalFileNameFullPath;


find( \&fileWanted, '.'); 
foreach my $vidName (@content) {
	($name,$fileDir,$ext) = fileparse($vidName,'\..*');
	$fileDir=~s/\.//g;
	$fileDir=~s/\//\\/g;
	$cwdPath = cwd();
	$cwdPath=~s/\//\\/g;
    if ( $vidName !~ /orig/  ){
		$originalFileNameFullPath="$cwdPath$fileDir$name$ext";
		$originalFileNameFullPath=~s/\//\\/g;
        if (-d "repaired"){
            say "dir exists";
        }
        else {
            say "creating directory";
            system("mkdir repaired");
        }
	    say "$originalFileNameFullPath";
        system("move \/Y $originalFileNameFullPath repaired\/");
    }
}
exit;

sub fileWanted {
    if ($File::Find::name =~ /mp4/){
        push @content, $File::Find::name;
    }
    return;
}
