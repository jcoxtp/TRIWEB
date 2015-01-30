<html>
<head>
  <title>Web Grabber Test</title>
</head>
<body>
<%
' Get local path as varPath

  varPath = "F:\PDFReports"

' Define Variables
    ' EngineToUse (1=IE, 0=Native)
    varEngine = 1

    ' URL format: "http://www.activepdf.com" or "file://folder/file.htm"
    varURL = "http://www.activepdf.com/support/knowledgebase/view.cfm?kb=10544&code=vbs"
    
    ' Timeout for various calls
    varTimeout = 60
   
    ' For local machine use these defaults
    varIP = "65.205.160.186"
    varPort = "64320"

' Instantiate Objects
Set WG = CreateObject("APWebGrabber.Object")
Set APS = CreateObject("APServer.Object")

' Set activePDF Server properties
APS.OutputDirectory varPath
APS.PDFTimeout = varTimeout

' Must call before DoPrint to pass server settings to WG
WG.Prt2DiskSettings = APS.ToString()

' Set WebGrabber properties
WG.EngineToUse = varEngine
WG.URL = varURL
WG.TimeOut = varTimeout
WG.PrinterTimeout = varTimeout

' Start the conversion process
varReturn = WG.DoPrint(varIP, varPort)
If varReturn <> 0 Then
    strMsg = "'DoPrint' failed with a '" & varReturn & _
            "'" & VBCRLF & "KB article on Return codes:" & VBCRLF & _
            "http://www.activepdf.com/support/knowledgebase/viewKb.cfm?id=10033&tk=ts"
    Response.Write strMsg
    ' Clear Objects
    Set WG = Nothing
    Set APS = Nothing
    Response.End
End If

' Wait for conversion result
varReturn = WG.Wait(varIP, varPort, varTimeout, "")
If varReturn <> 19 Then
    strMsg = "'Wait' failed with a '" & varReturn & _
            "'" & VBCRLF & "KB article on Return codes:" & VBCRLF & _
            "http://www.activepdf.com/support/knowledgebase/viewKb.cfm?id=10033&tk=ts"
    Response.Write strMsg 
    ' Clear Objects
    Set WG = Nothing
    Set APS = Nothing
    Response.End
End If

' Run WG CleanUp
WG.Cleanup varIP, varPort

' Clear Objects
Set WG = Nothing
Set APS = Nothing

%>
</body>
</html>