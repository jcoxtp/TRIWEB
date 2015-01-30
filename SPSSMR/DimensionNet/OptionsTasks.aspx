<%@ Page language="c#" Codebehind="OptionsTasks.aspx.cs" Inherits="Launcher.OptionsTasksClass" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>options_btns</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
		<table width="100%">
			<tr align="center">
				<td><input id="btnApply" type="button" runat="server" onclick="javascript:window.top.frames['frmeRHS'].ApplyChanges()" NAME="btnApply"><br><br></td>
			</tr>
			<tr align="center">
			<td><input id="btnCancel" type="button" runat="server" onclick="javascript:window.top.frames['frmeRHS'].CancelChanges()" NAME="btnCancel"></td>
			</tr>
		</table>
		<br>
		
		</form>
	</body>
</HTML>
