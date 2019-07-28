<%
'连接数据库开始
dim conn,rs,sql
on error resume next
dbpath=server.mappath("userinfo.mdb")
set conn=server.createobject("adodb.connection")
conn.open "PROVIDER=Microsoft.jet.OLEDB.4.0;data source="&dbpath
'创建记录对象
set rs=server.createobject("adodb.recordset")
%>