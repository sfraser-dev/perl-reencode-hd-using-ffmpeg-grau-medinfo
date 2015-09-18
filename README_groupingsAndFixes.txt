Groupings are based on the number of frames in a video.

For groupings aa36000 and less, only FFMPEG processing was carried out. For FFMPEG processing, the original video gets ".orig" added to its extension and the FFMPEG processed video assumes the name of the original video that was in the dataset.

For groupings aa38000, aa42000 and aa43000, FFMPEG and Grau Video Repair Tool (GVRT) processing was carried out (initially FFMPEG was performed, but this gave bad results so GVRT was used). The TESTrepairedFPS/ folders are the results from GVRT at differnt FPS targets. The closest in duration/length to the original was selected for the repaired/ folder (to eventually be copied back to the original dataset).

For groupings aa44000, aa45000, aa46000 and aa47000, only GVRT processing was carried out (as FFMPEG processing wasn't fixing the videos).

In all groupings, the "best" processed video was then put into the repaired/ folder in preperation to be copied back to their original datasets.
