<!--***** Begin Page 12 *****-->
<%
   
Dim oCmdPDI
Dim intPDITestID
Set oCmdPDI = CreateObject("ADODB.Command")
With oCmdPDI
	.CommandText = "spGetLastPDITestCodeID"
	.CommandType = 4
	.Parameters.Append .CreateParameter("@UserID", adInteger, adParamInput, 4, CLng(UserID))
	.Parameters.Append .CreateParameter("@TestCodeID", adInteger, adParamOutput, 4,  CLng(intPDITestID))
End With
oCmdPDI.ActiveConnection = oConn 'assumes connection object in Common.asp
oCmdPDI.Execute , , 128
intPDITestID = oCmdPDI.Parameters("@TestCodeID").Value
Set oCmdPDI = Nothing
%>
<h2><i><%=strTextStrengthsAndWeaknesses%></i></h2>
<hr>
<h1><%=strTextPossibleStrengths%></h1>
<!-- The reference below was absolute ("www.pdiprofile.com/pdi/..."). I changed it to relative. Marc L. Porlier 12/5/2004 -->
<img align="middle" src="http://<%= Application("SiteDomain") %>/pdi/SWStrengthsChart.asp?TCID=<%=intPDITestID%>&LC=<%=strLanguageCode%>"> 
<br><br>
<p style="page-break-after: always">
<!--***** End Page 12 *****-->

<!--***** Begin Page 13 *****-->
<h2><i><%=strTextStrengthsAndWeaknesses%></i></h2>
<hr>
<h1><%=strTextPossibleWeaknesses%></h1>
<!-- The reference below was absolute ("www.pdiprofile.com/pdi/..."). I changed it to relative. Marc L. Porlier 12/5/2004 -->
<img align="middle" src="http://<%= Application("SiteDomain") %>/pdi/SWWeaknessesChart.asp?TCID=<%=intPDITestID%>&LC=<%=strLanguageCode%>">
<br>
<p style="page-break-after: always">
<!--***** End Page 13 *****-->

