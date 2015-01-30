<%@Page Inherits="Launcher.OptionsClass"%>
<%@ OutputCache Location="none" %>
<%@ Reference Control="RoundedTableControl.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SPSS DimensionNet</title> 
		<!-- 
 * Warning: this computer program is protected by
 * copyright law and international treaties.
 * Unauthorized reproduction or distribution of this
 * program, or any portion of it, may result in severe
 * civil and criminal penalties, and will be procecuted 
 * to the maximum extent of the law. 
 *  
 * Copyright (c) 2001-2002 SPSS Ltd. 
 -->
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="jsinclude.js"></script>
		<script type="text/javascript">
		function initLHSFrame()
		{
			window.top.document.getElementById("frmeLHS").src = "OptionsTasks.aspx?hash=" + getHash(top.location);
		}
		
		function ApplyChanges()
		{
			document.getElementById("btnApplyChanges").onclick();
		}
		
		function CancelChanges()
		{
			document.getElementById("btnCancelChanges").onclick();
		}
		</script>
	</HEAD>
	<body onload="javascript:initLHSFrame()">
		<form id="frmOptions" method="post" runat="server" target="_top">
			<asp:PlaceHolder id="phProjectOptions" runat="server"></asp:PlaceHolder><br>
			<asp:PlaceHolder id="phAppOptions" runat="server"></asp:PlaceHolder>
			<input id="btnApplyChanges" type="button" style="visibility: hidden" onserverclick="btnApplyChanges_Click" runat="server">
			<input id="btnCancelChanges" type="button" style="visibility: hidden" onserverclick="btnCancelChanges_Click" runat="server">
			<br>
			<asp:Label id="lblStatusMsg" runat="server" />
			
			</form>
	</body>
</HTML>
