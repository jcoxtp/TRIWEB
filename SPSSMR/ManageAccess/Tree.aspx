<%@ Page language="c#" Codebehind="Tree.aspx.cs" Inherits="ManageAccess.Tree" %>
<%@ Register TagPrefix="treeview" Namespace="Microsoft.Web.UI.WebControls" Assembly="Microsoft.Web.UI.WebControls" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SPSS ManageAccess</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="jsinclude.js"></script>
		<script language="javascript">
			function refreshInfo()
			{
				// Refresh the information frame with the latest information
				if(window.top.frames.main.document.getElementById('mainFrm') != null)
				window.top.frames.main.document.getElementById('mainFrm').src = window.top.frames.main.document.getElementById('mainFrm').src;
			}
		</script>
	</HEAD>
	<body onload="refreshInfo();">
		<form id="tree" method="post" runat="server">
		<table width="100%">
			<tr>
				<td width="100%">
					<table class="style1" width="100%">
						<tr>
							<td><treeview:treeview class="style1" id="DPMTree" runat="server"></treeview:treeview></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		</form>
	</body>
</HTML>
