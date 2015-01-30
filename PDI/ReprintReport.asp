<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="ProgId" content="VisualStudio.HTML">
		<meta name="Originator" content="Microsoft Visual Studio .NET 7.1">
		<%
'Page_Load
Dim strDbConnString 
strDbConnString = Application("strDbConnString")

Function getURLs()
	Dim strTemp
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set rsURLs = CreateObject("ADODB.Recordset")
	With oCmd
	.CommandText = "spGetUsersPurchasedProducts"
	.CommandType = 4
	.Parameters.Append 	.CreateParameter("@userName", adVarChar, adParamInput, 50, Request("txtUserName"))
	End With
	oConn.Open strDbConnString 

	oCmd.ActiveConnection = oConn
	rsURLs.CursorLocation = adUseClient
	rsURLs.Open oCmd, , 0, 1
	If Not rsURLs.EOF Then
	rsURLs.MoveFirst
	While Not rsURLs.EOF
		strTemp = strTemp & rsURLs("ReportURL") & "<BR>"
		rsURLs.MoveNext
	Wend
	End If
	getURLs = strTemp
End Function

%>
	</head>
	<body>
		<form action="ReprintReport.asp" method="post" id="frmReprint" name="frmReprint" onsubmit="javascript:document.frmReprint.postBack.value='T'; return true;">
			<DIV id="DIV1" ms_positioning="FlowLayout">
				<TABLE height="16" cellSpacing="0" cellPadding="0" width="128" border="0" ms_1d_layout="TRUE">
					<TR>
						<TD>Enter Username:</TD>
					</TR>
				</TABLE>
			</DIV>
			<P>
				<INPUT id="txtUserName" type="text" name="txtUserName" maxLength="50" value='<%= Request("txtUserName") %>'>
			</P>
			<P><INPUT id="Submit1" type="submit" value="Submit" name="Submit1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<INPUT id="postBack" type="hidden" maxLength="1" name="postBack"></P>
<%
If Request("postBack") = "T" Then
	Response.Write getURLs()
End If
%>
		</form>
	</body>
</html>
