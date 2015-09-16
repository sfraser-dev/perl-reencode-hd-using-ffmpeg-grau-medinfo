#!/usr/bin/perl -w
use strict;
use warnings;
use feature qw(say);
use File::Find; 
use File::Basename;
use Cwd;
use List::MoreUtils qw{any};

# read log file contents into an array
my $origLogFile = "mp4sOrig.log";
open (my $fh_origLog, "<", $origLogFile) || die "Couldn't open '".$origLogFile."'for writing because: ".$!;
chomp(my @origLog = <$fh_origLog>);
close $fh_origLog;
#print (join("\n", @origLog));


# read log file contents into an array
my $fixLogFile = "compareParseFix.log";
open (my $fh_fixLog, "<", $fixLogFile) || die "Couldn't open '".$fixLogFile."'for writing because: ".$!;
chomp(my @fixLog = <$fh_fixLog>);
close $fh_fixLog;
#print (join("\n", @fixLog));

my @splitter;
my $num;

# format the array to just numbers before "@"
my @origNum = @origLog;
for my $i (0 .. $#origLog) {
    @splitter = split(/\@/, $origLog[$i]);
    $origNum[$i] = $splitter[0];
}

# format the array to just numbers before "@"
my @fixNum = @fixLog;
for my $i (0 .. $#fixLog) {
    @splitter = split(/\@/, $fixLog[$i]);
    $fixNum[$i] = $splitter[0];
}

my $resultLogFile = "compareLogs.log";
open (my $fh_resultLog, ">", $resultLogFile) || die "Couldn't open '".$resultLogFile."'for writing because: ".$!;
my $result="";
for my $i (0 .. $#origNum) {
    $result="NNO";
    for my $j (0 .. $#fixNum) {
        if ($origNum[$i] == $fixNum[$j]){
            $result="YYES";
        }
    }
    say $fh_resultLog "$origNum[$i]=$result"
}

close $fh_resultLog;
exit;
