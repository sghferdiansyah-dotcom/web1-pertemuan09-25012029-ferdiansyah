@echo off
title Praktikum Web I - Pertemuan 9
color 0A

REM === Pindah ke folder tempat .bat ini berada ===
cd /d "%~dp0"

set MYSQL_BIN=C:\xampp\mysql\bin\mysql.exe
set SQL_FILE=praktikum.sql
set DB_NAME=web1_pertemuan09

echo ==========================================
echo   PRAKTIKUM PEMROGRAMAN WEB I - PERTEMUAN 9
echo   Basis Data Relasional dan SQL CRUD
echo ==========================================
echo.

echo Folder kerja: %CD%
echo File SQL    : %CD%\%SQL_FILE%
echo.

if not exist "%SQL_FILE%" (
    echo [ERROR] File praktikum.sql tidak ditemukan di folder ini!
    echo Pastikan .bat dan .sql ada di folder yang sama.
    pause
    exit /b
)

if not exist "%MYSQL_BIN%" (
    echo [ERROR] MySQL tidak ditemukan di: %MYSQL_BIN%
    pause
    exit /b
)

echo [1/2] Reset database %DB_NAME% ...
"%MYSQL_BIN%" -u root -e "DROP DATABASE IF EXISTS %DB_NAME%;" 2>nul
echo [OK] Database direset.
echo.

echo [2/2] Menjalankan praktikum.sql ...
echo ------------------------------------------
echo  CATATAN: Error 1452 / 1451 itu NORMAL
echo  (bukti uji integritas FK, bukan masalah).
echo ------------------------------------------
echo.

"%MYSQL_BIN%" -u root --force < "%SQL_FILE%"

echo.
echo ==========================================
echo   SELESAI!
echo ==========================================
echo   Lihat data di phpMyAdmin:
echo   http://localhost/phpmyadmin
echo ==========================================
echo.
pause
exit /b