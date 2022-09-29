@echo off

set cli=D:/captura/captura-cli

set baseOutputDir=G:/downloads/captura/

echo author x1aY
echo.
echo visit https://github.com/MathewSachin/Captura/tree/master/docs/Cmdline to get more info
echo.
echo use command [%cli% help start] to custom last command
echo.

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

:: 处理视频名称

echo.
echo input video Name or the default name is 'captura':
set /p videoName=

set /a currHour=%time:~0,2%%time:~3,2%%time:~6,2%

set videoName=captura_%Date:~0,4%%Date:~5,2%%Date:~8,2%_%videoName%.mp4

echo video path: %baseOutputDir%%videoName%
echo.

%cli% start --source %mySource% --speaker=1 --encoder ffmpeg:0 -r 30 --length %sec% --file %baseOutputDir%%videoName%

pause