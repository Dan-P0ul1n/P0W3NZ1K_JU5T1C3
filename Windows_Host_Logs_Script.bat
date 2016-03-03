color 17
::colors: 0=BLK 1=BLU 2=GRE 3=AQU 4=RED 5=PUR 6=YEL 7=WHI 8=GRAY 9=L.BLU A=L.GRE B=L.AQU C=L.RED D=L.PUR E=L.YEL F=BRIGHT.WHITE
::1st NUM (1) = Background color; 2nd NUM (7) = Font color

::Windows Logs Collection Script Created by Dan Poulin ([ßµ∟∟€t›)  
@echo Win Logs Collection Script script created by: Dan Poulin [ßµ∟∟€t›
:::      
:::      	     _____
:::           _-~~     ~~-_//
:::         /~             ~\
:::        |              _  |_
:::       |         _--~~~ )~~ )___	Oh Boy! Oh Boy!  LOGS! LOGS! LOGGGGGGGS!!!!!
:::      \|        /   ___   _-~   ~-_
:::      \          _-~   ~-_         \
:::      |         /         \         |
:::      |        |  O)       |         |
:::       |      |             |        |
:::       |      |             |    (O |
:::       /|      |           |       /
:::       / \ _--_ \         /-_   _-~)
:::         /~    \ ~-_   _-~   ~~~__/
:::        |   |\  ~-_ ~~~ _-~~---~  \
:::        |   | |    ~--~~  / \      ~-_
:::         |   \ |                      ~-_
:::          \   ~-|                        ~~--__ _-~~-,
:::           ~-_   |                             /     |
:::              ~~--|                                 /
:::                |  |                               /
:::                |   |              _            _-~
:::                |  /~~--_   __---~~          _-~
:::                |  \                   __--~~
:::                |  |~~--__     ___---~~
:::                |  |      ~~~~~
:::                |  |
:::
:::
:: This for loop successively echoes any text following the ':::' < like the text above >
@for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A 

:: Change all \\share-drive\ items to intended drive destination, using find/replace, before execution
  
@mkdir C:\LOGS
@mkdir C:\LOGS\%COMPUTERNAME%
:: powershell new-item -type directory -path C:\LOGS

@date /t >> C:\LOGS\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
@time /t >> C:\LOGS\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: powershell.exe get-date -format "MM/dd/yyyy HH:MM:ss tt"

systeminfo | find /V /I "hotfix" | find /V "KB" >> C:\LOGS\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\LOGS\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: exports system event logs to .evtx file <portable log reader>	  
wevtutil.exe epl system C:\LOGS\%COMPUTERNAME%-Event_Logs.evtx

powershell.exe Get-ChildItem -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventLog\' > C:\LOGS\%COMPUTERNAME%-Event_Logs_Registry.txt
powershell.exe Get-ChildItem -Path HKLM:\SYSTEM\CurrentControlSet\services\eventLog -Recurse -ErrorAction SilentlyContinue >> C:\LOGS\%COMPUTERNAME%-Event_Logs_Registry.txt

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\LOGS\%COMPUTERNAME%-Event_Logs_Registry.txt 

::Only works with .NET 4.5+ // This Hashes the results using MD5 algorithm; many algorithms available::
powershell.exe Get-FileHash C:\LOGS\*.evtx -Algorith MD5 >> C:\LOGS\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-FileHash C:\LOGS\%COMPUTERNAME%-Event_Logs_Registry.txt -Algorith MD5 >> C:\LOGS\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\LOGS\%COMPUTERNAME%-Event_Logs_Registry.txt

powershell.exe Get-EventLog -list >> C:\LOGS\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@move C:\LOGS\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt C:\LOGS\%COMPUTERNAME%
@move C:\LOGS\%COMPUTERNAME%-Event_Logs.evtx C:\LOGS\%COMPUTERNAME%
@move C:\LOGS\%COMPUTERNAME%-Event_Logs_Registry.txt C:\LOGS\%COMPUTERNAME%

:: Only works with .NET 4.5+ // This creates a text file
:: cont. embeded script takes results from C:\LOGS\%COMPUTERNAME% and compresses it into a .zip file which can be exfil'd from target box  
@echo off
	@echo.>"C:\LOGS\%COMPUTERNAME%-zip.txt
	@echo $source = "C:\LOGS\%COMPUTERNAME%" >> C:\LOGS\%COMPUTERNAME%-zip.txt
	@echo $destination = "C:\LOGS\%COMPUTERNAME%_LOGS.zip" >> C:\LOGS\%COMPUTERNAME%-zip.txt
	@echo If (Test-path $destination) {Remove-item $destination} >> C:\LOGS\%COMPUTERNAME%-zip.txt
	@echo Add-Type -assembly "system.io.compression.filesystem"	>>	C:\LOGS\%COMPUTERNAME%-zip.txt
	@echo [io.compression.zipfile]::CreateFromDirectory($source, $destination) >> C:\LOGS\%COMPUTERNAME%-zip.txt

:: this converts text file to powershell script		
@move C:\LOGS\%COMPUTERNAME%-zip.txt C:\LOGS\%COMPUTERNAME%-zip.ps1

:: executes powershell script made previously  < script: zips contents of C:\LOGS\%COMPUTERNAME% >
@echo compressing forensic artifact results into .ZIP file
powershell.exe -file C:\LOGS\%COMPUTERNAME%-zip.ps1

:: forcibly, and quietly erases all contents of C:\LOGS\%COMPUTERNAME%
@echo clean-up
@erase /F /Q C:\LOGS\%COMPUTERNAME%-zip.ps1 
@rmdir /S /Q C:\LOGS\%COMPUTERNAME%

@echo results located here: C:\LOGS\
:: .ZIP file with contents located here ..
:: The End
