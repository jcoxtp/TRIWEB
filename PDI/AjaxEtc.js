var xmlHttp;
var ajaxClientHandler;

function sendAjaxRequest(request) {
	xmlHttp=GetXmlHttpObject();
	
	if (xmlHttp==null)
	{
		return false;
	}
						
	//alert("Request event");
	
	xmlHttp.onreadystatechange=getAjaxResponse ;
	xmlHttp.open("GET",request,true);
	xmlHttp.send(null);
	
	return true;
}

function getAjaxResponse() { 
	
	//alert("Response event");
	
	if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
	{ 
		ajaxClientHandler(xmlHttp.responseText);
	} 
} 

function GetXmlHttpObject() { 
	var objXMLHttp=null
	if (window.XMLHttpRequest)
	{
		objXMLHttp=new XMLHttpRequest();
	}
	else if (window.ActiveXObject)
	{
		objXMLHttp=new ActiveXObject("Microsoft.XMLHTTP");
	}

	return objXMLHttp;
}
