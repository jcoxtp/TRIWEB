<%@ Page language="c#" Codebehind="GetList.aspx.cs" Inherits="ManageUsers.GetList"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>ManageAccess</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript">
		function onOK()
		{
			var selectedItems = "";
			var itemslist = window.document.action.lbItems;
			for (i=0; i<itemslist.options.length; i++)
			{
				if (itemslist.options[i].selected == true)
					selectedItems += itemslist.options[i].text + ";";
			}
			
			window.returnValue = selectedItems;
			window.close();
		}
		
		function onCancel()
		{
			window.returnValue ="";
			window.close();
		}
		</script>
	</HEAD>
	<body>
		<form id="action" method="post" runat="server">
			<asp:Panel ID="ListPanel" Runat="server">
				<TABLE height="100%" width="100%">
					<TR vAlign="top">
						<TD>
							<TABLE height="100%" width="100%" align="center">
								<TR>
									<TD>
										<asp:Label id="lblTask" Runat="server"></asp:Label><BR>
										<BR>
									</TD>
								</TR>
								<TR>
									<TD align="middle" width="75%"><SELECT id="lbItems" multiple size="8" runat="server"></SELECT><BR>
										<asp:Label id="lblHelpText" Runat="server"></asp:Label></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					<TR vAlign="bottom">
						<TD align="right"><BR>
							<INPUT id="btnCancel" onclick="onCancel()" type="button" name="btnCancel" runat="server">&nbsp;
							<INPUT id="btnOK" onclick="onOK()" type="button" name="btnOK" runat="server"></TD>
					</TR>
				</TABLE>
			</asp:Panel>
			<asp:Panel ID="NoItemsPanel" Runat="server" Visible="False">
				<TABLE height="100%" width="100%">
					<TR vAlign="top">
						<TD>
							<asp:Label id="lblNoItemsText" Runat="server"></asp:Label></TD>
					</TR>
					<TR vAlign="bottom">
						<TD align="right">
							<INPUT id="btnNoItemsOK" onclick="onCancel()" type="button" name="btnNoItemsOK" runat="server"></TD>
					</TR>
				</TABLE>
			</asp:Panel>
		</form>
	</body>
</HTML>
