#!/usr/bin/perl -w
use strict;
use warnings;
use feature qw(say);
use File::Find; 
use File::Basename;
use Cwd;

my $baseDirName = "G:\\VisualWorks\\groupings\\";
my $newDirName;
my $fullName;

#for (my $i=0; $i<=50000; $i+=1000){
#	 $newDirName = "aa$i";
#	 $fullName=$baseDirName.$newDirName;
#	 system("mkdir $fullName");
#}

