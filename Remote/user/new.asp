<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim name, pass

name = request.querystring("name")
pass = request.querystring("pass")

if len(name)<1 or len(name)>16 then
	response.write "1 �û�������ӦΪ1��16֮��"
else
	dim nameok
	nameok = true
	if name <> trim(name) then nameok = false
	if instr(1,name,vbtab,1) > 0 then nameok = false
	if instr(1,name,"*",1) > 0 then nameok = false
	if instr(1,name,chr(10),1) > 0 then nameok = false
	if instr(1,name,chr(13),1) > 0 then nameok = false
	if instr(1,name,chr(0),1) > 0 then nameok = false
	if not nameok then
		response.write "1 �û����������ַ�"
	else
		dim rs
		set rs = dbexecf("select * from ulist where name = %s", array(name))
		if not rs.eof then
			rs.close
			response.write "1 �û����ѱ�ʹ��"
		else
			rs.close
			if len(pass)<1 or len(pass)>32 then
				response.write "2 ���볤�Ȳ���ȷ"
			else
				set rs = dbexecf("insert into ulist values (%s,%s,%t,null,null)", array(name,pass,now()))
				response.write "0 ע��ɹ�"
			end if
		end if
	end if
end if

conn.close
%>
