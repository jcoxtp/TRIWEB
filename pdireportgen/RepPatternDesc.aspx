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
		<script src="findDOM.js"></script>
		<script src="CtrlBehavior.js"></script>
		<LINK href="rs/<%= CorporateFolder %>/styles.css" type=text/css rel=stylesheet >
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<%= getHTML("header.inc") %>
			<TABLE align="center" id="Table1" cellSpacing="8" cellPadding="4" border="0">
				<TR>
					<TD width="800" class="style1" align="center">Your Unique Behavioral Style: 
						Representative Profile</TD>
					<td rowspan="3" align="center" valign="top">
						<br>
						<br>
						<!-- div class="style1-body" align="right">
						</div -->
					</td>
				</TR>
				<TR>
					<TD width="800" class="section-divline" vAlign="top">
						<table border="0" style="HEIGHT: 22px" width="100%">
							<TR>
								<TD width="50%">
									<asp:HyperLink id=lnkBack runat="server" Text='<%# getLocalString("back") %>' NavigateUrl="javascript:history.back();" CssClass="q_Text-link">
									</asp:HyperLink></TD>
								<TD align="right" width="50%">
									<asp:Button id=btnSelectContinue runat="server" Text='<%# getLocalString("next") %>' CssClass="standard-textbox">
									</asp:Button></TD>
							</TR>
						</table>
					</TD>
				</TR>
				<tr>
					<td width="800">
						<TABLE id="Table4" cellSpacing="1" cellPadding="1" width="100%" border="0">
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
									<P>Click 'Finish' above if you are satisfied that this is the pattern that <b>best</b>
									fits you. You can return to the Representative Patterns Chart by clicking on the "Review
									Another Pattern" link at the top left-hand corner.</P>
								</TD>
							</TR>
							<TR>
								<TD style="WIDTH: 184px"></TD>
								<TD></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</TABLE>
		</form>
	</body>
</HTML>
