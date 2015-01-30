<%@ Page language="c#" Codebehind="AddCompany.aspx.cs" AutoEventWireup="false" Inherits="TeamSummary.AddCompany" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Add Company</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="styles.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="trUser.js"></script>
		<script language="javascript">
			function addMember(idx)
			{
				var tbody = document.getElementById("tblResultsGrid").getElementsByTagName("TBODY")[0];
				//var msg = tbody.rows[idx].getElementsByTagName("INPUT")[0].value;
				var company = new Company();
				company.CompanyID = tbody.rows[idx].getElementsByTagName("INPUT")[0].value;
				company.Name = tbody.rows[idx].getElementsByTagName("TD")[1].innerText;
				company.Address = tbody.rows[idx].getElementsByTagName("TD")[2].innerText;
				company.City = tbody.rows[idx].getElementsByTagName("TD")[3].innerText;
				company.Province = tbody.rows[idx].getElementsByTagName("TD")[4].innerText;
				company.Country = tbody.rows[idx].getElementsByTagName("TD")[5].innerText;
				
				//alert(user.toXML());
				var callbackproc = window.opener.Form1.callbackMethod.value;
				eval("window.opener." + callbackproc + "(company)");
			}
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			&nbsp;
			<TABLE id="tblPageFrame" cellSpacing="2" cellPadding="1" width="100%" border="0">
				<TR>
					<TD align="right" colSpan="3"><asp:textbox id="txtCriteria" runat="server" Width="207px"></asp:textbox>&nbsp;&nbsp;&nbsp;
						<asp:button id="btnSearch" runat="server" Text="Search"></asp:button></TD>
				</TR>
				<tr>
					<td class="section-divline" colSpan="3">&nbsp;</td>
				</tr>
				<TR>
					<TD colSpan="3">
						<TABLE id="tblResultsGrid" cellSpacing="0" cellPadding="1" width="100%" border="0" runat="server">
							<TR class="datagrid-header">
								<TD style="WIDTH: 20px">&nbsp;</TD>
								<TD style="WIDTH: 241px">Company</TD>
								<TD>Address</TD>
								<TD>City</TD>
								<TD>Province</TD>
								<td>Country</td>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
