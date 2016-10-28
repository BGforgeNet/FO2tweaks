@echo off
attrib -r data/proto/items/* /s /d >> fo2tweaks\fo2tweaks.bat.log 2>&1
attrib -r data/proto/critters/* /s /d >> fo2tweaks\fo2tweaks.bat.log 2>&1
fo2tweaks\tools\weidu.exe fo2tweaks\fo2tweaks.tp2 --nogame --log fo2tweaks\fo2tweaks.log
attrib +r data/proto/items/* /s /d >> fo2tweaks\fo2tweaks.bat.log 2>&1
attrib +r data/proto/critters/* /s /d >> fo2tweaks\fo2tweaks.bat.log 2>&1
