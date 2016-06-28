@echo off
attrib -r data/proto/items/* /s /d
attrib -r data/proto/critters/* /s /d
fo2tweaks\tools\weidu.exe fo2tweaks\fo2tweaks.tp2 --nogame --log fo2tweaks\fo2tweaks.log
attrib +r data/proto/items/* /s /d
attrib +r data/proto/critters/* /s /d
