@ECHO OFF
SET APPNAME=tinyrc

IF NOT EXIST "build" MKDIR "build"
DEL "build\%APPNAME%.*" /Q

odin.exe build "src" -out:"build\%APPNAME%.exe" -debug -subsystem:console -warnings-as-errors
