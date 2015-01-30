
<%

'TestCode already gathered

' Need to do the following

' Call upd_PDITestSummary_CP to
' update the PDITestSummary.CustomProfile = 1
' In same tbl set CPD, CPI, CPS, CPC to their Y axis values

' Then call upd_PDITestSummary_Calc_CP to calc the custom profile

' Then retrieve and display the custom profile below



Dim PDITestSummaryID
Dim DEQUALC

DEQUALC = FALSE

IF SPN <> "0" then


	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")

	With oCmd

		 ' this calls upd_PDITestSummary_Calc_CP internally
	     .CommandText = "spTestSummaryCustomProfileUpdate"
	     .CommandType = 4

	     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	     .Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
	     .Parameters.Append .CreateParameter("@PDITestSummaryID",3, 3,4, CLng(PDITestSummaryID))


	End With

	oConn.Open strDBaseConnString
	oCmd.ActiveConnection = oConn
	oCmd.Execute , , 128

	PDITestSummaryID = oCmd.Parameters("@PDITestSummaryID").value

	If oConn.Errors.Count > 0  then

		Response.Write "Cannot update database. Please try again."
		Response.End
		
	end if 

else
	
	' we are viewing this page for historical purposes
	' so this value will be on the querystring
	PDITestSummaryID = Request.QueryString("PTSID")
	
end if 


%>

<h1>A Further Description of Your Behavior</h1>

<p>
Using your composite graph, we have built a descriptive profile of you by identifying the relationships between your high and low factors (above the center line vs. below the center line). These traits are what others see when they interact with you.
</p>

<% 
	
Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing

Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")

With oCmd

	.CommandText = "spTestSummaryCustomProfileViewSelect"
	.CommandType = 4

	.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	.Parameters.Append .CreateParameter("@PDITestSummaryID",3, 1,4, PDITestSummaryID)

End With

oConn.Open strDBaseConnString
oCmd.ActiveConnection = oConn
oRs.CursorLocation = 3
oRs.Open oCmd, , 0, 1

