<%
Dim nM1, nM2, nM3, nM4
Dim nL1, nL2, nL3, nL4
Dim nC1, nC2, nC3, nC4
' retrieve the most, least and composite numbers from the database
Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")
With oCmd
     .CommandText = "spTestSummarySelect"
     .CommandType = 4
     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
     .Parameters.Append .CreateParameter("@TestCodeID", 3, 1, 4, TestCodeID)
     .Parameters.Append .CreateParameter("@intLanguageID", 3, 1, 4, 6)
End With
oConn.Open strDBaseConnString
oCmd.ActiveConnection = oConn
oRs.CursorLocation = 3
oRs.Open oCmd, , 0, 1

'Response.Write TestCodeID

If oConn.Errors.Count < 1 then
	nM1 = oRs("M_NumberD")
	nM2 = oRs("M_NumberI")
	nM3 = oRs("M_NumberS")
	nM4 = oRs("M_NumberC")
	nL1 = oRs("L_NumberD")
	nL2 = oRs("L_NumberI")
	nL3 = oRs("L_NumberS")
	nL4 = oRs("L_NumberC")
	nC1 = oRs("C_NumberD")
	nC2 = oRs("C_NumberI")
	nC3 = oRs("C_NumberS")
	nC4 = oRs("C_NumberC")
else 
	Response.Write "Unable to retrieve results from database. Please try again."
	Response.End
end if
Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing
%>

<p>
The choices you made when you completed the inventory created these three graphs.
They represent three aspects of your personal style, which together present an overall
view of how others see you and how you see yourself. Read about each graph to learn more about it.
</p>

<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="85%">
	<tr>
		<td align="center" width="33%"><strong>MOST</strong></td>
		<td align="center" width="33%"><strong>LEAST</strong></td>
		<td align="center" width="34%"><strong>COMPOSITE</strong></td>
	</tr>
	<tr>
		<td align="center"><img src="discmost_small.asp?nD1=<%=nM1%>&amp;nD2=<%=nM2%>&amp;nD3=<%=nM3%>&amp;nD4=<%=nM4%>&res=<%=intResellerID%>" alt="" /><br />
							<span class="captiontext"><strong>I. Projected Concept</strong></span>
		</td>
		
		<td align="center"><img src="discleast_small.asp?nD1=<%=nL1%>&amp;nD2=<%=nL2%>&amp;nD3=<%=nL3%>&amp;nD4=<%=nL4%>&res=<%=intResellerID%>" alt="" /><br />
							<span class="captiontext"><strong>II. Private Concept</strong></span>
		</td>
		
		<td align="center"><img src="disccomposite_small.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>&res=<%=intResellerID%>" alt="" /><br />
							<span class="captiontext"><strong>III. Public Concept</strong></span>
		</td>
	</tr>
	
</table>
</div>

<p>
<strong>I. Projected Concept</strong> (MOST responses): The Projected Concept reflects how you think others want you to behave or how you want them to see you. This is the "mask" people assume in order to achieve success. The roots of your Projected Concept lie in everything you have experienced from childhood to early adulthood: family, friends, education, and religion. By early adulthood, most people have decided how they must act to get what they want in life, and that behavior becomes their Projected Concept.
</p>

<p>
<strong>II. Private Concept</strong> (LEAST responses): This is your natural behavior - what you are deep down. This behavior is a product of heredity and early environment. People display this behavior in relaxed situations (at home or with friends), when they don't sense the need for the 'mask' of the Projected Concept, or in stressful situations when holding up the mask is too difficult.
</p>

<p>
<strong>III. Public Concept</strong> (COMPOSITE): The Composite graph represents the net effect of the Private and Projected Concepts and reflects most clearly how others really see you. Note that since the Private (LEAST) Concept is set early in life and the Projected (MOST) Concept is in place by early adulthood, the COMPOSITE is also generally set. As a result, by the time we reach adulthood, deeply ingrained behavior is very difficult to change.
</p>

<!--#INCLUDE FILE="print_profile_link.asp" -->

<% if (SPN <> "0") and (oldButtons = true) then %>

	<table border="0" cellspacing="0" cellpadding="0" width="570">
		<tr>
			<td align="right"><a href="PDIProfileBehavioralChar1.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>"><img src="images/PDINextPage.gif" alt="" /></a></td>
		</tr>
	</table>
<% end if %>
<script>
<!--
SetCookie("qcompleted","1");

function SetCookie (name, value) 
{
	var argv = SetCookie.arguments;
	var argc = SetCookie.arguments.length;
	var expires = (2 < argc) ? argv[2] : null;
	var path = (3 < argc) ? argv[3] : null;
	var domain = (4 < argc) ? argv[4] : null;
	var secure = (5 < argc) ? argv[5] : false;
	document.cookie = name + "=" + escape (value) +
	((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
	((path == null) ? "" : ("; path=" + path)) +
	((domain == null) ? "" : ("; domain=" + domain)) +
	((secure == true) ? "; secure" : "");
}
-->
</script>
