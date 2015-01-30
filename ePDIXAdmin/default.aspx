<%@ Page language="c#" Codebehind="default.aspx.cs" AutoEventWireup="false" Inherits="ePDIXAdmin.WebForm1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>WebForm1</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" enctype="multipart/form-data">
			<P>
				<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="You must select a data file first."
					ControlToValidate="filSelect" Font-Names="Verdana" Font-Size="8pt"></asp:RequiredFieldValidator>
				<INPUT id="filSelect" type="file" size="50" name="filMyFile" runat="server">
			</P>
			<P>
				<asp:Button id="btnImport" runat="server" Text="Import"></asp:Button></P>
			<P>
				<asp:DataGrid id="dtgResults" runat="server"></asp:DataGrid></P>
		</form>
	</body>
</HTML>
