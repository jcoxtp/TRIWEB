<%@ Page language="c#" Codebehind="FindUser.aspx.cs" AutoEventWireup="false" Inherits="TeamSummary.FindUser" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>FindUser</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="styles.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD>Search:
						<asp:TextBox id="txtSearch" runat="server" Width="176px" CssClass="standard-text"></asp:TextBox>&nbsp;&nbsp;
						<asp:ImageButton id="btnSearch" runat="server" ImageUrl="../images/Search.gif"></asp:ImageButton></TD>
				</TR>
				<TR>
					<TD>
						<asp:DataList id="DataList1" runat="server"></asp:DataList></TD>
				</TR>
				<TR>
					<TD></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
