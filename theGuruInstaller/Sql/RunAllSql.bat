for /f "tokens=*" %%a in ('dir /b %1\Sql\*.sql') do "%1\MySQL Server 5.0\bin\mySql.exe" -u %2 --password=%3 < "%1\Sql\%%a"