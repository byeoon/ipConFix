:: ipConFix
:: v1.0

color 02
title ipConFix
@echo off

@echo,
@echo,

:::  _        _____            ______ _      
::: (_)      / ____|          |  ____(_)     
::: _ _ __ | |     ___  _ __ | |__   ___  __
::: | | '_ \| |    / _ \| '_ \|  __| | \ \/ /
::: | | |_) | |___| (_) | | | | |    | |>  < 
::: |_| .__/ \_____\___/|_| |_|_|    |_/_/\_\
:::   | |                                    
:::   |_|         
:::
                           
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A

@echo,  
@echo,
echo ipConFix may cause internet instability, so please save and quit any applications that require internet connectivity.
@echo,

echo 1. Renew IP
echo 2. Flush DNS and ARP cache
echo 3. Show ipconfig information
echo 4. Close
echo 5. Startup Settings
set input=
set /p input= Please choose an option:


If %input% == 1 goto FixConfig
If %input% == 2 goto ClearCache
If %input% == 3 goto DebugData
If %input% == 4 goto EndingMessage
If %input% == 5 goto Startup

@echo on

:FixConfig
:: Releases IP information, currently there is no IP connected to the user.
ipconfig /release 
ipconfig /release6
:: Renews IP information, there is a new IP is being reassigned to the user.
ipconfig /renew
ipconfig /renew6
goto EndingMessage

:ClearCache
:: Clears the DNS and ARP cache.
arp -a -d
ipconfig /flushdns
goto EndingMessage


:DebugData
:: Lists through ALL ipconfig commands, helpful for debugging or troubleshooting.
ipconfig /displaydns
ipconfig /showclassid
pause
goto EndingMessage

:EndingMessage
echo Press any key to exit.
pause


:: !!!
:: This section below is dedicated to the Startup modifier.
:: !!!


:Startup
::Make ipConFix's functions run on boot. (C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup)
echo 1. Renew IP
echo 2. Flush DNS and ARP cache
@echo,
echo 3. Back
echo,

set startupinput=
set /p startupinput= Please choose an option:

If %startupinput% == 1 goto CreateRenewOnBoot
If %startupinput% == 2 goto CreateFlushDNSOnBoot
If %startupinput% == 3 goto EndingMessage

:CreateRenewOnBoot
echo" 
ipconfig /release 
ipconfig /release6
ipconfig /renew
ipconfig /renew6
">C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\ipConFix_FixIP.bat
echo Task completed.
goto EndingMessage


:CreateFlushDNSOnBoot
echo" 
arp -a -d
ipconfig /flushdns
">C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\ipConFix_FlushDNSARP.bat
echo Task completed.
goto EndingMessage
