<%
Response.Write "Application(""SiteDomain""): " & Application("SiteDomain") & "<BR />"
Response.Write "Application(""strDbConnString""): " & Application("strDbConnString")  & "<BR />"
Response.Write "Application(""ActivePDF_IP""): " & Application("ActivePDF_IP") & "<BR />"
Response.Write "Application(""PDFOut_DiskPath""): " & Application("PDFOut_DiskPath") & "<BR />"
Response.Write "Application(""PDFOut_SitePath""): " & Application("PDFOut_SitePath") & "<BR />"
Response.Write "Application(""ChartBackgroundDir""): " & Application("ChartBackgroundDir") & "<BR />"
Response.Write "Application(strTextEnter" &  strLanguageCode & "): " & Application("strTextEnter" & strLanguageCode) & "<BR />"

%>