<%@ Page language="c#" Codebehind="RepPatternDesc.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.RepPatternDesc" %>
<%@ Register TagPrefix="uc1" TagName="CorpBanner" Src="CorpBanner.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Representative Pattern Description</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
<script type="text/javascript" src="scripts/jquery-1.4.2.js"></script>
<script type="text/javascript" src="scripts/jquery.corners.js"></script>
		<script src="findDOM.js"></script>
		<script src="CtrlBehavior.js"></script>
		<LINK href="rs/<%= CorporateFolder %>/styles.css" type=text/css rel=stylesheet >
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<%= getHTML("header.inc") %>
			<div id="main-content">
			<TABLE align="center" id="tblLayout" cellSpacing="0" cellPadding="0" border="0">
				<TR>
					<td class="left-column">&nbsp;</td>
					<TD class="style1" align="center">Your Unique Behavioral Style: Representative 
						Profile</TD>
					<td align="center" valign="top" class="right-column">
						<br>
						<br>
						<!-- div class="style1-body" align="right">
						</div -->
					</td>
				</TR>
				<TR>
					<td></td>
					<TD class="section-divline" vAlign="top">
						<table border="0" style="HEIGHT: 22px" width="100%">
							<TR>
								<TD width="50%">
									<asp:Button id=btnSelectContinue runat="server" Text='Submit &amp; Finish' CssClass="standard-textbox" Font-Size="Large" Height="40px" Width="250px">
									</asp:Button>
								</TD>
								<TD align="right" width="50%">
									<asp:HyperLink id=lnkBack runat="server" Text='<%# getLocalString("back") %>' NavigateUrl="javascript:history.back();" CssClass="q_Text-link">
									</asp:HyperLink>
								</TD>
							</TR>
						</table>
					</TD>
					<td></td>
				</TR>
				<tr>
					<td></td>
					<td class="center-column">
						<TABLE id="Table4" cellSpacing="1" cellPadding="1" border="0">
							<TR>
								<TD vAlign="top" align="left" style="WIDTH: 184px">
									<asp:Image id="imgRepPattern" runat="server"></asp:Image></TD>
								<TD vAlign="top">
									<h2><asp:Label id=Label5 runat="server" Text='<%# getPageText("RepProfileName") %>'>
										</asp:Label></h2>
									<BR>
									<h4>Outstanding Traits</h4>
									<asp:Label id=Label1 runat="server" Text='<%# getPageText("OutstandingTraits") %>'>
									</asp:Label><BR>
									<BR>
									<h4>Potential for Growth</h4>
									<asp:Label id=Label2 runat="server" Text='<%# getPageText("PotentialGrowth") %>'>
									</asp:Label><BR>
									<BR>
									<h4>Basic Desires</h4>
									<asp:Label id=Label3 runat="server" Text='<%# getPageText("BasicDesires") %>'>
									</asp:Label><BR>
									<BR>
									<h4>Work Setting</h4>
									<asp:Label id=Label4 runat="server" Text='<%# getPageText("WorkSetting") %>'>
									</asp:Label>
									<P></P>
								</TD>
							</TR>
							<TR>
								<TD style="WIDTH: 184px"></TD>
								<TD></TD>
							</TR>
						</TABLE>
					</td>
					<td></td>
				</tr>
				<TR class="bottom-row">
					<TD class="left-column"></TD>
					<TD class="center-column">
						<asp:TextBox id="txtRepID" runat="server" Visible="False"></asp:TextBox></TD>
					<TD class="right-column"></TD>
				</TR>
			</TABLE>
			</div>
		<%= getHTML("footer.inc") %>
		</form>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	</body>
</HTML>
