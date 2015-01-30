<%@ Page language="c#" Codebehind="PurchaseConfirmation.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.PurchaseConfirmation" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title></title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script src="findDOM.js"></script>
		<script src="CtrlBehavior.js"></script>
		<script src="printpreview.js"></script>
		<LINK href="styles.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<%= getHTML("header.inc") %>
			<TABLE id="Table1" cellSpacing="8" cellPadding="2" align="center" border="0">
				<TR>
					<td width="15%" rowspan="3" align="center" valign="top" class="left-column">
						<br>
						<br>
					</td>
					<TD width="70%" class="style1" align="center">Purchase Confirmation</TD>
					<td width="15%" rowspan="3" align="center" valign="top" class="right-column">
						<br>
						<br>
						<div class="style1-body" align="right">
						</div>
					</td>
				</TR>
				<TR>
					<TD width="70%" class="section-divline">
						<TABLE id="Table5" style="HEIGHT: 22px" width="100%" border="0">
							<TR>
								<TD width="50%"></TD>
								<TD align="right" width="50%">
									<asp:LinkButton id="btnSelectContinue" runat="server" Text='Next&nbsp;<span style="font-family:webdings">8</span>'
										CssClass="q_Text-link"></asp:LinkButton></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<tr>
					<td width="70%" class="center-column">
						<p>
							<TABLE id="Table4" cellSpacing="4" cellPadding="1" width="100%" border="0">
								<TR>
									<TD></TD>
								</TR>
								<TR>
									<TD>
										<asp:Label id="literalPurchaseInfo" runat="server"></asp:Label></TD>
								</TR>
								<TR>
									<TD></TD>
								</TR>
								<TR>
									<TD align="center">
										<asp:HyperLink id="lnkPrint" runat="server" NavigateUrl="javascript:getPrint('literalPurchaseInfo')">Printable Version</asp:HyperLink></TD>
								</TR>
							</TABLE>
						</p>
						<TABLE id="Table6" style="HEIGHT: 22px" width="100%" border="0">
							<TR>
								<TD width="50%"></TD>
								<TD align="right" width="50%">
									<asp:LinkButton id="LinkButton1" runat="server" Text='Next&nbsp;<span style="font-family:webdings">8</span>'
										CssClass="q_Text-link"></asp:LinkButton></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</TABLE>
		<%= getHTML("footer.inc") %>
		</form>
	</body>
</HTML>
