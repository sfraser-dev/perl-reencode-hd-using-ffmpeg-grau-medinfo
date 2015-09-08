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

my $grauVRTexe;
my $vidName;
my @probeArr;
my @splitter;
my $timeDurationSecs;
my $videoFrameCount;
my $fps;
my $timeDurationMilliSecsMI;
my $timeDurationSecsMI;
my $videoFrameCountMI;
my $fpsMI;
my $fudgeFactor;
my $fpsFudge;

$grauVRTexe = "C:\\VisualWorks\\Projects\\ExxonMobilTues\\Cable_Installation\\Cable_G2\\Cable_Lay\\DATA_20150816095837094\\GrauRepairTool\\videorepair2\\movdump.exe";
#$vidName="20150816095837094\@DVR-02_Ch1.mp4";
$fudgeFactor=0.968;

$fout = "mylog.log";
open ($fh_out, ">", $fout) || die "Couldn't open '".$fout."'for writing because: ".$!;


find( \&mp4Wanted, '.'); 
foreach my $mp4Name (@content) {
	
	($name,$dir,$ext) = fileparse($mp4Name,'\..*');
	$filePath = cwd();
	say $fh_out "$mp4Name";

	# MediaInfo get duration in seconds
	#$timeDurationMilliSecsMI = `mediainfo --Output=General;%Duration% $vidName`;
	#$timeDurationSecsMI = $timeDurationMilliSecsMI / 1000;
	#chomp $timeDurationSecsMI;
	#say "Duration = $timeDurationSecsMI secs";

	# MediaInfo get number of frames
	#$videoFrameCountMI = `mediainfo -f "--Inform=Video;%FrameCount%" $vidName`;
	#chomp $videoFrameCountMI;
	#say "Framecount = $videoFrameCountMI frames";

	# MediaInfo target fps
	#$fpsMI = $videoFrameCountMI / $timeDurationSecsMI;
	#chomp $fpsMI;
	#say "Target frames per second = $fpsMI fps";

	# Fudge factor
	#$fpsFudge = $fpsMI / $fudgeFactor;
	#chomp $fpsFudge;
	#say "Fudged target frames per second = $fpsFudge fps";

	# Run the Grau Video Repair Tool
	#system("$grauVRTexe -atomdump -i $vidName -o grauVRT.mp4 -entropy 65536 -start 0 -stop 100 -fps $fpsFudge -nfd -noctts");
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
