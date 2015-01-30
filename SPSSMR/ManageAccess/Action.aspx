<%@ OutputCache Location="none" %>
<%@ Register TagPrefix="treeview" Namespace="Microsoft.Web.UI.WebControls" Assembly="Microsoft.Web.UI.WebControls" %>
<%@ Page language="c#" Codebehind="Action.aspx.cs" Inherits="ManageAccess.Action" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title><%=TitleText%></title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="jsinclude.js"></script>
		<script language="javascript">
				
		function onResultsOK()
		{
			_refreshOpenerWindows();
			window.close();
		}
		function onCancel()
		{
			window.close();
		}
		
		function checkSelected()
		{
		    var hasSelection=false;
		    var oListbox = document.getElementById('lbItems');
		    for(var i=0; i<oListbox.options.length; i++)
            {
                if(oListbox.options[i].selected)
                {
                    hasSelection=true;
                    break;
                }
            }
            if(!hasSelection)
            {
                alert(submitErrMsg);
                return false;
            }
            return true;
		}
		
		</script>
	</HEAD>
	<body>
		<form id="Action" method="post" runat="server">
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
									<TD align="middle" width="75%"><SELECT id="lbItems" multiple size="8" name="lbItems" runat="server"></SELECT><BR>
										<asp:Label id="lblHelpText" Runat="server"></asp:Label></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					<TR vAlign="bottom">
						<TD align="right"><BR>
							<asp:Button id="btnListOK" onclick="OnListOK" runat="server" cssclass="stdbutton"></asp:Button>&nbsp;
							<INPUT class="stdbutton" id="btnCancel" onclick="onCancel()" type="button" name="btnCancel"
								runat="server"></TD>
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
							<INPUT class="stdbutton" id="btnNoItemsOK" onclick="onCancel()" type="button" name="btnNoItemsOK"
								runat="server"></TD>
					</TR>
				</TABLE>
			</asp:Panel>
			<asp:Panel ID="ResultsPanel" Runat="server" Visible="False">
				<TABLE height="100%" width="100%">
					<TR vAlign="top">
						<TD>
							<asp:Label id="lblResults" Runat="server"></asp:Label><BR>
						</TD>
					</TR>
					<TR vAlign="bottom">
						<TD align="right">
							<INPUT class="stdbutton" id="btnOK" onclick="onResultsOK()" type="button" name="btnOK"
								runat="server"></TD>
					</TR>
				</TABLE>
			</asp:Panel>
			<asp:Panel ID="TreeListPanel" Runat="server" Visible="False">
				<TABLE height="100%" width="100%">
					<TR vAlign="middle">
						<TD align="center">
							<TABLE height="100%" width="100%" align="center">
								<TR>
									<TD>
										<asp:Label id="lblTreeListTask" Runat="server"></asp:Label><BR>
										<BR>
									</TD>
								</TR>
								<TR vAlign="top" height="100%">
									<TD align="left" width="75%">
									<DIV style="OVERFLOW: auto; WIDTH: 100%; HEIGHT: 100%">
										<TABLE class="style1" width="100%">
												<TR>
												<TD>
													<treeview:treeview class="style1" id="TreeList" runat="server"></treeview:treeview></TD>
											</TR>
										</TABLE>
									</div>
									</TD>
								</TR>
								<TR vAlign="bottom">
									<TD align="right"><BR>
										<asp:Button id="btnTreeListOK" onclick="OnTreeListOK" runat="server" cssclass="stdbutton"></asp:Button>&nbsp;<INPUT class="stdbutton" id="btnTreeListCancel" onclick="onCancel()" type="button" name="btnTreeListCancel" runat="server">
									</TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					
				</TABLE>
			</asp:Panel>
		</form>
	</body>
</HTML>
