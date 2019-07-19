var fso=new ActiveXObject("scripting.filesystemobject");
var word=fso.openTextFile("word.txt")
while(!word.atEndOfStream){
	GetIt(word.ReadLine());
	WSH.Sleep(700);
}
word.close();

function GetIt(word){
	try{
		WSH.stdout.write(word);
		var idstr=Hstr("https://www.shanbay.com/api/v1/bdc/search/?version=2&word="+word+"&_="+new Date().valueOf());
		var idex=/"id": (\d+),/.exec(idstr);
		WSH.stdout.write("\t"+idex[1]);
		var htstr=Hstr("https://www.shanbay.com/bdc/vocabulary/"+idex[1]+"/");
		
		var jieshi="";
		var jieshi0;
		var jieshir=/<span class="text">([^<]+)<\/span>/g;
		while(jieshi0=jieshir.exec(htstr)){
			jieshi+=jieshi0[1]+"\r\n";
		}

		if(jieshi!="")jieshi=jieshi.substr(0,jieshi.length-2);

		WSH.stdout.write("\t"+(jieshi==""?0:1));
		var liju=[];
		var lijufanyi=[];
		var liju0;
		var lijur=/<div class="annotation enex">\s*([^<.]+\.?)\s*<\/div>\s*<div class="cnex">([^<]+)<\/div>/g;
		while(liju0=lijur.exec(htstr)){
			liju.push(liju0[1].replace(/&#39;/g,"'"));
			lijufanyi.push(liju0[2]);
		}
		WSH.stdout.write("\t"+liju.length);

		var file=fso.openTextFile("burn-down.csv",8,true);

		file.write(VBStr(word)+','+VBStr(""));
		for(var i in liju) file.write(','+VBStr(liju[i]));

		file.writeline("");

		file.write(VBStr(jieshi)+','+VBStr(""));
		for(var i in lijufanyi) file.write(','+VBStr(lijufanyi[i]));

		file.writeline("");
		file.writeline("");

		file.close();

		WSH.stdout.writeline("\tOK");
	}catch(err){
		WSH.stderr.writeline(err.description);
	}
}

function Hstr(url){
	var xhr=new ActiveXObject("msxml2.xmlhttp");
	xhr.open("get",url,false);
	xhr.send();
	return xhr.responseText;
}

function VBStr(str){
	return '"'+str.replace(/"/g,'""')+'"';
}