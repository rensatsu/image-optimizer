@echo off
if not exist dist mkdir dist
"C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in imgopt.ahk /compress 0 /icon icon.ico /out dist\imgopt.exe
