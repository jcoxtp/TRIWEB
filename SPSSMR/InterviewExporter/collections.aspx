<%@ Page language="c#" Codebehind="collections.aspx.cs" AutoEventWireup="false" Inherits="InterviewExporter.collections" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>collections</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"> <!-- SPSS Launcher applications stylesheet -->
		<link href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script language="javascript">
			
			function doExport()
			{
				var f = top.frames[1].frames[1].document.forms("main");
				f.all["action"].value = "export";
				f.submit();
			}
		</script>
	</HEAD>
	<body>
		<form id="collections" method="post" runat="server">
			<table id="LayoutTable" cellSpacing="0" cellPadding="0" width="100%" border="0" height="100%">
				<tr height="79">
					<td align="left" valign="middle" bordercolor="gainsboro" style="background-color:#31569C"><asp:Image ImageUrl="images/InterviewExporter.gif" Runat="server" id="Image1"></asp:Image></td>
				</tr>
				<tr height="20"> <!--td align=middle valign=center bordercolor=gainsboro bgColor=gainsboro>Collection Options</td-->
				</tr>
				<tr height="100%">
					<td align="center" valign="top" bordercolor="gainsboro">
						&nbsp;<br>
						&nbsp;<br>
						<input type="button" runat="server" id="btnExport" onclick="javascript:doExport()">
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
