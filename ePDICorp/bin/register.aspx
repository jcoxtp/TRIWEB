<%@ Register TagPrefix="uc1" TagName="CorpBanner" Src="CorpBanner.ascx" %>
<%@ Page language="c#" Codebehind="register.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.register" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>register</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="rs/<%= CorporateFolder %>/styles.css" type=text/css rel=stylesheet >
		<style>
			UL { PADDING-LEFT: 0px; MARGIN-LEFT: 0px }
			LI { PADDING-LEFT: 0px; MARGIN-LEFT: 0px }
		</style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<%= getHTML("header.inc") %>
			<TABLE align="center" id="tblLayout" border="0" cellpadding="0" cellspacing="0">
				<TR>
					<TD width="120" class="left-column">&nbsp;</TD>
					<TD align="center" class="center-column"><%= getHTML("register.inc") %>&nbsp;</TD>
					<TD width="120" class="right-column">&nbsp;</TD>
				</TR>
				<TR>
					<TD class="left-column">&nbsp;</TD>
					<TD align="center" class="center-column"><TABLE id="tblUserInfo" cellSpacing="4" cellPadding="1" border="0" style="BORDER-RIGHT: #435b69 1px solid; BORDER-TOP: #435b69 1px solid; BORDER-LEFT: #435b69 1px solid; BORDER-BOTTOM: #435b69 1px solid"
							width="400">
							<tr>
								<td colspan="3"></td>
							</tr>
							<TR>
								<TD>First&nbsp;Name:</TD>
								<TD><asp:textbox id="txtUserFirst" runat="server" Width="152px" CssClass="standard-text"></asp:textbox><asp:requiredfieldvalidator id="rfvUserFirst" runat="server" ErrorMessage="First name required" ControlToValidate="txtUserFirst">*</asp:requiredfieldvalidator></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD>Last&nbsp;Name:</TD>
								<TD><asp:textbox id="txtUserLast" runat="server" Width="152px" CssClass="standard-text"></asp:textbox><asp:requiredfieldvalidator id="Requiredfieldvalidator1" runat="server" ErrorMessage="Last name required" ControlToValidate="txtUserLast">*</asp:requiredfieldvalidator></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD>Email:</TD>
								<TD><asp:textbox id="txtUserEmail" runat="server" Width="152px" CssClass="standard-text"></asp:textbox><asp:requiredfieldvalidator id="Requiredfieldvalidator2" runat="server" ErrorMessage="Email required" ControlToValidate="txtUserEmail">*</asp:requiredfieldvalidator>
									<asp:RegularExpressionValidator id="revUserEmail" runat="server" ControlToValidate="txtUserEmail" ErrorMessage="Your email is not in a valid format."
										ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
									<asp:Label id="lblEnterProfileCodeAbove" runat="server">Enter your profile code below or purchase one</asp:Label>
									<asp:LinkButton id="btnPurchaseProfileCode" runat="server">here</asp:LinkButton></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD></TD>
								<TD></TD>
							</TR>
						</TABLE>
						<br>
						<TABLE id="Table2" cellSpacing="4" cellPadding="1" width="400" border="0">
							<TR>
								<TD></TD>
								<TD></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD>
									<asp:Label id="lblProfileCode" runat="server">Profile&nbsp;Code:</asp:Label></TD>
								<TD>
									<asp:textbox id="txtProfileCode" runat="server" CssClass="standard-text" Width="152px"></asp:textbox></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>&nbsp;
								</TD>
								<TD></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
									<asp:Button id="btnRegister" runat="server" Text="Register and Begin Assessment" CssClass="standard-textbox"></asp:Button></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD align="center" colSpan="2"></TD>
								<TD align="center"></TD>
							</TR>
						</TABLE>
					</TD>
					<TD vAlign="top" align="left" class="right-column">
						<asp:ValidationSummary id="ValidationSummary1" runat="server"></asp:ValidationSummary></TD>
				</TR>
				<TR class="bottom-row">
					<TD class="left-column">&nbsp;</TD>
					<TD style="WIDTH: 336px" class="center-column">&nbsp;</TD>
					<TD class="right-column">&nbsp;</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
