Use FFPROBE to get the width of video. If width is 1920, re-encode the video with FFMPEG. Re-name original with .orig extension, name re-encoded video what the original was called so it gets loaded in Visual Review and Edit.

Adding in code from Bill that analyses the mp4's and outputs this information to an excel file. 

Creating a Perl file to prepare mp4's for "fixing" in Grau's Video Repair Tool. Using MediaInfo (need .exe and .dll in the same folder) to get video information as it returns the number of frames much faster than FFMPEG. 
