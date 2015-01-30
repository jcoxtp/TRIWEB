<% Response.Buffer = True
Dim UseIE
UseIE = true
Const IP_ADDR = "65.205.160.186"

Set WebGrabber = Server.CreateObject("APWebGrabber.Object")
'WebGrabber.PrintBackgroundColors = 3
WebGrabber.URL = "http://www.pdiprofile.com/pdi/PDIReport.asp?SID=4348&TCID=277653&res=1&LID=4"
'WebGrabber.URL = "http://www.pdiprofile.com/pdi/ReportGeneration/AppModuleSelling.asp?UID=2&HT1=I&HT2=D&PDITSID=4427&lid=4&TCID=57719" 
'WebGrabber.URL = "http://localhost/Chart2DSamples/PieChart/default.htm"
 
If UseIE Then
	WebGrabber.EngineToUse = 1 'IE Engine (not built-in one, which lacks CSS support)
	WebGrabber.IETopMargin = 0.5 'inches
	WebGrabber.IELeftMargin = 1.0
	WebGrabber.IEBottomMargin = 0.35
	WebGrabber.IERightMargin = 1.0
	WebGrabber.FooterHTML = "<HTML><BODY BGCOLOR=white><div style='color:gray;font-family:Tahoma,Helvetica,Arial; font-size: 8pt;width:100%;border-top: solid 1px gray'><div style='float:right'>Page %cp% of %tp%.</div>Copyright &copy; 2003-2005 Team Resources, Inc. All Rights Reserved</div></BODY></HTML>"
	'WebGrabber.FooterHTML = "<HTML><BODY BGCOLOR=white><div style='color:gray;font-family:Tahoma,Helvetica,Arial; font-size: 8pt;'>Copyright &copy; Team Resources, Inc. All Rights Reserved&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Page %cp% of %tp%.</div></BODY></HTML>"
End If

ixi = WebGrabber.DoPrint(IP_ADDR, 64320) 
If ixi <> 0 Then
	fileOK = ixi
Else
	fileOK = 0
End If

If fileOK = 0 Then
	Response.Redirect("CheckSimple.asp?CONVID=" & WebGrabber.ConversationID)
End If
%>

<html>
<head>
<title></title>
<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
<meta name=ProgId content=VisualStudio.HTML>
<meta name=Originator content="Microsoft Visual Studio .NET 7.1">
</head>
<body>
Error creating document: <%= fileOK%>


</body>
</html>
