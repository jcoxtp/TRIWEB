<%@ Page language="c#" Codebehind="AddTeam.aspx.cs" AutoEventWireup="false" Inherits="TeamSummary.AddTeam" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Add Team</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="styles.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="trUser.js"></script>
		<script language="javascript">
			function addMember(idx)
			{
				var tbody = document.getElementById("tblResultsGrid").getElementsByTagName("TBODY")[0];
				//var msg = tbody.rows[idx].getElementsByTagName("INPUT")[0].value;
				var team = new Team();
				team.TeamID = tbody.rows[idx].getElementsByTagName("INPUT")[0].value;
				team.Name = tbody.rows[idx].getElementsByTagName("TD")[1].innerText;
				team.LeaderID = tbody.rows[idx].getElementsByTagName("INPUT")[2].innerText;
				team.Leader = tbody.rows[idx].getElementsByTagName("TD")[2].innerText;
				team.CompanyID = tbody.rows[idx].getElementsByTagName("INPUT")[3].innerText;
				team.Company = tbody.rows[idx].getElementsByTagName("TD")[3].innerText;
				
				//alert(team.toXML());
				var callbackproc = window.opener.Form1.callbackMethod.value;
				eval("window.opener." + callbackproc + "(team)");
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
								<TD style="WIDTH: 241px">Team</TD>
								<TD>Leader</TD>
								<TD>Company</TD>
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
