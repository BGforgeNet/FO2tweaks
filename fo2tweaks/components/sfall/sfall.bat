@echo off
set sfall_versub1=4
set sfall_versub2=1
set sfall_versub3=0

for /f "tokens=4" %%i in ('fo2tweaks\tools\filever.exe /B /A /D ddraw.dll') do (
  set filever=%%i
)

for /f "delims=. tokens=1,2,3" %%i in ("%filever%") do (
  set ver_sub1=%%i
  set ver_sub2=%%j
  set ver_sub3=%%k
)
if not defined ver_sub1 set ver_sub1=0
if not defined ver_sub2 set ver_sub2=0
if not defined ver_sub3 set ver_sub3=0

set do_copy=0

if %ver_sub1% lss %sfall_versub1% set do_copy=1
if %ver_sub1% equ %sfall_versub1% if %ver_sub2% lss %sfall_versub2% set do_copy=1
if %ver_sub1% equ %sfall_versub1% if %ver_sub2% equ %sfall_versub2% if %ver_sub3% lss %sfall_versub3% set do_copy=1

if %do_copy% equ 1 (
  echo Updating Sfall
  copy /b /v /y ddraw.dll fo2tweaks\ddraw.dll.bak
  copy /b /v /y fo2tweaks\components\sfall\ddraw.dll ddraw.dll
)
