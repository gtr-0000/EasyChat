@echo off
set "server=http://geq.web3v.com/EasyChat"
rem ע�⣺���е����������ļ��ж���EasyChat���ڵ��ļ�����
cd "%~dp0"
title EasyChat 2019
color f9
mode 80,25
path common;common\bin;%path%
call "user\login.bat"
