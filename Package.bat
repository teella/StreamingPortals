@echo off

REM ************ Change these Values ************
REM The location of your Unreal project.
set OUTPUT=D:/SP_Build
REM The location where the builds are going to be stored.
set PROJECT="D:/StreamingPortals/StreamingPortals.uproject"
REM Base Engine Folder Location
REM set ENGINEDIR="C:/Program Files/Epic Games/UE_5.2/Engine"
set ENGINEDIR="C:/Unreal/UE_5.2/Engine"
REM ************ Change these Values ************


REM The location of the UAT batch file.
set UAT=%ENGINEDIR%"/Build/BatchFiles/RunUAT.bat"

IF %1.==. GOTO No1
IF %1==dev set CLIENTCONFIG=Development
IF %1==ship set CLIENTCONFIG=Shipping
IF %1==ship set DISTRO=-distribution
IF %1==debug set CLIENTCONFIG=DebugGame
IF %1==test set CLIENTCONFIG=Test
IF %1==debugengine set CLIENTCONFIG=Debug
GOTO Buildy


:No1
	echo No param 1
	set CLIENTCONFIG=Development
GOTO Buildy

:Buildy
echo Using -clientconfig=%CLIENTCONFIG%
echo %UAT% BuildCookRun -project=%PROJECT% -noP4 -platform=Win64 -SkipCookingEditorContent -clientconfig=%CLIENTCONFIG% -cook -package -build -compressed -stage -iostore -pak -crashreporter -archive -prereqs %DISTRO% -applocaldirectory="%ENGINEDIR%/Binaries/ThirdParty/AppLocalDependencies" -archivedirectory="%OUTPUT%/%CLIENTCONFIG%" 
call %UAT% BuildCookRun -project=%PROJECT% -noP4 -platform=Win64 -SkipCookingEditorContent -clientconfig=%CLIENTCONFIG% -cook -package -build -compressed -stage -iostore -pak -crashreporter -archive -prereqs %DISTRO% -applocaldirectory="%ENGINEDIR%/Binaries/ThirdParty/AppLocalDependencies" -archivedirectory="%OUTPUT%/%CLIENTCONFIG%" 
GOTO End1

:End1
echo .
echo -----===========-----
echo      %CLIENTCONFIG%
echo -----===========-----
echo .
echo ---=== DONE ===---
