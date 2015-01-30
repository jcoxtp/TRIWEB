<%@ Language=VBScript %>
<% intPageID = 63 %>
<!--#Include FILE="Include/CheckAdminLogin.asp" -->
<!--#Include virtual="pdi/Include/common.asp" -->
<%
	If Not IsAuthorized(4) Then 
		Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Admin Area</title>
	<meta name="generator" content="BBEdit 7.0.1">
	<link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
	<link rel="stylesheet" href="admin.css" type="text/css">
	<!--#Include FILE="../Include/HeadStuff.asp" -->	
</head>
<body>
	<!--#Include FILE="Include/header.asp" -->
	<div class="TopNav">
		<a href="../main.asp?res=<%=intResellerID%>">PDI Home</a>&nbsp;|
		<a href="../logout.asp?res=<%=intResellerID%>">Logout</a>&nbsp;
	</div>
	<div id="maincontent">
		<h1>Reseller Price Plans</h1>
		<hr>
		<%
			on error resume next
			Dim strErrMsg
			Dim oConn, oCmd, oRs
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			Set oRs = CreateObject("ADODB.Recordset")
			With oCmd
				.CommandText = "spAdminPricePlanGetAll"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			End With
		
			oConn.Open strDbConnString
			oCmd.ActiveConnection = oConn
			oRs.CursorLocation = 3
			oRs.Open oCmd, , 0, 1
			If oConn.Errors.Count < 1 then
				Response.Write "<TABLE BORDER=0 CELLPADDING=2 CELLSPACING=0 CLASS=""dgDataGrid"">"
				'== Write the Header Row ===================
				Dim HeaderText 
				'HeaderText = Array (" ID "," Reseller "," Sales "," Discount "," Commission "," Discounted Sales ", " Num Tests Purchased ")
				oRs.MoveFirst
				Response.Write "<TR CLASS=""dgHeaderRow"">"
				If IsArray(HeaderText) Then ' loop through the hard coded array
					For Each itm In HeaderText
						Response.Write("<TD CLASS=""dgHeaderCell"">")
						Response.Write itm
						Response.Write("</TD>")
					Next
				Else ' loop through the field names
					For Each fieldItem In oRs.Fields
						Response.Write("<TD CLASS=""dgHeaderCell"">")
						'Response.Write(fieldItem.Type & "<hr>")
						Response.Write fieldItem.name
						Response.Write("</TD>")
					Next
				End If
				Response.Write("<TD CLASS=""dgHeaderCell"">&nbsp;</TD>") ' header for the actions cell
				Response.Write ("</TR>")
				'== Write the Table Rows =================
				oRs.MoveFirst
				Dim bAltItem : bAltItem = False
				Do While Not oRs.EOF
					If bAltItem then
						Response.Write "<TR CLASS=""dgAltItemRow"">" : bAltItem = NOT bAltItem
					Else
						Response.Write "<TR CLASS=""dgItemRow"">" : bAltItem = NOT bAltItem
					End If
					'== Write the table cells ================
					For Each fieldItem In oRs.Fields
						If fieldItem.Type = 6 then 'currency
							Response.Write ("<TD CLASS=""dgItemCell"" align=""right"">" & FormatCurrency(fieldItem.Value,2) & "</TD>")
						ElseIf fieldItem.Type = 17 then 'unsigned tinyint
							If fieldItem.Value = 1 Then Response.Write ("<TD CLASS=""dgItemCell"">Yes</TD>")
							If fieldItem.Value = 0 Then Response.Write ("<TD CLASS=""dgItemCell"">No</TD>")
						ElseIf fieldItem.Type = 200 then 'varchar
							Response.Write ("<TD CLASS=""dgItemCell"">" & fieldItem.Value & "</TD>")
						Else
							Response.Write ("<TD CLASS=""dgItemCell"" align=""right"">" & fieldItem.Value & "</TD>")
						End If
					Next
					'== Write the action links ================
					Response.Write("<TD CLASS=""dgItemCell"" align=""center"">&nbsp;&nbsp;")
					Response.Write("<a HREF=""PricePlanEdit.asp?res=" & intResellerID & "&PPres=" & oRs("ID") & """>Edit</a>") 'pass the reseller if for the row
					Response.Write("&nbsp;&nbsp;</TD>")
					
				oRS.MoveNext
				Loop
				Response.Write ("</TABLE>")
			Else
				  strErrMsg = Err.description
				  Err.Clear
			End If
	
			If strErrMsg <> "" Then
				  Response.Write "<br>"
				  Response.Write strErrMsg
				  Response.Write "<br><br>"
			End If
	
	'		If oConn.Errors.Count < 1 then
	'			Response.Write "<STRONG>Pricing Plans</STRONG>"
	'			Response.Write "<BR><BR>"
	'			Response.Write "<a href='addpriceplan.asp'>Add New Pricing Plan</a>"
	'			Response.Write "<BR><BR>"
	'			Response.Write "No. Of Price Plans: " & oRs.RecordCount
	'			Response.Write "<BR><BR>"
	'			Dim Field, nColumns
	'			If oRs.EOF = FALSE then
	'				oRs.MoveFirst
	'				Response.Write "<TABLE BORDER=1>"
	'				Response.Write "<TR>"
	'				Response.Write "<TD><font size=2><STRONG>Price Plan Name</STRONG></TD>"
	'				Response.Write "<TD><font size=2><STRONG>Receives<br>Discount</STRONG></TD>"
	'				Response.Write "<TD><font size=2><STRONG>Receives<br>Commission</STRONG></TD>"
	'				Response.Write "<TD><font size=2><STRONG>Active</STRONG></TD>"
	'				Response.Write "<TD><font size=2><STRONG>Related<br>Companies</STRONG></TD>"
	'				Response.Write "<TD><font size=2><STRONG>Site</STRONG></TD>"
	'				Response.Write "</TR>"
	'				do while oRs.EOF = FALSE
	'					Response.Write "<TR>"
	'					Response.Write "<TD><font size=2><a href='editpriceplan.asp?PPID=" & oRs("PricePlanID") & "'>" & oRs("PricePlanName") & "</a>"
	'					Response.Write "</TD>"
	'					Response.Write "<TD><font size=2>"
	'					if oRs("ReceivesDiscount") = 1 then
	'						Response.Write "YES"
	'					else
	'						Response.Write "NO"
	'					end if
	'					Response.Write "</TD>"
	'					Response.Write "<TD><font size=2>" 
	'					if oRs("ReceivesCommission") = 1 then
	'						Response.Write "YES"
	'					else
	'						Response.Write "NO"
	'					end if
	'					Response.Write "</TD>"
	'					Response.Write "<TD><font size=2>"
	'					if oRs("Active") = 1 then
	'						Response.Write "YES"
	'					else
	'						Response.Write "NO"
	'					end if
	'					Response.Write "</TD>"
	'					Response.Write "<TD ALIGN=CENTER><font size=2><a href='priceplancos.asp?PPN=" & oRs("PricePlanName") & "&PPID=" & oRs("PricePlanID") & "'>Companies</a></TD>"
	'					Response.Write "<TD ALIGN=CENTER><font size=2><strong>" & oRs("SiteName") & "</strong></TD>"
	'					Response.Write "</TR>"
	'					oRs.MoveNext
	'				Loop
	'				Response.Write "</TABLE>"
	'			End If
	'			Response.End
	'		else
	'			  strErrMsg = Err.description
	'			  Err.Clear
	'		End If
	'	End If
	%>
	</div>
</body>
</html>
