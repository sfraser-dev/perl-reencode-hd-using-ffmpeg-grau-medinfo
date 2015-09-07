#!/usr/bin/perl -w
use strict;
use warnings;
use feature qw(say);

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
$vidName="20150816095837094\@DVR-02_Ch1.mp4";
$fudgeFactor=0.968;

# FFMPEG get duration in seconds
#@probeArr=`ffprobe -v quiet -show_format $vidName`;
#foreach my $i (@probeArr){
#		chomp $i;
#        if ($i =~ "duration"){
#            @splitter = split /=/, $i;
#            $timeDurationSecs = $splitter[1];
#        }
#}
#say "Duration = $timeDurationSecs seconds";

# MediaInfo get duration in seconds
$timeDurationMilliSecsMI = `mediainfo --Output=General;%Duration% $vidName`;
$timeDurationSecsMI = $timeDurationMilliSecsMI / 1000;
chomp $timeDurationSecsMI;
say "Duration = $timeDurationSecsMI secs";

# FFMPEG get number of frames
#$videoFrameCount=0;
#@probeArr=`ffprobe -v quiet -show_frames -pretty -select_streams v:0 $vidName`;
#foreach my $i (@probeArr){
#	chomp $i;
#    if ($i =~ '\[\/FRAME'){
#        $videoFrameCount++;
#    }
#}
#say "Frame count = $videoFrameCount frames"; 

# MediaInfo get number of frames
$videoFrameCountMI = `mediainfo -f "--Inform=Video;%FrameCount%" $vidName`;
chomp $videoFrameCountMI;
say "Framecount = $videoFrameCountMI frames";

# FFMPEG target FPS
#$fps = $videoFrameCount / $timeDurationSecs;
#say "Target frames per second = $fps fps";

# MediaInfo target fps
$fpsMI = $videoFrameCountMI / $timeDurationSecsMI;
chomp $fpsMI;
say "Target frames per second = $fpsMI fps";

# Fudge factor
$fpsFudge = $fpsMI / $fudgeFactor;
chomp $fpsFudge;
say "Fudged target frames per second = $fpsFudge fps";

# Run the Grau Video Repair Tool
#system("$grauVRTexe -atomdump -i $vidName -o grauVRT.mp4 -entropy 65536 -start 0 -stop 100 -fps $fpsFudge -nfd -noctts");
