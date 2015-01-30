<%@language = "vbscript"%>
<%
Option Explicit

Server.ScriptTimeout = 300

Function utility_GetRecordset(strSQL)
  'this function returns a disconnected recordset

   Dim objConn
   Dim objRecordset
   Dim strErrorDescription 

   'Open a connection
   On Error Resume Next
		Set objConn = Server.CreateObject("ADODB.Connection")
		objConn.Open "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=TRWebsite;password=clay45;Initial Catalog=TeamResources;Data Source=TRI2K2"
   
   If Err.number <> 0 then
    
		strErrorDescription = Err.Description
   	
   		If InStr(strErrorDescription , "SQL Server does not exist or access denied") > 1 Then
	   		Response.Write "Cannot connect to SQL Server. Please check your connection string and try again.<br><br>" & strErrorDescription
		Else
	   		Response.Write "Cannot establish connection to your database. Please check your connection string and try again.<br><br>" & strErrorDescription
	    End If
	    
    End If
   
   On Error Resume Next
		'Create the Recordset object
		Set objRecordset = Server.CreateObject("ADODB.Recordset")
		objRecordset.CursorLocation = adUseClient

		'Populate the Recordset object with a SQL query
		objRecordset.Open strSQL, objConn, adOpenStatic, adLockBatchOptimistic

		'Disconnect the Recordset
		Set objRecordset.ActiveConnection = Nothing

		'Return the Recordset
		Set utility_getRecordset = objRecordset

		'Clean up...
		objConn.Close
		Set objConn = Nothing
	 
	 If Err.number <> 0 then
   		
		strErrorDescription = Err.Description
   	
   		Response.Write "Error executing query.<br><br>" & strErrorDescription & "<br><br>" & strSQL
	
	    
    	End If
   

	
End Function

Function reprint_Report(strUrl, strPDFFileName)
Dim strActivePDFIP
Dim PDF
Dim APW
Dim R
Dim Result

	strActivePDFIP = "65.205.160.186"
	Set APW = Server.CreateObject("APWebGrabber.Object")
	Set PDF = Server.CreateObject("APServer.Object")
	PDF.NewDocumentName = strPDFFileName
	PDF.OutputDirectory = "F:\PDFReports"

	APW.Timeout = 600 '3 minutes

	APW.URL = strUrl
	APW.Prt2DiskSettings = PDF.ToString()
	' [SM] Specify various report preferences
	APW.EngineToUse = 1 'IE Engine (not built-in one, which lacks CSS support)
	APW.IETopMargin = 0.5 'inches
	APW.IELeftMargin = 0.75
	APW.IEBottomMargin = 0.5
	APW.IERightMargin = 0.75
	APW.FooterHTML = "<HTML><BODY><div style='font-family:tahoma;font-size:8pt;color:gray;border-top:solid gray 1px;'><div style='float:right;'>Page %cp% of %tp%</div>Team Resources &copy; 2003-2005 All Rights Reserved.</div></BODY></HTML>"
	
	R = APW.DoPrint(strActivePDFIP,64320)

	Result = APW.Wait(strActivePDFIP,64320,300,"") 

	If Result = "019" Then
		reprint_Report = "SUCCESS"
	Else
		reprint_Report = "Error! " & Result

	End If

	APW.Cleanup strActivePDFIP,64320
		
End Function

'Main Application Operation
Dim rsReprints
Dim sql
Dim url 
Dim resultMsg

	sql = "select r.TestCodeID, pts.PDITestSummaryID, pts.PDFFileName from purchase_testcode ptc inner join testresults r ON ptc.testcodeid = r.testcodeid inner join PDITestSummary pts on pts.TestResultsID = r.TestResultsID where redeemdate BETWEEN '10/15/2006 16:30:00' AND '10/26/2006 12:14:00 PM' AND PDFFileName IS NOT NULL AND ptc.TestCodeID >= 294308 order by ptc.testcodeid"

	
	SET rsReprints = utility_getRecordset(sql)
	
	Do While Not rsReprints.EOF
	
		url = "http://www.pdiprofile.com/pdi/PDIReport.asp?SID=" & rsReprints("PDITestSummaryID") & "&TCID=" & rsReprints("TestCodeID") & "&res=1&LID=1"
		resultMsg = reprint_Report(url, rsReprints("PDFFileName"))
		Response.Write "<br>" & rsReprints("TestCodeID") & ": " & resultMsg
		rsReprints.MoveNext
	Loop

	Set rsReprints = Nothing
	Response.Write "<br><br><h3>Process Complete</h3>"
	Response.End
%>