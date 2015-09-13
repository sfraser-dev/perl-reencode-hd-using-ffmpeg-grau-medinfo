Use FFPROBE to get the width of video. If width is 1920, re-encode the video with FFMPEG. Re-name original with .orig extension, name re-encoded video what the original was called so it gets loaded in Visual Review and Edit.

Adding in code from Bill that analyses the mp4's and outputs this information to an excel file. 

Creating a Perl file to prepare mp4's for "fixing" in Grau's Video Repair Tool. Using MediaInfo (need .exe and .dll in the same folder) to get video information as it returns the number of frames much faster than FFMPEG. 

Categorise videos into bins based on the number of frames that they have. Need to use the Grau Video Repair Tools GUI as there is a licensing issue with using its command line (see the log htm file it generates).

Upload log files from this binning process and also for the FFMPEG re-encoing process (for parsing later on, so the fixed videos using Grau VRT can be moved back to the datasets / folders that they came from). Had to use the GUI of Grau VRT so needed to bin / categorise the videos beforehand for easy batch processing. 

I have FFMPEG re-encoded the videos with less than 44000 frames (< 30 mins) as it was reported that these are OK (can be fixed with an FFMPEG re-encode). I can manually Grau VRT them later if not.

Have also converted the SD videos in the datasets to HD1080 as the SD was reported as being all OK. It is a requirement that they must have HD, so would like to be able to Grau VRT (ideal), if not FFMPEG re-encode, if not upscale the SD to HD (they took SD and HD at the same time, the SD was fine, there were jerky and timestamp issues with the HD).
