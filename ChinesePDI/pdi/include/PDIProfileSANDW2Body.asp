<%
' retrieve the most, least and composite numbers 
' from the database

Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")
With oCmd
     .CommandText = "spTestSummarySelect"
     .CommandType = 4
     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
     .Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
End With
oConn.Open strDBaseConnString
oCmd.ActiveConnection = oConn
oRs.CursorLocation = 3
oRs.Open oCmd, , 0, 1

Dim nProfileID1_3
Dim ProfileName1_3
Dim nProfileID2_3
Dim ProfileName2_3
Dim SPN3

If oConn.Errors.Count < 1 then
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
else
	Response.Write "Unable to retrieve results from database. Please try again."
	Response.End
end if

if ISNULL(nProfileID1_3) = TRUE then
	nProfileID1_3 = 0 
end if 

if ISNULL(nProfileID2_3) = TRUE then
	nProfileID2_3 = 0 
end if

Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing
%>

<h1>Possible Weaknesses</h1>

<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="85%">
	<tr> 
	  	<td valign="top"><img src="sw_weaknesses_chart.asp?TCID=<%=TestCodeID%>" alt="" />
		</td>
		
		<td valign="middle"><img src="disccomposite_small.asp?nD1=<%=nC1_3%>&amp;nD2=<%=nC2_3%>&amp;nD3=<%=nC3_3%>&amp;nD4=<%=nC4_3%>&res=<%=intResellerID%>" alt="" /><br />
			<strong>Composite Graph</strong>
		</td>
	</tr>
</table>
</div>

<% if (SPN <> "0") and (oldButtons = true) then %>

	<table border="0" cellspacing="0" cellpadding="0" width="570">
		<tr>
			<td align="right">
				<a HREF="PDIProfileSANDW1.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>"><img SRC="images/PDIPrevPage.gif" alt="" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a HREF="PDIProfileQuit.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>"><img SRC="images/PDINextPage.gif" alt="" /></a>
			</td>
		</tr>
	</table>
<% end if %>
