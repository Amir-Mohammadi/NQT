@echo off
cls

set "zipFile=postgresql.zip"
set "extractTo=C:\"
set "clusterdb=C:\pgsql\bin\clusterdb.exe"
set "fileSize=350000000"
set "psqlFolder=C:\pgsql\bin"

echo start downloading postgresql ...
echo ===============================================

IF EXIST "postgresql.zip" (
    echo postgresql.zip file is exist
) ELSE (
   curl -A "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64)" -L "https://sbp.enterprisedb.com/getfile.jsp?fileid=1258697" -o postgresql.zip
)

echo ===============================================



echo Extracting "%zipFile%" to "%extractTo%" ...
echo ===============================================

IF NOT EXIST "%zipFile%" (
    echo The Zip File "%zipFile%" does not exist.
)

IF not exist "%extractTo%" (
    mkdir "%extractTo%"
)

echo Please Wait to Extract ...


IF EXIST "%clusterdb%" (
    echo clusterdb has exist.
) ELSE (
    powershell -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('%zipFile%', '%extractTo%'); }"
) 

DEL "%zipFile%"

echo Extraction Complete.

cd "%psqlFolder%"
CALL initdb.exe -D ../data -U postgres -A trust
CALL pg_ctl.exe start -D ../data

cd /
cd "%psqlFolder%"

CALL psql -U postgres -p5432 -c "ALTER USER postgres WITH PASSWORD '123';" postgres
CALL psql -U postgres -p5432 -c "CREATE EXTENSION adminpack;"
CALL pg_ctl.exe restart -D  "C:\pgsql\data"

echo ===============================================



echo All Process Done Successfuly!  
@pause

