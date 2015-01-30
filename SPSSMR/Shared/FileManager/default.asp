<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="fm.asp" -->
<!-- #include file="fmutil.asp" -->
<html>
<%
	Dim oFM
	Set oFM = New FileManager
	oFM.SetXML unescape(Session.Value("FMData"))
	
	Dim strResourceFileName
	strResourceFileName = Server.MapPath( "res/literals" )
	

	' Check if resource file exists for selected language
	If Not ResourceFileExists( strResourceFileName, oFM.GetLanguage() ) Then
		If ResourceFileExists( strResourceFileName, "en-us" ) Then
			oFM.SetLanguage "en-us"
			Session.Value("FMData") = escape(oFM.GetXML())
			
			Response.Write( oFM.Transform("default.xslt") )
		Else
			' WE HAVE NO RESOURCE FILE AT ALL
			' user should check installation or contact support
			
			' Display an error in english
			Call launchResourceErrorStartPage(oFM.GetLanguage())
		End If
	Else
		Response.Write( oFM.Transform("default.xslt") )
	End If
	
	Set oFM = Nothing

	''''''''''''''''
	' Function : launchResourceErrorStartPage()
	'
	' This function will create the HTML that displays an error message telling
	' that the resourcefile for the selected language is not available.
	Sub launchResourceErrorStartPage(strSelectedLanguage)
	%>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="filemgr.css" />
	</head>
	<body style="margin: 10px">
		<h2>The application was unable to find resources for the selected language.</h2>
		<p>The selected language is : "<%=strSelectedLanguage%>"</p>
		<p>You should check that the resource file is available or contact SPSS support for help.</p>
	</body>
	<%
	End Sub
%>
</html>