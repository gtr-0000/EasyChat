<!-- #include file="conn.asp" -->
<%
'�����ݿ��ж��û��Ƿ����,infoΪ����,usernameΪ�ֶ���
set rsc=server.createobject("adodb.recordset")
sqlc="select * from info where username='"&request.Form("username")&"' and password='"&request.Form("password")&"'"
rsc.open sqlc,conn,1,1
session("username")=rsc("username")
session("password")=rsc("password")
session.Timeout=30
set rsc=nothing
response.Redirect("change.asp")
'����û�������,session("username")Ϊ��
%>