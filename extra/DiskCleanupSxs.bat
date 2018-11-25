REM  Disk Cleanup to Delete Old Updates From the SxS Folder

REM This option is the same as using the Task Scheduler method, but now the updated components are immediately deleted. 
REM If had used the task, it will only clean up if the updated components are longer then 30 days installed on the system.
REM Other options see https://blog.brankovucinec.com/2014/11/06/use-dism-to-cleanup-winsxs-after-windows-update/

Dism.exe /online /Cleanup-Image /StartComponentCleanup