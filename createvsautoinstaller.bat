@echo off
rem create an vsautoinstaller
if exist .vsconfig (
    GoTo CREATE_FILE
) else (
    GoTo ERROR
)
:CREATE_FILE
set myfile=vsautoinstaller.bat
certutil -encode -f ".vsconfig" file.tmp
setlocal enabledelayedexpansion

echo @echo off>%myfile%
echo rem name of the temp file to store the config>>%myfile%
echo SET configFile64=a.vsconfig>>%myfile%
echo SET configFile=.vsconfig >>%myfile%
echo rem path to the config tempfile>>%myfile%
echo SET configPath=%%~dp0%%configFile64%%>>%myfile%
echo rem data to be added to the config file>>%myfile%
echo | set /p =SET configFileData=>>%myfile%
for /f "usebackq delims=" %%I in ("file.tmp") do (
echo | set /p=%%I>>%myfile%
)
echo: >> %myfile%
echo rem decode data>>%myfile%
echo wininit^>%%configPath%%>>%myfile%
echo echo %%configFileData%%^>%%configPath%%>>%myfile%
echo certutil -decode %%configPath%% %%configFile%%>>%myfile%
echo rem install vstudio with the provided config file>>%myfile%
echo winget install --id Microsoft.VisualStudio.2022.Community --override "--passive --config %%~dp0%%configFile%%" --accept-package-agreements --accept-source-agreements>>%myfile%
echo rem delete temp file>>%myfile%
echo del /Q %%configPath%%>>%myfile%
echo del /Q %%configFile%%>>%myfile%

GoTo END
:ERROR
echo %configFile% not found 
pause
:END
