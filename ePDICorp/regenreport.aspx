<%@ Page language="c#" Codebehind="regenreport.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.regenreport" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>regenreport</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<%= getHTML("header.inc") %>
			<div id="main-content">
			<TABLE id="tblLayout" border="0">
				<TR>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<P>
							<asp:Label id="lblPageHeader" runat="server">Quid loret supsum</asp:Label></P>
						<P>
							<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="300" border="1">
								<TR>
									<TD>
										<asp:Label id="lblLanguage" runat="server">Language:</asp:Label></TD>
									<TD>
										<asp:DropDownList id="ddlLanguage" runat="server" Width="120px"></asp:DropDownList></TD>
									<TD></TD>
								</TR>
								<TR>
									<TD>
										<asp:Label id="lblRepPattern" runat="server">Rep&nbsp;Pattern:</asp:Label></TD>
									<TD>
										<asp:DropDownList id="ddlRepPattern" runat="server" Width="120px"></asp:DropDownList></TD>
									<TD>
										<asp:LinkButton id="btnViewChart" runat="server">(View&nbsp;Rep&nbsp;Pattern&nbsp;Chart)</asp:LinkButton></TD>
								</TR>
								<TR>
									<TD></TD>
									<TD></TD>
									<TD></TD>
								</TR>
								<TR>
									<TD></TD>
									<TD>
										<asp:Button id="btnRegenerate" runat="server" Text="Regenerate"></asp:Button></TD>
									<TD></TD>
								</TR>
							</TABLE>
						</P>
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
			</TABLE>
			</div>
		<%= getHTML("footer.inc") %>
		</form>
	</body>
</HTML>
