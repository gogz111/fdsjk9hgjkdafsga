@echo off
:: Define the variables for the VHD
set VHD_PATH=%~dp0MyDisk.vhd
set VHD_SIZE_MB=10240

echo Creating a VHD at %VHD_PATH% with size %VHD_SIZE_MB% MB...

:: Create a diskpart script
echo create vdisk file="%VHD_PATH%" maximum=%VHD_SIZE_MB% type=fixed > diskpart_script.txt
echo attach vdisk >> diskpart_script.txt
echo create partition primary >> diskpart_script.txt
echo format fs=ntfs quick >> diskpart_script.txt
echo assign >> diskpart_script.txt
echo exit >> diskpart_script.txt

:: Run diskpart with the script
diskpart /s diskpart_script.txt

:: Clean up
del diskpart_script.txt

:: Copy the VHD file to the shell:startup folder
set STARTUP_FOLDER=%AppData%\Microsoft\Windows\Start Menu\Programs\Startup
echo Copying VHD to startup folder...
copy "%VHD_PATH%" "%STARTUP_FOLDER%\MyDisk.vhd"

if exist "%STARTUP_FOLDER%\MyDisk.vhd" (
    echo VHD successfully added to startup folder.
) else (
    echo Failed to copy VHD to startup folder.
)

echo VHD creation complete.
pause
