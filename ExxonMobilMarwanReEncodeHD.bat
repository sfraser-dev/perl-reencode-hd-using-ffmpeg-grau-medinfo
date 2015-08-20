@echo off

SET CONTAINER_EXTN=mp4
SET LOG_FILE="reEncode.log"
IF EXIST %LOG_FILE% (
    del %LOG_FILE%
)
:: Recursively search for media containers, call function ffmpegReEncode on each container
for /f "delims=" %%f in ('dir "*.%CONTAINER_EXTN%" /s/b') do @call:ffmpegReEncode "%%f"
goto:eof

:: Function to re-encode HD video (1920x1080) using FFMPEG
:ffmpegReEncode
:: Resolving filenames
SET THE_ORIGINAL_NAME="%~f1"
SET THE_DRIVE_LETTER=%~d1
SET THE_PATH=%~p1
SET THE_FILE=%~n1
SET THE_EXTN=%~x1
SET THE_BACKUP_NAME="%THE_DRIVE_LETTER%%THE_PATH%%THE_FILE%%CONTAINER_EXTN%.orig"
SET THE_TEMP_NAME="%THE_DRIVE_LETTER%%THE_PATH%%THE_FILE%TempFFMPEG.%CONTAINER_EXTN%"
echo.%THE_TEMP_NAME%

:: Use FFPROBE to get the video width 
for /f "delims=" %%L in ('ffprobe -i %THE_ORIGINAL_NAME% -v error -of flat^=s^=_ -show_entries stream^=width') do SET THE_VIDEO_WIDTH=%%L
:: Get just the width value from THE_VIDEO_WIDTH (ie: remove the first 23 characters)
SET THE_VIDEO_WIDTH=%THE_VIDEO_WIDTH:~23%

if "%THE_VIDEO_WIDTH%" == "1920" (
    echo.is1920
    :: FFMPEG re-encode to a temporary filename
    ffmpeg -y -i %THE_ORIGINAL_NAME% -c:v libx264 -c:a libmp3lame %THE_TEMP_NAME%
    :: Backup the original video
    move /Y %THE_ORIGINAL_NAME% %THE_BACKUP_NAME%
    :: Move the FFMPEG converted video to the original name
    move /Y %THE_TEMP_NAME% %THE_ORIGINAL_NAME%
    echo.Converted: %THE_ORIGINAL_NAME% >> %LOG_FILE%
)

if "%THE_VIDEO_WIDTH%" NEQ "1920" (
    echo.not120
    echo.Not converted: %THE_ORIGINAL_NAME% >> %LOG_FILE%
)
goto:eof
