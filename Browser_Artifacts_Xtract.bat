color 30
::colors: 0=BLK 1=BLU 2=GRE 3=AQU 4=RED 5=PUR 6=YEL 7=WHI 8=GRAY 9=L.BLU A=L.GRE B=L.AQU C=L.RED D=L.PUR E=L.YEL F=BRIGHT.WHITE
::1st NUM (1) = Background color; 2nd NUM (7) = Font color

::Browser Forensic Artifacts script created by: Dan Poulin [ßµ∟∟€t›
@echo Browser Forensic Artifacts script created by: Dan Poulin [ßµ∟∟€t›
:::
:::
:::
:::         _--~~--_
:::       /~/_|  |_\~\		Help Me [ßµ∟∟€t›. 
:::      |____________|             
:::      |[][][][][][]|:=  .               
:::    _ | __         |_ _ \  ' .       .==.   
:::   |  || . |   ==  |  |  \    ' .   ()''()-   
:::   |  ||_ _|   ==  |  |    \        <;--; /
:::   |  |[] []   ==  |  |      \   _..'.  __'.
:::   |  |____________|  |         '-''' \'...; 
:::   /__\            /__\                |---\
:::    ~~              ~~		     .'    '.
:::                                    :       '._
:::                                    | :       :_
:::     You're My Only Hope!           '-'._----''___												                                                                         D.P.
::: 
::: 
:::
:::
:: This 'for loop' successively echoes any text following the ':::' < such as the text above >
@for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
 
:: Change all C:\.. objects to intended drive destination, using find/replace, before execution
:: REG SAVE - ROOTKEYs [ HKLM | HKCU | HKCR | HKU | HKCC ]  "only HKLM and HKU can be accessed remotely!
:: WINXP & WIN7 Env. Variables - http://www.binbert.com/blog/2010/09/default-environment-variable-values-of-windows-7-xp/ or just type CMD: C:\>set
:: you can set new variables like this C:\> set CPT="101 Cyber Protection Team"   ..the new var would be represented like:  %CPT%
  
@mkdir C:\WIN7_8\
@mkdir C:\WIN7_8\KEYS\
@mkdir C:\WIN7_8\%COMPUTERNAME%
:: powershell.exe new-item -type directory -path C:\WIN7_8

@date /t >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt  
@time /t >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: powershell.exe get-date -format "MM/dd/yyyy HH:MM:ss tt"

@echo systeminfo | find /V /I "hotfix" | find /V "KB" >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

powershell.exe Set-ExecutionPolicy Unrestricted -Force

:: Incident Response Script WINDOWS 7, 8
:: BROWSER Forensic Artifacts
@echo Collecting 'BROWSER Forensic Artifacts'
@echo Collecting 'BROWSER Forensic Artifacts' >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: History & Download History Files
powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Windows\WebCache\WebCacheV*.dat" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
xcopy /C /H /E /R /K /Y C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\WebCache\WebCacheV*.dat "C:\WIN7_8\%COMPUTERNAME%\History\"

:: Cache
powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5\*.*" "C:\WIN7_8\%COMPUTERNAME%\Cache\"

powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Windows\Temporary Internet Files\Low\Content.IE5" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Temporary Internet Files\Low\Content.IE5\*.*" "C:\WIN7_8\%COMPUTERNAME%\Cache\"

:: Cookies
powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Windows\Cookies" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Cookies\*.*" "C:\WIN7_8\%COMPUTERNAME%\Cookies\"

powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Windows\Cookies\Low" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Cookies\Low\*.*" "C:\WIN7_8\%COMPUTERNAME%\Cookies\"

:: Bookmarks
powershell.exe Get-ChildItem "C:\Users\*\Favorites" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\Favorites\*.*" "C:\WIN7_8\%COMPUTERNAME%\Favorites\"

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: Incident Response Script WINDOWS 8.1
:: History & Download History Files - Cache - Cookies - Favorites
powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Windows\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@echo.> C:\WIN7_8\%COMPUTERNAME%\exludedfileslist.txt
	@echo C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\1024 >> C:\WIN7_8\%COMPUTERNAME%\exludedfileslist.txt
	@echo C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\1033 >> C:\WIN7_8\%COMPUTERNAME%\exludedfileslist.txt
	@echo C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Burn >> C:\WIN7_8\%COMPUTERNAME%\exludedfileslist.txt
	@echo C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\GameExplorer >> C:\WIN7_8\%COMPUTERNAME%\exludedfileslist.txt
	@echo C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Ringtones >> C:\WIN7_8\%COMPUTERNAME%\exludedfileslist.txt
	@echo C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Themes >> C:\WIN7_8\%COMPUTERNAME%\exludedfileslist.txt
  :: echo C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\WER >> C:\WIN7_8\%COMPUTERNAME%\exludedfileslist.txt
	:: this txt file allows us to specify which objects we don't want xcopy'd (CMD below) to our results folder; ADD dir above 'WER' to reduce final-outup size down from 200+MB.ZIP
	
xcopy /C /H /E /R /K /Y /exclude:C:\WIN7_8\%COMPUTERNAME%\exludedfileslist.txt "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\*.*" "C:\WIN7_8\%COMPUTERNAME%\WIN-X_History\"
@erase /F /Q C:\WIN7_8\%COMPUTERNAME%\exludedfileslist.txt

:: powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Windows\WebCache\WebCacheV*.dat" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\WebCache\WebCacheV*.dat" "C:\WIN7_8\%COMPUTERNAME%\WIN8.1_History\"

:: Cache
:: powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Windows\INetCache\IE" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*" "C:\WIN7_8\%COMPUTERNAME%\WIN8.1_Cache\"

:: powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Windows\INetCache\Low\IE" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\INetCache\Low\IE\*.*" "C:\WIN7_8\%COMPUTERNAME%\WIN8.1_Cache\"

:: Cookies
:: powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Windows\INetCookies" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\INetCookies\*.*" "C:\WIN7_8\%COMPUTERNAME%\WIN8.1_Cookies\"

:: powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Windows\INetCookies\Low" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\INetCookies\Low\*.*" "C:\WIN7_8\%COMPUTERNAME%\WIN8.1_Cookies\"

:: Bookmarks
:: powershell.exe Get-ChildItem "C:\Users\*\Favorites" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\Favorites\*.*" "C:\WIN7_8\%COMPUTERNAME%\WIN-X_Favorites\"

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: Collecting IE History Settings
@echo Collecting IE History Settings
@echo Collecting IE History Settings >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\URL History" C:\WIN7_8\KEYS\URL_History.hiv /y
:: REG SAVEd hiv files can be read by ACCESS DATAs Registry Viewer in Demo Mode <WIN SIFT 8.1>

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: Collecting Windows 8 Metro UI Apps artifacts
:: echo ::Collecting Windows 8 Metro UI Apps artifacts
:: powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Packages\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: Collecting IE9 Download History artifacts
@echo Collecting IE Download History artifacts
@echo Collecting IE Download History artifacts >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-ChildItem "C:\Users\*\AppData\Roaming\Microsoft\Windows\IEDownloadHistory\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\IEDownloadHistory\*.*" "C:\WIN7_8\%COMPUTERNAME%\IE9_History\"

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: Collecting IE10+ Download History artifacts
@echo Collecting IE10 Download History artifacts
@echo Collecting IE10 Download History artifacts >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
REG SAVE "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\TypedURLs" C:\WIN7_8\KEYS\TypedURLs.hiv /y
REG SAVE "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\TypedURLsTime" C:\WIN7_8\KEYS\TypedURLsTime.hiv /y
:: REG SAVEd hiv files can be read by ACCESS DATAs Registry Viewer in Demo Mode <WIN SIFT 8.1>

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: to use the below code, remove the 'goto NEXT'  and ':NEXT' SUB-Routines
goto NEXT
	:: Collecting IE Credential Manager/Vault artifacts
	@echo Collecting IE Credential Manager/Vault artifacts
	@echo Collecting IE Credential Manager/Vault artifacts >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

	powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Vault\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
	xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Vault\*.*" "C:\WIN7_8\%COMPUTERNAME%\IE_Manager_Vault\"

	powershell.exe Get-ChildItem "C:\Users\*\AppData\Roaming\Microsoft\Vault\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
	xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Vault\*.*" "C:\WIN7_8\%COMPUTERNAME%\IE_Manager_Vault\"

	powershell.exe Get-ChildItem "C:\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Vault\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
	xcopy /C /H /E /R /K /Y "C:\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Vault\*.*" "C:\WIN7_8\%COMPUTERNAME%\IE_Manager_Vault\"

	powershell.exe Get-ChildItem "C:\Windows\System32\config\systemprofile\AppData\Roaming\Microsoft\Vault\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
	xcopy /C /H /E /R /K /Y "C:\Windows\System32\config\systemprofile\AppData\Roaming\Microsoft\Vault\*.*" "C:\WIN7_8\%COMPUTERNAME%\IE_Manager_Vault\"

	REG SAVE "HKEY_CURRENT_USER\Software\Microsoft\Protected Storage System Provider" C:\WIN7_8\KEYS\Pro_Store_Sys_Prov.hiv /y
	:: REG SAVEd hiv files can be read by ACCESS DATAs Registry Viewer in Demo Mode 'FREE' <WIN SIFT 8.1>
:NEXT

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: WIN7 Vault artifact location
REG SAVE "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\IntelliForms\Storage2"  C:\WIN7_8\KEYS\Storage2.hiv /y
:: Website Passwords in IE7, 9 are encrypted with DPAPI with the hash of the site they belong to used as the key.  In order to easily crack the encryption \
:: the website must be known, or present, in the history files.  The 'NirSoft WebBrowserPassView' Tool can be used to reveal stored usernames and passwords stored \
:: in a variety of browsers, including all versions of IE.

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: Collecting 'IE Session Recovery' artifacts
@echo Collecting 'IESession Recovery' artifacts
@echo Collecting 'IESession Recovery' artifacts >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: Current IE Session
powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Internet Explorer\Recovery\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Internet Explorer\Recovery\*.*" "C:\WIN7_8\%COMPUTERNAME%\IE_Sessions\"

:: powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Internet Explorer\Recovery\Active\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Internet Explorer\Recovery\Active\*.*" "C:\WIN7_8\%COMPUTERNAME%\IE_Sessions_Current\"

:: Last IE Session
:: powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Internet Explorer\Recovery\Last Active\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Internet Explorer\Recovery\Last Active\*.*" "C:\WIN7_8\%COMPUTERNAME%\IE_Session_Last\"

:: Current Session - Metro IE Apps
:: powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Internet Explorer\Recovery\Immersive\Active\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Internet Explorer\Recovery\Immersive\Active\*.*" "C:\WIN7_8\%COMPUTERNAME%\IE_Session_Current_Metro\"

:: Last Session - Metro IE Apps
:: powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Internet Explorer\Recovery\Immersive\Last Active\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Internet Explorer\Recovery\Immersive\Last Active\*.*" "C:\WIN7_8\%COMPUTERNAME%\IE_Session_Last_Metro\"

:: Cuurent IE Session - High Integrity
:: powershell.exe Get-ChildItem "C:\Users\*\Local Settings\Application Data\Microsoft\Internet Explorer\Recovery\High\Active\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\Local Settings\Application Data\Microsoft\Internet Explorer\Recovery\High\Active\*.*" "C:\WIN7_8\%COMPUTERNAME%\IE_Session_Current_High_integrity\"

:: Last IE Session - High Integrity
:: powershell.exe Get-ChildItem "C:\Users\*\Local Settings\Application Data\Microsoft\Internet Explorer\Recovery\High\Last Active\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\Local Settings\Application Data\Microsoft\Internet Explorer\Recovery\High\Last Active\*.*" "C:\WIN7_8\%COMPUTERNAME%\IE_Session_Last_High_integrity\"

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: Collecting 'FireFox Browser' artifacts
@echo Collecting 'FireFox Browser' artifacts
@echo Collecting 'FireFox Browser' artifacts >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: FireFox History - Cookies - BookMarks - Auto-Complete - Cache
@mkdir C:\WIN7_8\%COMPUTERNAME%\Firefox\
powershell.exe Get-ChildItem "C:\Users\*\AppData\Roaming\Mozilla\Firefox\Profiles\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Roaming\Mozilla\Firefox\Profiles\*.*" "C:\WIN7_8\%COMPUTERNAME%\Firefox\"

:: FireFox Cache
:: powershell.exe Get-ChildItem "C:\Users\*\AppData\Roaming\Mozilla\Firefox\Profiles\*.default\Cache\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Roaming\Mozilla\Firefox\Profiles\*.default\Cache\*.*" "C:\WIN7_8\%COMPUTERNAME%\Firefox_Cache\"

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: Collecting 'HTML5 Web Storage' artifacts
@echo Collecting 'HTML5 Web Storage' artifacts
@echo Collecting 'HTML5 Web Storage' artifacts >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-ChildItem "C:\Users\*\AppData\Local\Microsoft\Internet Explorer\DOMStore\*" -Recurse >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
xcopy /C /H /E /R /K /Y "C:\Users\%USERNAME%\AppData\Local\Microsoft\Internet Explorer\DOMStore\*.*" "C:\WIN7_8\%COMPUTERNAME%\HTML5_Web_Storage\"

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

:: Only works with .NET 4.5+ & Powershell 4.0+ // This Hashes the results using MD5 algorithm; many algorithms available
:: the Get-Filehash CMD can be used on files only, not dirs; unless you use Get-ChildItem and escape the | symobol using ^
@echo hashing forensic artifact results
@echo hashing forensic artifact results >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
@echo off	  
:: powershell.exe Get-FileHash C:\WIN7_8\%COMPUTERNAME% -Algorith MD5 >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: powershell.exe Get-FileHash C:\WIN7_8\KEYS -Algorith MD5 >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: powershell.exe Get-FileHash -Path C:\WIN7_8\KEYS -Algorith MD5,SHA1,SHA512,SHA256,RIPEMD160 ^| Format-List >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: powershell.exe Get-ChildItem -Filter C:\WIN7_8\%COMPUTERNAME%\*.exe ^| Get-FileHash -Algorith MD5 >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
:: powershell.exe Get-ChildItem "\\DC1\d'$\Shared_Storage" -Filter *.exe ^| Get-FileHash -Algorith MD5 >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-ChildItem -Recurse C:\WIN7_8\%COMPUTERNAME%\ ^| Get-FileHash -Algorith MD5 >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
powershell.exe Get-ChildItem -Recurse C:\WIN7_8\KEYS\ ^| Get-FileHash -Algorith MD5 >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt
 

@echo -------------------------------------------------------------------------------------------------------------------------------------------------- >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

powershell.exe Get-EventLog -list >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@echo ~ The End ~ >> C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt

@move C:\WIN7_8\%COMPUTERNAME%\%COMPUTERNAME%-sysinfo.txt C:\WIN7_8\%COMPUTERNAME%
@move C:\WIN7_8\KEYS C:\WIN7_8\%COMPUTERNAME%

:: Only works with .NET 4.5+ & Powershell 4.0+ // This creates a text file
:: cont. embeded script takes results from C:\WIN7_8\%COMPUTERNAME% and compresses it into a .zip file which can be exfil'd from target box  
@echo off
	@echo.>"C:\WIN7_8\%COMPUTERNAME%-zip.txt
	@echo $source = "C:\WIN7_8\%COMPUTERNAME%" >> C:\WIN7_8\%COMPUTERNAME%-zip.txt
	@echo $destination = "C:\WIN7_8\%COMPUTERNAME%_BROWSER.zip" >> C:\WIN7_8\%COMPUTERNAME%-zip.txt
	@echo If (Test-path $destination) {Remove-item $destination} >> C:\WIN7_8\%COMPUTERNAME%-zip.txt
	@echo Add-Type -assembly "system.io.compression.filesystem"	>>	C:\WIN7_8\%COMPUTERNAME%-zip.txt
	@echo [io.compression.zipfile]::CreateFromDirectory($source, $destination) >> C:\WIN7_8\%COMPUTERNAME%-zip.txt

:: this converts text file to powershell script	
@move C:\WIN7_8\%COMPUTERNAME%-zip.txt C:\WIN7_8\%COMPUTERNAME%-zip.ps1

:: executes powershell script made previously  < script: zips contents of C:\WIN7_8\%COMPUTERNAME% >
@echo compressing Browser Forensic Artifacts into .ZIP file
powershell.exe -file C:\WIN7_8\%COMPUTERNAME%-zip.ps1

:: forcibly, and quietly erases all contents of C:\WIN7_8\%COMPUTERNAME%
@echo clean-up
@rmdir /S /Q C:\WIN7_8\%COMPUTERNAME%
@erase /F /Q C:\WIN7_8\*.ps1

@echo results located here: C:\WIN7_8\
:: .ZIP file with contents located here ..
:: The End
