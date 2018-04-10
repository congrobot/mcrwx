@echo off
setlocal enabledelayedexpansion

set pj=%1
set dt=%2
set base_url=%3

@rmdir /q /s !dt!\ >NUL 2>NUL
@mkdir !dt!

xcopy *.* !dt!\ /s

del /s /q /f !dt!\*.bat
rmdir /q /s !dt!\application\views\
rmdir /q /s !dt!\application\controllers\
rmdir /q /s !dt!\application\models\
rmdir /q /s !dt!\sql\
rmdir /q /s !dt!\config\
rmdir /q /s !dt!\.idea\
rmdir /q /s !dt!\.svn\

mkdir !dt!\application\views\
mkdir !dt!\application\views\errors\
xcopy application\views\errors\*.* !dt!\application\views\errors\ /s
mkdir !dt!\application\views\!pj!\
xcopy application\views\!pj!\*.* !dt!\application\views\!pj!\ /s

mkdir !dt!\application\controllers\
copy application\controllers\index.html !dt!\application\controllers\index.html
mkdir !dt!\application\controllers\!pj!\
xcopy application\controllers\!pj!\*.* !dt!\application\controllers\!pj!\ /s

mkdir !dt!\application\models\
copy application\models\index.html !dt!\application\models\index.html
mkdir !dt!\application\models\!pj!\
xcopy application\models\!pj!\*.* !dt!\application\models\!pj!\ /s

mkdir !dt!\sql
set v=1.0

for /R sql %%f in (!pj!base_v*.sql) do (
	set t=%%f
	set k=!t:~-7,-4!
	if !v! LSS !k! (
		set v=!k!
	)
)
set ssql=sql\!pj!base_v%v%.sql
set dsql=!dt!\sql\!pj!base_v%v%.sql
copy !ssql! !dsql!

echo $config['base_url'] = '!base_url!';>>!dt!\application\config\config.php
copy config\database\!pj!.php !dt!\application\config\database.php
copy config\index\!pj!.php !dt!\index.php