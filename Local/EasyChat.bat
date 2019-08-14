@echo off
set "server=http://geq.web3v.com/EasyChat"
rem 注意：所有的批处理工作文件夹都在EasyChat所在的文件夹下
cd "%~dp0"
title EasyChat 2019
color f9
mode 80,25
path common;common\bin;%path%
call "user\login.bat"
