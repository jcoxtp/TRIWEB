<%
' Retrieve the most, least and composite numbers from the database
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
	     .CommandText = "spTestSummarySelect"
	     .CommandType = 4
	     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	     .Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	Dim nProfileID1_3
	Dim ProfileName1_3
	Dim nProfileID2_3
	Dim ProfileName2_3
	Dim SPN3
	If oConn.Errors.Count < 1 Then
		oRs.MoveFirst
		nProfileID1_3 = oRs("ProfileID1")
		nProfileID2_3 = oRs("ProfileID2")
		ProfileName1_3 = oRs("ProfileName1")
		ProfileName2_3 = oRs("ProfileName2")
		Dim nC1_3, nC2_3, nC3_3, nC4_3
		nC1_3 = oRs("C_NumberD")
		nC2_3 = oRs("C_NumberI")
		nC3_3 = oRs("C_NumberS")
		nC4_3 = oRs("C_NumberC")
	Else
		Response.Write "<br><br>" & strTextUnableToRetrieveResultsFromDatabasePlease
		Response.End
	End If
	If IsNull(nProfileID1_3) = True Then
		nProfileID1_3 = 0 
	End If
	If IsNull(nProfileID2_3) = True Then
		nProfileID2_3 = 0 
	End If
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
%>
<h1><%=strTextPossibleWeaknesses%></h1>
<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="85%">
	<tr>
		<td colspan="2"><h1><%=strTextProbableWeaknesses%></h1></td>
	</tr>
	<tr>
	  	<td valign="top"><img src="SWWeaknessesChart.asp?TCID=<%=TestCodeID%>&LC=<%=strLanguageCode%>" alt="" />
		</td>
		
		<td valign="middle"><img src="DISCCompositeSmall.asp?nD1=<%=nC1_3%>&amp;nD2=<%=nC2_3%>&amp;nD3=<%=nC3_3%>&amp;nD4=<%=nC4_3%>&res=<%=intResellerID%>" alt="" /><br />
			<strong><%=strTextCompositeGraph%></strong>
		</td>
	</tr>
</table>
</div>
<% If (SPN <> "0") And (oldButtons = True) Then %>
	<table border="0" cellspacing="0" cellpadding="0" width="570">
		<tr>
			<td align="right">
				<a HREF="PDIProfileSANDW1.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>"><img SRC="images/PDIPrevPage.gif" alt="" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a HREF="PDIProfileQuit.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>"><img SRC="images/PDINextPage.gif" alt="" /></a>
			</td>
		</tr>
	</table>
<% End If %>
