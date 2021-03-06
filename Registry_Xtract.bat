color 17
::colors: 0=BLK 1=BLU 2=GRE 3=AQU 4=RED 5=PUR 6=YEL 7=WHI 8=GRAY 9=L.BLU A=L.GRE B=L.AQU C=L.RED D=L.PUR E=L.YEL F=BRIGHT.WHITE
::1st NUM (1) = Background color; 2nd NUM (7) = Font color

@echo Win Registry-Forensic Artifacts script created by: Dan Poulin [ßµ∟∟€t›
:: Win Registry-Forensic Artifacts script created by: Dan Poulin [ßµ∟∟€t›
::: 
:::                 ___________________________________________________
:::                /   _____________________________________________   \
:::               |  |                                              |  |
:::               |  |                                              |  |
:::               |  | C:\> echo This script by [ßµ∟∟€t›. |  |
:::               |  | > This script by [ßµ∟∟€t›.         |  |
:::               |  |                                              |  |
:::               |  | C:\> .\Registry_Xtract.bat                   |  |
:::               |  |             __________________________       |  |
:::               |  | >REG QUERY |   ____________________   |      |  |
:::               |  |            |  |                    |  |      |  |
:::               |  |            |  | C:\>.\Registry_Xtr.|  |      |  |
:::               |  |            |  |           ______   |  |      |  |
:::               |  |            |  |          |C:>./R|  |  |      |  |
:::               |  |            |  |          |______|  |  |      |  |
:::               |  |            |  |____________________|  |      |  |
:::               |  |            |__________________________|      |  |
:::               |  |                \__________________/          |  |
:::               |  |           _________________________________  |  |
:::               |  |__________/_________________________________\ |  |
:::                \___________________________________________________/
:::                       \_______________________________________/
:::                    _______________________________________________
:::                _-'    .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.  --- `-_
:::              _-'.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.--.  .-.-.`-_
:::           _-'.-.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-`__`. .-.-.-.`-_
:::        _-'.-.-.-.-. .-----.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-----. .-.-.-.-.`-_
:::    _-'.-.-.-.-.-. .---.-. .-----------------------------. .-.---. .---.-.-.-.`-_
:::   :------------------------------------------------------------------------------:
:::    ---._.-----------------------------------------------------------------._.---'    
:::
:::
::  This for loop successively echoes any text following the ':::' < like the text above >
@for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A

:: for loop switches: for /D (dirs for /R (files in sub-dirs) for /L (step through series of values) for /F (parse .txt files, strings, and CMD output)
:: for loop iterator var names range from [a to z] or [A to Z], such as %%A, %%B, etc. 

:: if"%1" == "1" ( @if"%2" == "2" (hostname & ver) else (ver)) else (hostname & ver & netstat -a)
:: the 1st 'else' statement is assoc w/ if"%2" == "2" .  the final else statement is assoc w/ if"%1" == "1"

:: if /i "%1" == "A" (echo N) else (echo is not N)
:: /i switch is for case in-sensativity

:: @echo.>"C:\FINDINGS\sysinfo.txt
:: @for %%B in (%TMP%\*.exe) do (echo %%B) >> C:\FINDINGS\sysinfo.txt
:: creates .txt file and outputs all findings (.exe) to the .txt file

:: @for %%B in (%TMP%\*.exe %TMP%\*.log %TMP\.txt) do (echo %%B) >> C:\FINDINGS\sysinfo.txt

:: for /d %%B in (%TMP% %TMP%\*) do (@for %%C in ("%%B\*.log") do echo %%C) >> C:\FINDINGS\findings.txt
:: this for loop iterates through %TMP% and the top-level dirs under %TMP% then echos any .log files found

:: for /r C:\ %%B in (*.exe) do echo %%B >> C:\FINDINGS\findings.txt
:: recursively searches all dirs C:\* for (.exe) files, and echos them

:: for /f "tokens=2" %%A in ('sc query state^= all ^| findstr /C:"SERVICE_NAME"') do (@for /f "tokens=4" %%B in ('sc query %%A ^| findstr /C:"STATE"') do @echo %%A is %%B)  >> C:\FINDINGS\findings.txt
:: powershell.exe $service=get-wmiobject -query 'select * from win32_service where name="winrm"'; echo $service.pathname >> C:\FINDINGS\findings.txtss

:: SUBROUTINES >>
:: if "%1" =="" (echo Error: No parameter passed with script!) & (goto EXIT) 
:: if "%1" =="1" goto SUBROUTINE1 
:: if "%1" =="2" goto SUBROUTINE2 
:: if "%1" =="3" goto SUBROUTINE3
:: goto EXIT 

:: :SUBROUTINE1 
:: echo In subroutine 1 
:: goto EXIT 

:: :SUBROUTINE2 
:: echo In subroutine 2 
:: goto EXIT

:: :EXIT 
:: echo Exiting...
:: << SUBROUTINES  

:: PROCEDURES >>
:: if "%1"=="1" call system-checks 
:: if "%1"=="2" call C:\scripts\log-checks

:: set Arg1 = SQL_SERVER 
:: set Arg2 = DC1 
:: set Arg3 = DC2 
:: call system-checks Arg1 Arg2 Arg3
:: << PROCEDURES

for /f "tokens=2" %%S in ('sc query state^= all ^| find "SERVICE_NAME"') do
    @(for /f "tokens=4" %%T in ('sc query %%S ^| find "STATE     "') do @echo %%S is %%T)

 

::  Change all \\share-drive\ or C:\ objects to intended drive destination, using find/replace, before execution

@mkdir C:\REG
@mkdir C:\REG\%COMPUTERNAME%
@mkdir C:\REG\KEYS
::powershell.exe new-item -type directory -path C:\REG\KEYS

@date /t >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt  
@time /t >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
::powershell.exe get-date -format "MM/dd/yyyy HH:MM:ss tt"

:: netsh interface ipv4 show tcpconn >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: netsh interface ipv4 show udpconn >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: netsh ras diagnostics show all type = file destination = FileName verbose = enabled
:: outputs plethora of data into "FileName" default is htm file

@ver >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
systeminfo | find /V /I "hotfix" | find /V "KB" >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
	  
::  following Registry hives are stored in the corresponding files
::  HKEY_USERS:   --> \Documents and Setting\User   --> Profile\NTUSER.DAT
::  HKEY_USERS\DEFAULT:   --> C:\Windows\system32\config\default
::  HKEY_LOCAL_MACHINE\SAM:   --> C:\Windows\system32\config\SAM
::  HKEY_LOCAL_MACHINE\SECURITY:   --> C:\Windows\system32\config\SECURITY
::  HKEY_LOCAL_MACHINE\SOFTWARE:   --> C:\Windows\system32\config\software
::  HKEY_LOCAL_MACHINE\SYSTEM:   --> C:\Windows\system32\config\system

:: REG SAVE - ROOTKEYs [ HKLM | HKCU | HKCR | HKU | HKCC ]  "only HKLM and HKU can be accessed remotely!"

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
::
::      _____  _    _ _   _     _____            _     _              
::     |  __ \| |  | | \ | |   |  __ \          (_)   | |             
::     | |__) | |  | |  \| |   | |__) |___  __ _ _ ___| |_ _ __ _   _ 
::     |  _  /| |  | | . ` |   |  _  // _ \/ _` | / __| __| '__| | | |
::     | | \ \| |__| | |\  |   | | \ \  __/ (_| | \__ \ |_| |  | |_| |
::     |_|  \_\\____/|_| \_|   |_|  \_\___|\__, |_|___/\__|_|   \__, |
::                                          __/ |                __/ |
::                                         |___/                |___/ 
::
:: @for /f "delims=: tokens=*" %%B in ('findstr /b ::. "%~f0"') do @echo(%%B									 
:: RUN Keys
@echo Collecting 'RUN and RUNONCE' Registry Keys
@echo Collecting 'RUN and RUNONCE' Registry Keys >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer C:\REG\KEYS\01.hiv  /y					%=01=%
REG SAVE HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run C:\REG\KEYS\02.hiv /y 								%=02=%
REG SAVE HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce C:\REG\KEYS\03.hiv /y 							%=03=%
REG SAVE HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce\Setup C:\REG\KEYS\04.hiv /y 						%=04=%
REG SAVE HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnceEx C:\REG\KEYS\05.hiv /y							%=05=%
REG SAVE HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run C:\REG\KEYS\06.hiv /y 					%=06=%
REG SAVE HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce C:\REG\KEYS\07.hiv /y 				%=07=%
REG SAVE HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce\Setup C:\REG\KEYS\08.hiv /y 			%=08=%
REG SAVE HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnceEx C:\REG\KEYS\09.hiv /y 				%=09=%
REG SAVE HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run C:\REG\KEYS\10.hiv /y 	%=10=%

@echo
	setlocal ENABLEEXTENSIONS
	set KEY="HKU"
	set KEY_VALUE=S-1-5-21*
for /F "usebackq tokens=2 delims=\" %%A in (`REG QUERY %KEY% /f %KEY_VALUE% /k 2^>nul`) do (
	set SID_C=%%A
	)
for /f "usebackq tokens=1 delims=_" %%X in (`echo %SID_C% `) do (
	set SID=%%X
	)
:: setlocal & endlocal; setlocal creates snapshop of global env; once endlocal executes, system is restored to snapshot
:: local var %SID% is defined above in the FOR loop; there is no WIN7 %SID% global env var.
REG SAVE HKU\%SID%\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run C:\REG\KEYS\11.hiv /y 						%=11=%
REG SAVE HKU\%SID%\Software\Microsoft\Windows\CurrentVersion\Run C:\REG\KEYS\12.hiv /y 											%=12=%
REG SAVE HKU\%SID%\Software\Microsoft\Windows\CurrentVersion\RunOnce C:\REG\KEYS\13.hiv /y 										%=13=%
REG SAVE HKU\%SID%\Software\Microsoft\Windows\CurrentVersion\RunOnce\Setup C:\REG\KEYS\14.hiv /y 								%=14=%
REG SAVE HKU\%SID%\Software\Microsoft\Windows\CurrentVersion\RunOnceEx C:\REG\KEYS\15.hiv /y 									%=15=%
REG SAVE HKU\%SID%\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run C:\REG\KEYS\16.hiv /y 			%=16=%
REG SAVE HKU\%SID%\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run C:\REG\KEYS\17.hiv /y 								%=17=%
REG SAVE HKU\%SID%\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce C:\REG\KEYS\18.hiv /y 							%=18=%
REG SAVE HKU\%SID%\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce\Setup C:\REG\KEYS\19.hiv /y 					%=19=%
REG SAVE HKU\%SID%\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnceEx C:\REG\KEYS\20.hiv /y 						%=20=%

::Run Services Keys
REG SAVE HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce C:\REG\KEYS\21.hiv /y						%=21=%
REG SAVE HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServices C:\REG\KEYS\22.hiv /y							%=22=%
REG SAVE HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServicesOnce C:\REG\KEYS\23.hiv /y			%=23=%
REG SAVE HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunServices C:\REG\KEYS\24.hiv /y				%=24=%

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: Browser Helper Objects
@echo Browser Helper Objects:: >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\*' >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects" C:\REG\KEYS\25.hiv /y	%=25=%
powershell.exe Get-ItemProperty -Path 'HKLM:\Software\Wow6432Node\Microsoft\Internet Explorer\Main\FeatureControl\*' >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE "HKLM\Software\Wow6432Node\Microsoft\Internet Explorer\Main\FeatureControl" C:\REG\KEYS\26.hiv /y						%=26=%

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
::
::                    _           _____  _    _ _   _     _____            _     _              
::         /\        | |         |  __ \| |  | | \ | |   |  __ \          (_)   | |             
::        /  \  _   _| |_ ___    | |__) | |  | |  \| |   | |__) |___  __ _ _ ___| |_ _ __ _   _ 
::       / /\ \| | | | __/ _ \   |  _  /| |  | | . ` |   |  _  // _ \/ _` | / __| __| '__| | | |
::      / ____ \ |_| | || (_) |  | | \ \| |__| | |\  |   | | \ \  __/ (_| | \__ \ |_| |  | |_| |
::     /_/    \_\__,_|\__\___/   |_|  \_\\____/|_| \_|   |_|  \_\___|\__, |_|___/\__|_|   \__, |
::                                                                    __/ |                __/ |
::                                                                   |___/                |___/ 
::															   
:: @for /f "delims=: tokens=*" %%C in ('findstr /b :: . "%~f0"') do @echo(%%C															   
:: Auto Run
@echo Auto Run:: >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG QUERY "HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor" /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG QUERY "HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Command Processor" /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG QUERY "HKU\%SID%\Software\Microsoft\Command Processor" /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG QUERY "HKU\%SID%\Software\Wow6432Node\Microsoft\Command Processor" /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
::
::
::      _    _  _____ ____                 _____            _     _               
::     | |  | |/ ____|  _ \               |  __ \          (_)   | |              
::     | |  | | (___ | |_) |    ______    | |__) |___  __ _ _ ___| |_ _ __ _   _  
::     | |  | |\___ \|  _ <    |______|   |  _  // _ \/ _` | / __| __| '__| | | | 
::     | |__| |____) | |_) |              | | \ \  __/ (_| | \__ \ |_| |  | |_| | 
::      \____/|_____/|____/               |_|  \_\___|\__, |_|___/\__|_|   \__, | 
::                                                     __/ |                __/ | 
::                                                    |___/                |___/  
::
:: @for /f "delims=: tokens=*" %%D in ('findstr /b ::_ "%~f0"') do @echo(%%D  
:: USB Registry Keys
@echo Collecting 'USB' Registry Keys
@echo Collecting 'USB' Registry Keys >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-ItemProperty 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\*\* ^| ^Select FriendlyName ^| ^Sort-Object -Property FriendlyName >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKLM\SYSTEM\CurrentControlSet\Enum\USB C:\REG\KEYS\27.hiv /y															%=27=%
powershell.exe Get-ItemProperty 'Registry::HKEY_LOCAL_MACHINE\CurrentControlSet\Enum\USB\*\* >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKLM\SYSTEM\CurrentControlSet\Enum\USB C:\REG\KEYS\28.hiv /y															%=28=%
REG QUERY HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USBSTOR /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKLM\SYSTEM\CurrentControlSet\Enum\USBSTOR C:\REG\KEYS\29.hiv /y														%=29=%
REG QUERY HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG QUERY HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKLM\SYSTEM\MountedDevices C:\REG\KEYS\30.hiv /y																		%=30=%

:: MountedDevices <-- IDs user that used USB device; Use DCode Tool to decode HEX data to UTC Date & Time __ folder 0066 -> last USB connection; 0067 -> last USB removed
REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs C:\REG\KEYS\31.hiv /y								%=31=%
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Portable Devices\Devices" /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE "HKLM\SOFTWARE\Microsoft\Windows Portable Devices\Devices" C:\REG\KEYS\32.hiv /y										%=32=%
REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\EMDMgmt" /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\EMDMgmt" C:\REG\KEYS\33.hiv /y										%=33=%
REG QUERY HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2 /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2 C:\REG\KEYS\34.hiv /y				%=34=%
@copy C:\Windows\inf\setupapi.dev.log C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-setupapi.dev.log
:: setupapi.dev.log <-- alternate for MountedDevices; time is LOCAL; use Mandiant Highligher to read it

REG QUERY HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKLM\SYSTEM\MountedDevices C:\REG\KEYS\35.hiv /y																		%=35=%

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
::
::  _   _ _______ _    _  _____ ______ _____        _____       _______ 
:: | \ | |__   __| |  | |/ ____|  ____|  __ \      |  __ \   /\|__   __|
:: |  \| |  | |  | |  | | (___ | |__  | |__) |     | |  | | /  \  | |   
:: | . ` |  | |  | |  | |\___ \|  __| |  _  /      | |  | |/ /\ \ | |   
:: | |\  |  | |  | |__| |____) | |____| | \ \   _  | |__| / ____ \| |   
:: |_| \_|  |_|   \____/|_____/|______|_|  \_\ (_) |_____/_/    \_\_|   
::                                                                      
:: @for /f "delims=: tokens=*" %%E in ('findstr /b ::. "%~f0"') do @echo(%%E																	  
:: NTUSER.DAT	  
@echo Collecting 'NTUSER.DAT' registry keys
@echo Collecting 'NTUSER.DAT' registry keys >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG QUERY HKEY_CURRENT_USER\Software\Microsoft\SearchAssistant\ACMru /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKCU\Software\Microsoft\SearchAssistant\ACMru C:\REG\KEYS\36.hiv /y													%=36=%
REG QUERY HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery C:\REG\KEYS\37.hiv /y							%=37=%
REG QUERY HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs C:\REG\KEYS\38.hiv /y								%=38=%
REG QUERY HKEY_CURRENT_USER\Software\Microsoft\Office /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKCU\Software\Microsoft\Office C:\REG\KEYS\39.hiv /y																	%=39=%
REG QUERY HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU C:\REG\KEYS\40.hiv /y					%=40=%
REG QUERY HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU C:\REG\KEYS\41.hiv /y				%=41=%
REG QUERY HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist C:\REG\KEYS\42.hiv /y								%=42=%
::  UserAssist - Logs Last Run Time & Count; ROT13 Encoded .Evidence of Execution; Timeline.

REG QUERY "HKEY_CURRENT_USER\Software\Classes\Local Settings\Microsoft\Windows\Shell\MUICache" /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE "HKCU\Software\Classes\Local Settings\Microsoft\Windows\Shell\MUICache" C:\REG\KEYS\43.hiv /y							%=43=%

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
::
::                       _          ____             _                 
::     /\               | |        |  _ \           | |                
::    /  \   _ __  _ __ | | ___    | |_) | __ _  ___| | ___   _ _ __   
::   / /\ \ | '_ \| '_ \| |/ _ \   |  _ < / _` |/ __| |/ / | | | '_ \  
::  / ____ \| |_) | |_) | |  __/   | |_) | (_| | (__|   <| |_| | |_) | 
:: /_/    \_\ .__/| .__/|_|\___|   |____/ \__,_|\___|_|\_\\__,_| .__/  
::          | |   | |                                          | |     
::          |_|   |_|                                          |_|    
::
:: @for /f "delims=: tokens=*" %%F in ('findstr /b ::.. "%~f0"') do @echo(%%F		  
:: Email Forensics
:: Collecting Apple Device Backup Archive artifacts
@echo Email Forensics
@echo Email Forensics >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
@echo Collecting 'Apple Device' Backup Archives  
powershell.exe Get-ChildItem 'C:\Users\*\AppData\Roaming\Apple Computer\MobileSync\Backup' -Recurse -ErrorAction SilentlyContinue >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
::
:: _____  ______ _____ ______ _   _ _______ 
:: |  __ \|  ____/ ____|  ____| \ | |__   __|
:: | |__) | |__ | |    | |__  |  \| |  | |   
:: |  _  /|  __|| |    |  __| | . ` |  | |   
:: | | \ \| |___| |____| |____| |\  |  | |   
:: |_|  \_\______\_____|______|_| \_|  |_|   
::                                           
:: @for /f "delims=: tokens=*" %%G in ('findstr /b ::.. "%~f0"') do @echo(%%G										   
:: Collecting 'Recent Folder' artifacts
@echo Collecting 'Recent' Folder artifacts
@echo Collecting 'Recent' Folder artifacts >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-ChildItem "C:\Users\*\AppData\Roaming\Microsoft\Windows\Recent" -Recurse >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
::
::  _______ _                     _      _____           _          
:: |__   __| |                   | |    / ____|         | |         
::    | |  | |__  _   _ _ __ ___ | |__ | |     __ _  ___| |__   ___ 
::    | |  | '_ \| | | | '_ ` _ \| '_ \| |    / _` |/ __| '_ \ / _ \
::    | |  | | | | |_| | | | | | | |_) | |___| (_| | (__| | | |  __/
::    |_|  |_| |_|\__,_|_| |_| |_|_.__/ \_____\__,_|\___|_| |_|\___|
::                                                                  
:: @for /f "delims=: tokens=*" %%H in ('findstr /b ::.. "%~f0"') do @echo(%%H																  
:: Collecting User ThumbCache artifacts
@echo Collecting User 'ThumbCache' artifacts
@echo Collecting User 'ThumbCache' artifacts >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Windows\Explorer" -Recurse >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
::
::   _____ _  ____     _______  ______ 
::  / ____| |/ /\ \   / /  __ \|  ____|
:: | (___ | ' /  \ \_/ /| |__) | |__   
::  \___ \|  <    \   / |  ___/|  __|  
::  ____) | . \    | |  | |    | |____ 
:: |_____/|_|\_\   |_|  |_|    |______|
::
:: @for /f "delims=: tokens=*" %%I in ('findstr /b ::.. "%~f0"') do @echo(%%I									 
:: Collecting Skype artifacts::
@echo Collecting Skype artifacts
@echo Collecting Skype artifacts >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-ChildItem "C:\Users\*\AppData\Roaming\Skype" -Recurse -ErrorAction SilentlyContinue >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
::
::  _____          ______   _       _     
:: |  __ \        |  ____| | |     | |    
:: | |__) | __ ___| |__ ___| |_ ___| |__  
:: |  ___/ '__/ _ \  __/ _ \ __/ __| '_ \ 
:: | |   | | |  __/ | |  __/ || (__| | | |
:: |_|   |_|  \___|_|  \___|\__\___|_| |_|
::                                        
:: @for /f "delims=: tokens=*" %%J in ('findstr /b ::.. "%~f0"') do @echo(%%J										
:: Collecting PreFetch artifacts
@echo Collecting 'PreFetch' artifacts
@echo Collecting 'PreFetch' artifacts >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-ChildItem 'C:\Windows\Prefetch' >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-ChildItem "C:\Windows\Prefetch\Layout.ini" >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG QUERY "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /s >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
 
@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: Only works with .NET 4.5+ & Powershell 4.0+ // This Hashes the results using MD5 algorithm; many algorithms available
:: the Get-Filehash CMD can be used on files only, not dirs; unless you use Get-ChildItem and escape the | symobol using ^
@echo hashing forensic artifact results
@echo hashing forensic artifact results >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
@echo off
:: powershell.exe Get-FileHash C:\REG\%COMPUTERNAME% -Algorith MD5 >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt:: powershell.exe Get-FileHash -Path C:\REG\KEYS -Algorith MD5,SHA1,SHA512,SHA256,RIPEMD160 ^| Format-List >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: powershell.exe Get-ChildItem -Filter C:\REG\%COMPUTERNAME%\*.exe ^| Get-FileHash -Algorith MD5 >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: powershell.exe Get-ChildItem "\\DC1\d'$\Shared_Storage" -Filter *.exe ^| Get-FileHash -Algorith MD5 >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: powershell.exe Get-ChildItem -Recurse C:\REG\%COMPUTERNAME%\ ^| Get-FileHash -Algorith MD5,SHA1 >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: powershell.exe Get-FileHash C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt -Algorith MD5 >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: powershell.exe Get-FileHash C:\REG\KEYS -Algorith MD5 >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-ChildItem -Recurse C:\REG\KEYS\ ^| Get-FileHash -Algorith MD5 >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt	  
powershell.exe Get-FileHash C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-setupapi.dev.log -Algorith MD5 >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

endlocal
@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

powershell.exe Get-EventLog -list >> C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@move C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt C:\REG\%COMPUTERNAME%
@move C:\REG\%COMPUTERNAME%\%COMPUTERNAME%-setupapi.dev.log C:\REG\%COMPUTERNAME%
@move C:\REG\KEYS C:\REG\%COMPUTERNAME%

:: Only works with .NET 4.5+ & Powershell 4.0+ // This creates a text file
:: cont.. embeded script takes results from C:\REG\%COMPUTERNAME% and compresses it into a .zip file which can be exfil'd from target box 
@echo off
	@echo.>"C:\REG\%COMPUTERNAME%-zip.txt
	@echo $source = "C:\REG\%COMPUTERNAME%" >> C:\REG\%COMPUTERNAME%-zip.txt
	@echo $destination = "C:\REG\%COMPUTERNAME%_REG.zip" >> C:\REG\%COMPUTERNAME%-zip.txt
	@echo If (Test-path $destination) {Remove-item $destination} >> C:\REG\%COMPUTERNAME%-zip.txt
	@echo Add-Type -assembly "system.io.compression.filesystem"	>>	C:\REG\%COMPUTERNAME%-zip.txt
	@echo [io.compression.zipfile]::CreateFromDirectory($source, $destination) >> C:\REG\%COMPUTERNAME%-zip.txt

:: this converts text file to powershell script	
@move C:\REG\%COMPUTERNAME%-zip.txt C:\REG\%COMPUTERNAME%-zip.ps1

:: executes powershell script made previously  < script: zips contents of C:\REG\%COMPUTERNAME% >
@echo compressing forensic artifact results into .ZIP file
powershell.exe -file C:\REG\%COMPUTERNAME%-zip.ps1

:: forcibly, and quietly erases all contents of C:\REG\%COMPUTERNAME%
@echo clean-up
@erase /F /Q C:\REG\%COMPUTERNAME%-zip.ps1 
@rmdir /S /Q C:\REG\%COMPUTERNAME%

@echo results located here: C:\REG\
:: .ZIP file with contents located here ..
:: The End
