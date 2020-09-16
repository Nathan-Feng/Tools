@echo off&setlocal enabledelayedexpansion
echo 尝试连接开始,请稍候……
arp -d >nul
adb disconnect >nul
for /f %%a in ('arp -a^|findstr "192.168.137"') do (
	::echo %%a
	adb connect %%a > nul 2> nul
	adb root > nul 2> nul
	adb remount > nul 2> nul > tmp.tmp
	for /f %%j in (tmp.tmp) do (
		set enum=%%j
		if "%%j"=="remount" (
			del /a /q *.tmp
			echo 连接 %%a 成功 &pause
			goto end
		) else (
			del /a /q *.tmp
			echo 连接失败请检查环境 &pause
		) 
	)
)


:end
start cmd 


