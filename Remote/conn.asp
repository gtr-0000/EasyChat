<%
'�������ݿ⿪ʼ
dim conn,rs,sql
on error resume next
dbpath=server.mappath("userinfo.mdb")
set conn=server.createobject("adodb.connection")
conn.open "PROVIDER=Microsoft.jet.OLEDB.4.0;data source="&dbpath
'������¼����
set rs=server.createobject("adodb.recordset")
%>