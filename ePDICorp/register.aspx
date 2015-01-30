<%@ Register TagPrefix="uc1" TagName="CorpBanner" Src="CorpBanner.ascx" %>
<%@ Page language="c#" Codebehind="register.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.register" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>register</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
<script type="text/javascript" src="scripts/jquery-1.4.2.js"></script>
<script type="text/javascript" src="scripts/jquery.corners.js"></script>
		<LINK href="rs/<%= CorporateFolder %>/styles.css" type=text/css rel=stylesheet >
		<style>UL { PADDING-LEFT: 0px; MARGIN-LEFT: 0px }
	LI { PADDING-LEFT: 0px; MARGIN-LEFT: 0px }
		</style>
	</HEAD>
	<body>
	   <div id="page">
		<form id="Form1" method="post" runat="server">
			<%= getHTML("header.inc") %>
			<div id="main-content">
			<TABLE id="tblLayout" cellSpacing="0" cellPadding="0" align="center" border="0">
				<TR>
					<TD class="left-column" width="120">&nbsp;</TD>
					<TD class="center-column" align="center"><%= getHTML("register.inc") %>&nbsp;</TD>
					<TD class="right-column" width="120">&nbsp;</TD>
				</TR>
				<TR>
					<TD class="left-column">&nbsp;</TD>
					<TD class="center-column" align="center">
						<TABLE id="tblUserInfo" style="BORDER-RIGHT: #435b69 1px solid; BORDER-TOP: #435b69 1px solid; BORDER-LEFT: #435b69 1px solid; BORDER-BOTTOM: #435b69 1px solid"
							cellSpacing="4" cellPadding="1" width="400" border="0">
							<tr>
								<td colSpan="3"></td>
							</tr>
							<TR>
								<TD>First&nbsp;Name:</TD>
								<TD><asp:textbox id="txtUserFirst" runat="server" CssClass="standard-text" Width="152px"></asp:textbox><asp:requiredfieldvalidator id="rfvUserFirst" runat="server" ControlToValidate="txtUserFirst" ErrorMessage="First name required">*</asp:requiredfieldvalidator></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD>Last&nbsp;Name:</TD>
								<TD><asp:textbox id="txtUserLast" runat="server" CssClass="standard-text" Width="152px"></asp:textbox><asp:requiredfieldvalidator id="Requiredfieldvalidator1" runat="server" ControlToValidate="txtUserLast" ErrorMessage="Last name required">*</asp:requiredfieldvalidator></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD>Email:</TD>
								<TD><asp:textbox id="txtUserEmail" runat="server" CssClass="standard-text" Width="152px"></asp:textbox><asp:requiredfieldvalidator id="Requiredfieldvalidator2" runat="server" ControlToValidate="txtUserEmail" ErrorMessage="Email required">*</asp:requiredfieldvalidator><asp:regularexpressionvalidator id="revUserEmail" runat="server" ControlToValidate="txtUserEmail" ErrorMessage="Your email is not in a valid format."
										ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:regularexpressionvalidator></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD><asp:label id="lblEnterProfileCodeAbove" runat="server">Enter your profile code below or purchase one</asp:label><asp:linkbutton id="btnPurchaseProfileCode" runat="server">here</asp:linkbutton></TD>
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
								<TD><asp:label id="lblProfileCode" runat="server">Profile&nbsp;Code:</asp:label></TD>
								<TD><asp:textbox id="txtProfileCode" runat="server" CssClass="standard-text" Width="152px"></asp:textbox></TD>
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
								<TD><asp:button id="btnRegister" runat="server" CssClass="standard-textbox" Text="Register and Begin Assessment"></asp:button></TD>
								<TD></TD>
							</TR>
							<TR>
								<TD align="center" colSpan="2">&nbsp;&nbsp;</TD>
								<TD align="center"></TD>
							</TR>
							<TR>
								<TD align="center" colSpan="2">
									<asp:HyperLink id="lnkToReport" runat="server" Visible="False">Click here to retrieve your existing PDI report.</asp:HyperLink></TD>
								<TD align="center"></TD>
							</TR>
						</TABLE>
					</TD>
					<TD class="right-column" vAlign="top" align="left"><asp:validationsummary id="ValidationSummary1" runat="server"></asp:validationsummary></TD>
				</TR>
				<TR class="bottom-row">
					<TD class="left-column">&nbsp;</TD>
					<TD class="center-column" style="WIDTH: 336px">&nbsp;</TD>
					<TD class="right-column">&nbsp;</TD>
				</TR>
			</TABLE>
			</div>
			<%= getHTML("footer.inc") %>
	
		</form>
	   </div>	
</body>
</HTML>
