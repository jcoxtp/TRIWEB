<%   response.buffer = TRUE 
Set WebGrabber = Server.CreateObject("APWebGrabber.Object")
WebGrabber.PrintBackGroundColors = 3
'WebGrabber.URL = "http://localhost/pdi/PDIReport.asp?SID=4423&TCID=278137&res=1&LID=1"
'WebGrabber.URL = "http://localhost/PDFReports/Test.asp"
WebGrabber.URL = "http://www.pdiprofile.com/pdi/PDIReport.asp?SID=4348&TCID=277653&res=1&LID=1"
WebGrabber.EngineToUse = 1 'IE Engine (not built-in one, which lacks CSS support)
WebGrabber.IETopMargin = 1.0 'inches
WebGrabber.IELeftMargin = 1.0
WebGrabber.IEBottomMargin = 1.0
WebGrabber.IERightMargin = 1.0
ixi = WebGrabber.DoPrint("65.205.160.186",64320)
result = WebGrabber.Wait("65.205.160.186",64320,300,"019")
if result = "019" then
      Set Prt2Disk = Server.CreateObject("APServer.Object")
'  Get the settings from the server
   Call Prt2Disk.FromString(WebGrabber.Prt2DiskSettings)
   PDFName = Prt2Disk.NewUniqueID + ".PDF" %>
   <A HREF="/PDFReports/<%=PDFName%>">
   <font face="Verdana" color="#008000"><strong><big>Go get your document! 
   </big></strong></font></A>
<% else %>
   <center>
   There was an error creating the document. Result: <%= result %>
   <br>
<% end if
Call WebGrabber.CleanUp("65.205.160.186",64320)
%>
</body>
</html>