If oConn.Errors.Count < 1 Then

	If oRs.EOF = FALSE Then
	
		oRs.MoveFirst
	
		'Response.Write "<STRONG><font size=4>Strong</font></strong><font size=3> - These have a difference of 20 or more.</font>"
		'Response.Write "<br><br>" %>
		
		<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
		
	 	<%
	 	do while oRs.EOF = FALSE
			
			If oRs("PDICustomProfileName") = "DOverI" AND oRs("CustomProfileType") = "S" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/doveri.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strDOVERI_Title%></h2>
							
						<p><%=strDOVERI%></p>
					</td>
				</tr>
				
			<%	
			ElseIf oRs("PDICustomProfileName") = "DOverS" AND oRs("CustomProfileType") = "S" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/dovers.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strDOVERS_Title%></h2>
							
						<p><%=strDOVERS%></p>
					</td>
				</tr>			
			
			<%		
			ElseIf oRs("PDICustomProfileName") = "DOverC" AND oRs("CustomProfileType") = "S" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/doverc.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strDOVERC_Title%></h2>
							
						<p><%=strDOVERC%></p>
					</td>
				</tr>			
			
			<%		
			ElseIf oRs("PDICustomProfileName") = "IOverD" AND oRs("CustomProfileType") = "S" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/ioverd.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strIOVERD_Title%></h2>
							
						<p><%=strIOVERD%></p>
					</td>
				</tr>			
			
			<%		
			ElseIf oRs("PDICustomProfileName") = "IOverS" AND oRs("CustomProfileType") = "S" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/iovers.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strIOVERS_Title%></h2>
							
						<p><%=strIOVERS%></p>
					</td>
				</tr>		
			
			<%
			ElseIf oRs("PDICustomProfileName") = "IOverC" AND oRs("CustomProfileType") = "S" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/ioverc.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strIOVERC_Title%></h2>
							
						<p><%=strIOVERC%></p>
					</td>
				</tr>			

			<%
			ElseIf oRs("PDICustomProfileName") = "SOverD" AND oRs("CustomProfileType") = "S" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/soverd.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strSOVERD_Title%></h2>
							
						<p><%=strSOVERD%></p>
					</td>
				</tr>			

			<%
			ElseIf oRs("PDICustomProfileName") = "SOverI" AND oRs("CustomProfileType") = "S" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/soveri.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strSOVERI_Title%></h2>
							
						<p><%=strSOVERI%></p>
					</td>
				</tr>		
	
			<%
			ElseIf oRs("PDICustomProfileName") = "SOverC" AND oRs("CustomProfileType") = "S" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/soverc.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strSOVERC_Title%></h2>
							
						<p><%=strSOVERC%></p>
					</td>
				</tr>			
	
			<%
			ElseIf oRs("PDICustomProfileName") = "COverD" AND oRs("CustomProfileType") = "S" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/coverd.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strCOVERD_Title%></h2>
							
						<p><%=strCOVERD%></p>
					</td>
				</tr>			
			
			<%
			ElseIf oRs("PDICustomProfileName") = "COverI" AND oRs("CustomProfileType") = "S" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/coveri.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strCOVERI_Title%></h2>
							
						<p><%=strCOVERI%></p>
					</td>
				</tr>			

			<%
			ElseIf oRs("PDICustomProfileName") = "COverS" AND oRs("CustomProfileType") = "S" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/covers.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strCOVERS_Title%></h2>
							
						<p><%=strCOVERS%></p>
					</td>
				</tr>			

			<%
			End If
		
			oRs.MoveNext
		
		Loop
		
		
		oRs.MoveFirst
		
		'Response.Write "<STRONG><font size=4>Moderate</strong><font size=3> - These have a difference of less than 20.</font>"
		'Response.Write "<br><br>"
		
		do while oRs.EOF = FALSE
				
			If oRs("PDICustomProfileName") = "DOverI" AND oRs("CustomProfileType") = "M" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/doveri.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strDOVERI_Title%></h2>
							
						<p><%=strDOVERI%></p>
					</td>
				</tr>
	
			<%
			ElseIf oRs("PDICustomProfileName") = "DOverS" AND oRs("CustomProfileType") = "M" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/dovers.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strDOVERS_Title%></h2>
							
						<p><%=strDOVERS%></p>
					</td>
				</tr>		
			
			<%
			ElseIf oRs("PDICustomProfileName") = "DOverC" AND oRs("CustomProfileType") = "M" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/doverc.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strDOVERC_Title%></h2>
							
						<p><%=strDOVERC%></p>
					</td>
				</tr>			
		
			<%
			ElseIf oRs("PDICustomProfileName") = "IOverD" AND oRs("CustomProfileType") = "M" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/ioverd.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strIOVERD_Title%></h2>
							
						<p><%=strIOVERD%></p>
					</td>
				</tr>			
		
			<%
			ElseIf oRs("PDICustomProfileName") = "IOverS" AND oRs("CustomProfileType") = "M" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/iovers.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strIOVERS_Title%></h2>
							
						<p><%=strIOVERS%></p>
					</td>
				</tr>			
	
			<%
			ElseIf oRs("PDICustomProfileName") = "IOverC" AND oRs("CustomProfileType") = "M" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/ioverc.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strIOVERC_Title%></h2>
							
						<p><%=strIOVERC%></p>
					</td>
				</tr>			

			<%
			ElseIf oRs("PDICustomProfileName") = "SOverD" AND oRs("CustomProfileType") = "M" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/soverd.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strSOVERD_Title%></h2>
							
						<p><%=strSOVERD%></p>
					</td>
				</tr>			

			<%
			ElseIf oRs("PDICustomProfileName") = "SOverI" AND oRs("CustomProfileType") = "M" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/soveri.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strSOVERI_Title%></h2>
							
						<p><%=strSOVERI%></p>
					</td>
				</tr>			
			
			<%
			ElseIf oRs("PDICustomProfileName") = "SOverC" AND oRs("CustomProfileType") = "M" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/soverc.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strSOVERC_Title%></h2>
							
						<p><%=strSOVERC%></p>
					</td>
				</tr>			
			
			<%
			ElseIf oRs("PDICustomProfileName") = "COverD" AND oRs("CustomProfileType") = "M" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/coverd.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strCOVERD_Title%></h2>
							
						<p><%=strCOVERD%></p>
					</td>
				</tr>			

			<%
			ElseIf oRs("PDICustomProfileName") = "COverI" AND oRs("CustomProfileType") = "M" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/coveri.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strCOVERI_Title%></h2>
							
						<p><%=strCOVERI%></p>
					</td>
				</tr>			
			
			<%
			ElseIf oRs("PDICustomProfileName") = "COverS" AND oRs("CustomProfileType") = "M" Then %>
			
				<tr>
					<td valign="top" width="39"><img src="images/covers.gif" width="27" height="34" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strCOVERS_Title%></h2>
							
						<p><%=strCOVERS%></p>
					</td>
				</tr>			
			
			<%
			ElseIf oRs("PDICustomProfileName") = "DEQUALC" Then %>
			
				<tr>
					<td valign="top" width="69"><img src="images/dequalc.gif" width="57" height="25" alt="" />
					</td>
						
					<td valign="top">
						<h2><%=strDEQUALC_Title%></h2>
							
						<p><%=strDEQUALC%></p>
					</td>
				</tr>			

			<%
			End If
		
			oRs.MoveNext
		
		Loop %>
		
		</table>
	
	<%
	End If		
	
End If
		
Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing

%>

<br />

<% if (SPN <> "0") and (oldButtons = true) then %>
	
	<table border="0" cellspacing="0" cellpadding="0" width="570">
		<tr>
			<td align="right">
				<a href="PDIProfileRepProfile2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>"><img src="images/PDIPrevPage.gif" alt="" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="PDIProfileSANDW1.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>"><img src="images/PDINextPage.gif" alt="" /></a>
			</td>
		</tr>
	</table>
	
<% end if %>


