@echo off
title ShopMan - Tomcat
echo ==========================================
echo   KHOI DONG SHOPMAN (Tomcat 9 + MySQL 8.0)
echo ==========================================
echo.

set "JAVA_HOME=C:\Program Files\Apache NetBeans\jdk"
set "TOMCAT_BIN=D:\apache-tomcat-9.0.123\apache-tomcat-9.0.123\bin"

set "DB_USER=root"
set "DB_PASS=root123"
set "DB_URL=jdbc:mysql://localhost:3306/shopman?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Ho_Chi_Minh"

if not exist "%TOMCAT_BIN%\catalina.bat" (
  echo [LOI] Khong tim thay Tomcat tai: %TOMCAT_BIN%
  echo Hay mo file nay bang Notepad va sua dong TOMCAT_BIN
  pause
  exit /b
)

if not exist "%JAVA_HOME%\bin\java.exe" (
  echo [LOI] Khong tim thay JDK tai: %JAVA_HOME%
  echo Hay mo file nay bang Notepad va sua dong JAVA_HOME
  pause
  exit /b
)

echo Doi dong "Server startup in ... milliseconds" roi mo:
echo     http://localhost:8080/shopman/
echo Dung dong cua so nay. Muon tat Tomcat: bam Ctrl + C.
echo.

cd /d "%TOMCAT_BIN%"
call catalina.bat run

echo.
echo Tomcat da dung. Xem thong bao loi o tren.
pause
