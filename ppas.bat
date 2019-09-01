@echo off
SET THEFILE=e:\codigo~1\pascal\agenda~1\agenda\agenda.exe
echo Linking %THEFILE%
c:\dev-pas\bin\ldw.exe  E:\CODIGO~1\pascal\AGENDA~1\Agenda\rsrc.o -s   -b base.$$$ -o e:\codigo~1\pascal\agenda~1\agenda\agenda.exe link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
