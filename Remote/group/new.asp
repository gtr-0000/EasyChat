<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim apikey, uname

apikey = request.querystring("apikey")
uname = apikey2name(apikey)
if uname = "" then
	response.write "1 apikey����"
else
		dim name
		name = request.querystring("name")
	if len(name)<1 or len(name)>16 then
		response.write "2 ������������ӦΪ1��16֮��"
	else
		dim nameok
		nameok = true
		if name <> trim(name) then nameok = false
		if instr(1,name,vbtab,1) > 0 then nameok = false
		if instr(1,name,"*",1) > 0 then nameok = false
		if instr(1,name,"""",1) > 0 then nameok = false
		if instr(1,name,chr(10),1) > 0 then nameok = false
		if instr(1,name,chr(13),1) > 0 then nameok = false
		if instr(1,name,chr(0),1) > 0 then nameok = false
		if not nameok then
			response.write "2 ���������������ַ�"
		else
			dim rs
			set rs = dbexecf("select * from glist where name = %s", array(name))
			if not rs.eof then
				rs.close
				response.write "2 ���������ѱ�ʹ��"
			else
				rs.close
				dbexecf "insert into glist values (%s,%s,%t,1)", array(name,uname,now())
				dbexecf "insert into clist values (%s,'group',%s,%t)", array(uname,name,now())
				response.write "0 �����ɹ�"
			end if
		end if
	end if
end if

conn.close
%>
