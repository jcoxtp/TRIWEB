<%
Const IP_ADDR = "65.205.160.186"
Set WebGrabber = Server.CreateObject("APWebGrabber.Object")
ConvID = "" & Request("CONVID")
WebGrabber.ConversationID = ConvID
xStatus = WebGrabber.GetStatus(IP_ADDR, 64320)
IsDone = 0
IsOK = 1
StatDesc = ""
Select Case xStatus
	case "001"
       StatDesc = "Connecting to thread"
    case "002"
        StatDesc = "Connecting to URL"
    case "003"
        StatDesc = "Loading HTTP Stream"
    case "004"
		StatDesc = "Creating the printer"
    case "005"
		StatDesc = "Rendering web page"
    case "006"
		StatDesc = "Spooling page"
    case "007"
		StatDesc = "Deleting the printer"
    case "008"
		StatDesc = "Thread connected"
    case "009"
		StatDesc = "Connected...waiting for host"
    case "010"
		StatDesc = "Loading images"
    case "011"
		StatDesc = "Connect Failed"
		IsDone = 1
		IsOK = 0
    case "012"
		StatDesc = "Connect Cancelled"
		IsDone = 1
		IsOK = 0
    case "013"
		StatDesc = "Page Spooled"
    case "014"
		StatDesc = "Printer Error"
		IsDone = 1
		IsOK = 0
    case "015"
		StatDesc = "Sending via FTP"
    case "016"
		StatDesc = "Sending via EMail"
		IsDone = 1
		IsOK = 0
    case "017"
		StatDesc = "FTP Failed"
		IsDone = 1
		IsOK = 0
    case "018"
		StatDesc = "EMail Failed"
		IsDone = 1
		IsOK = 0
    case "019"
		StatDesc = "Generation completed"
		IsDone = 1
		IsOK = 1
End Select
%>
<html>
<% If IsDone = 0 Then %>
<head>
<title></title>
<META HTTP-EQUIV="REFRESH" CONTENT=2>
<META HTTP-EQUIV="URL" CONTENT="checksimple.asp?CONVID=<%=ConvID%>"></head>
<body>
<H1>Waiting for results</H1>
<% Else %>
<body>
<%   end if %>

<CENTER>
<font face="Verdana" color="#008000"><strong><big>Last response from 
WebGrabber Server : (<%=xStatus%>) 
<%=StatDesc%></big></strong></font><BR>
<%   If IsDone = 0 then %>
<font face="Verdana" color="#008000"><strong><big>Waiting for next 
response.  Refreshes in 2 seconds.</big></strong></font><BR>
<%   else 
If IsOK = 0 then %>
<font face="Verdana" color="#008000"><strong><big>The request has 
resulted in an error condition</big></strong></font><BR>
<%      else 
      Set Prt2Disk = Server.CreateObject("APServer.Object")
'  Get the settings from the server
   Call Prt2Disk.FromString(WebGrabber.Prt2DiskSettings)
PDFName = Prt2Disk.NewUniqueID + ".PDF" %>
<A HREF="/PDFReports/<%=PDFName%>">
<font face="Verdana" color="#008000"><strong><big>Go get your document! 
</big></strong></font></A>
<%      end if
Call WebGrabber.CleanUp(IP_ADDR,64320)
   end if
%>

</body>
</html>
