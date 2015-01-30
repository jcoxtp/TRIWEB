<%@ Page language="c#" Codebehind="AddMember.aspx.cs" AutoEventWireup="false" Inherits="ePDIXAdmin.AddMember" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>AddMember</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../styles/styles.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../scripts/trUser.js"></script>
		<script language="javascript">
			function addMember(idx)
			{
				var tbody = document.getElementById("tblResultsGrid").getElementsByTagName("TBODY")[0];
				//var msg = tbody.rows[idx].getElementsByTagName("INPUT")[0].value;
				var user = new trUser();
				user.UserID = tbody.rows[idx].getElementsByTagName("INPUT")[0].value;
				user.UserName = tbody.rows[idx].getElementsByTagName("TD")[1].innerText;
				user.Name = tbody.rows[idx].getElementsByTagName("TD")[2].innerText;
				user.Email = tbody.rows[idx].getElementsByTagName("TD")[3].innerText;
				user.Company = tbody.rows[idx].getElementsByTagName("TD")[4].innerText;
				
				//alert(user.toXML());
				var callbackproc = window.opener.frmPDIAdmin.callbackMethod.value;
				eval("window.opener." + callbackproc + "(user)");
			}
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			&nbsp;
			<TABLE id="tblPageFrame" cellSpacing="2" cellPadding="1" width="100%" border="0">
				<TR>
					<TD align="right" colSpan="3"><asp:textbox id="txtCriteria" runat="server" Width="207px" CssClass="standard-text"></asp:textbox>&nbsp;&nbsp;&nbsp;
						<asp:button id="btnSearch" runat="server" Text="Search" CssClass="standard-text"></asp:button></TD>
				</TR>
				<tr>
					<td class="section-divline" colSpan="3">&nbsp;</td>
				</tr>
				<TR>
					<TD colSpan="3">
						<div id="div-datagrid">
							<TABLE id="tblResultsGrid" cellSpacing="0" cellPadding="1" width="100%" border="0" runat="server">
								<TR class="datagrid-header-locked">
									<TD style="WIDTH: 27px">&nbsp;</TD>
									<TD style="WIDTH: 110px">Username</TD>
									<TD>Name</TD>
									<TD>Email</TD>
									<TD>Company</TD>
								</TR>
							</TABLE>
						</div>
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
