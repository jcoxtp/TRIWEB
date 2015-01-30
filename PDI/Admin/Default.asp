<%@ Language=VBScript %>
<% intPageID = 61 %>
<!--#Include FILE="Include/CheckAdminLogin.asp" -->
<!--#Include virtual="/pdi/Include/common.asp" -->
<!--#Include FILE="Include/DateTimeFunctions.asp" -->
<%
	If Not IsAuthorized(4) Then
		Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	End If
%>
<!--#Include FILE="Include/header.asp" -->
<tr>
	<td valign="top" class="leftnav"><!--#Include FILE="Include/navigation.asp" --></td>
	<td valign="top" class="maincontent">
		Admin dashboard...
	</td>
</tr>
<!--#Include FILE="Include/footer.asp" -->