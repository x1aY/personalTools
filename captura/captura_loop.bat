@echo off

set cli=D:/captura/captura-cli

set baseOutputDir=G:/downloads/captura/

%cli% list

:: 声音源

echo.
echo PLEASE ensure your speaker first!!!

:: 处理录屏源

echo.
echo input handle or the default handle will be the whole desktop:
:: set handle=%1
set /p handle= 

set mySource=win:%handle%

if "%handle%" == "" ( 
	set mySource=desktop
	)

echo video source : %mySource%

:: 处理视频长度

echo.
echo input video length of minutes or the default length is 120 minutes:

:: set sec=%2
set /p min= 

if "%min%" == "" ( 
	set min=120
	)

set /a sec=%min%*60

echo each video length : %min% minutes, %sec% seconds
echo.

:: 视频名称前缀

echo.
echo input each video prefix or the default prefix is 'captura':

set /p videoPrefix= 

if "%videoPrefix%" == "" ( 
	set videoPrefix=captura
	)

echo each video prefix : %videoPrefix%
echo.

:: 视频名称前缀

echo.
echo input loop times or the default loop times is 2:

set /p count= 

if "%count%" == "" ( 
	set /a count=2
	)

echo video loop times : %count%
echo.


:: 循环录屏

setlocal enabledelayedexpansion

SET /A "index=1"

:while
if %index% LEQ %count% (
	SET videoName=%videoPrefix%_%Date:~0,4%%Date:~5,2%%Date:~8,2%_%index%.mp4
	echo.
	echo curr video index %index%
	echo video path: %baseOutputDir%!videoName!
	
	%cli% start --source %mySource% --speaker=1 --encoder ffmpeg:0 -r 30 --length %sec% --file %baseOutputDir%!videoName!

	echo.
	SET /A "index=index + 1"
	goto :while
)

pause