<%@ Page language="c#" Codebehind="organizationSurvey.aspx.cs" AutoEventWireup="false" Inherits="register.organizationSurvey" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>Survey Registration</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="ui_style.css" type="text/css" rel="stylesheet">
		<asp:literal id="cssUserTheme" runat="Server"></asp:literal>
  </HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE id="Table1" cellSpacing="0" cellPadding="2" width="100%" border="0">
				<TR>
					<TD background="<%=TopBannerBackground%>">
						<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR>
								<TD align="left"></TD>
								<TD align="center"><asp:label id="lblPageTitle" runat="server" CssClass="page-title">Label</asp:label></TD>
								<TD align="right"></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD>
						<TABLE id="Table3" cellSpacing="3" cellPadding="0" width="100%" border="0">
							<TR>
								<TD align="left" width="30%">&nbsp;</TD>
								<TD vAlign="top" align="center" width="40%">
									<TABLE id="Table4" cellSpacing="1" cellPadding="1" width="300" border="0" class=box-border>
              <TR>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
                <TD></TD>
                <TD></TD>
                <TD></TD></TR>
										<TR>
                <TD></TD>
											<TD>
												<asp:Label id="Label1" runat="server" CssClass="standard-label">First&nbsp;Name:</asp:Label></TD>
											<TD>
												<asp:TextBox id="txtFirst" runat="server" CssClass="standard-textbox" Width="200px"></asp:TextBox></TD>
											<TD>
												<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" CssClass="error-message" ErrorMessage="First name required"
													ControlToValidate="txtFirst">*</asp:RequiredFieldValidator></TD>
											<TD>&nbsp;&nbsp;&nbsp;</TD>
										</TR>
										<TR>
                <TD></TD>
											<TD>
												<asp:Label id="Label2" runat="server" CssClass="standard-label">Last&nbsp;Name:</asp:Label></TD>
											<TD>
												<asp:TextBox id="txtLast" runat="server" CssClass="standard-textbox" Width="200px"></asp:TextBox></TD>
											<TD>
												<asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" CssClass="error-message" ErrorMessage="Last name required"
													ControlToValidate="txtLast">*</asp:RequiredFieldValidator></TD>
											<TD></TD>
										</TR>
										<TR>
                <TD></TD>
											<TD>
												<asp:Label id="Label3" runat="server" CssClass="standard-label">Email:</asp:Label></TD>
											<TD>
												<asp:TextBox id="txtEmail" runat="server" CssClass="standard-textbox" Width="200px"></asp:TextBox></TD>
											<TD>
												<asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" CssClass="error-message" ErrorMessage="Email is required"
													ControlToValidate="txtEmail">*</asp:RequiredFieldValidator><BR>
												<asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server" CssClass="error-message" ErrorMessage="Not a valid email address"
													ControlToValidate="txtEmail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator></TD>
											<TD></TD>
										</TR>
										<TR>
                <TD></TD>
											<TD></TD>
											<TD>
												<asp:Button id="btnRegister" runat="server" CssClass="standard-button" Text="Register"></asp:Button></TD>
											<TD></TD>
											<TD></TD>
										</TR>
              <TR>
                <TD>&nbsp;</TD>
                <TD></TD>
                <TD></TD>
                <TD></TD>
                <TD></TD></TR>
									</TABLE>
									&nbsp;
									<asp:Label id="lblReturnMessage" runat="server" CssClass="error-message"></asp:Label></TD>
								<TD align="left" width="30%">
									<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="error-message" ShowMessageBox="True"></asp:ValidationSummary>&nbsp;</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD background="<%=FooterBackground%>">&nbsp;</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
