@echo off
set "server=http://geq.web3v.com/EasyChat"
rem ע�⣺���е����������ļ��ж���EasyChat���ڵ��ļ�����
cd "%~dp0"
title EasyChat 2019
color f9
mode 80,25
path common;common\bin;%path%
rem @cmd /k prompt $$
rem @exit /b
call "user\login"
