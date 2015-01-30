<%@ Language=VBScript Codepage = 65001%>
<%
' Set initial critical page parameters
	Response.Buffer = True
	'On Error Resume Next
	intPageID = 54	' Behavior Relationships Page
	Dim TestCodeID, nextLink
	TestCodeID = Request.QueryString("TCID")
%>
<!--#Include File = "Include/CheckLogin.asp" -->
<!--#Include File = "Include/Common.asp" -->
<!--#Include File = "Include/PDIBehavioralRelationships.asp" -->
<%
' TODO: Remove this line of code when the German site is complete
If intLanguageID = 2 Then
	intLanguageID = 1
	strLanguageCode = "EN"
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title><%=strTextPageName%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
	<!--#Include File = "Include/HeadStuff.asp" -->
	<script src="querystring.js"></script>
	<script language="javascript">
		var qs = new Querystring();
		//alert(qs.get("TCID"));
		
		var xmlHttp;
		var rptURL;
		
		var userID = getCookie("UserID");
		
		rptURL = "http://<%=Application("SiteDomain")%>/ePDICorp/PDIReport.aspx?TCID=" + qs.get("TCID") + "&lid=<%=intLanguageID%>&res=" + qs.get("res") + "&u=" + userID;
		//alert(rptURL);

		
		function queueReport() {
			xmlHttp=GetXmlHttpObject();
			if (xmlHttp==null)
			{
				alert ("Browser does not support HTTP Request");
				return;
			}
			
			//rptURL = "http://localhost/ePDICorp/PDIReport.aspx?TCID=" + qs.get("TCID") + "&lid=<%=intLanguageID%>";
			//alert(rptURL);
				
			xmlHttp.onreadystatechange=stateChanged ;
			xmlHttp.open("GET",rptURL,true);
			xmlHttp.send(null);
				
		}
		
		function getCookie(c_name)
		{
			if (document.cookie.length>0)
			{
			c_start=document.cookie.indexOf(c_name + "=")
			if (c_start!=-1)
				{ 
				c_start=c_start + c_name.length+1 
				c_end=document.cookie.indexOf(";",c_start)
				if (c_end==-1) c_end=document.cookie.length
				return unescape(document.cookie.substring(c_start,c_end))
				} 
			}
			return ""
		}
		
		
		function stateChanged() { 
			if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
			{ 
				//alert("Your report has been generated and sent");
				//alert(xmlHttp.responseText);
			} 
		} 
		
		function GetXmlHttpObject() { 
			var objXMLHttp=null
			if (window.XMLHttpRequest)
			{
				objXMLHttp=new XMLHttpRequest()
			}
			else if (window.ActiveXObject)
			{
				objXMLHttp=new ActiveXObject("Microsoft.XMLHTTP")
			}
		
			return objXMLHttp
		
		}
	</script>
</head>
<body onload="queueReport();">
<!--#Include File = "Include/TopBanner.asp" -->
    <div id="main">
<div id="tabgraphic">
	<img src="images/S4P3<%=strLanguageCode%>.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape="poly" alt="" coords="567,53,607,53,613,58,610,65,565,65,550,58,568,53,570,53" href="PDIProfileRepProfile2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>">
		<area shape="poly" alt="" coords="624,53,662,53,677,59,663,65,625,66,616,60,623,53,625,53" href="PDIProfileSANDW.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>&lid=<%=intLanguageID%>">
	</map>
</div>
<div id="maincontent_tab">
	<!--#Include File = "Include/PDIProfileCustomBody.asp" -->
</div>
        </div>
</body>
</html>
