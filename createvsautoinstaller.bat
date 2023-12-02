@echo off
rem create an vsautoinstaller
set configFile=.vsconfig
if exist .vsconfig (
    GoTo CREATE_FILE
) else (
    GoTo ERROR
)
:CREATE_FILE
set myfile=vsautoinstaller.bat
echo @echo off>%myfile%
echo rem name of the temp file to store the config>>%myfile%
echo SET configFileName=a.vsconfig>>%myfile%
echo rem path to the config tempfile>>%myfile%
echo SET configPath=%%~dp0%%configFileName%%>>%myfile%
echo rem data to be added to the config file>>%myfile%
echo | set /p =SET configFileData=>>%myfile%
for /F "tokens=* delims=-" %%i in (.vsconfig) do (
    echo | set /p =%%i >>%myfile%
)
echo rem echo %%configPath%%>>%myfile%
echo rem create tempfile>>%myfile%
echo wininit^>%%configPath%%>>%myfile%
echo rem write data to the temp file>>%myfile%
echo echo %%configFileData%% ^> %%configPath%%>>%myfile%
echo rem install vstudio with the provided config file>>%myfile%
echo winget install --id Microsoft.VisualStudio.2022.Community --override "--passive --config %%configPath%%" --accept-package-agreements --accept-source-agreements>>%myfile%
echo rem delete temp file>>%myfile%
echo del /Q %%configPath%%>>%myfile%
GoTo END
:ERROR
echo %configFile% not found 
pause
:END