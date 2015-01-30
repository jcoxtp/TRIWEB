<%@ Page language="c#" Codebehind="RoleInfo.aspx.cs" Inherits="ManageUsers.RoleInfo" %>
<%@ Register TagPrefix="treeview" Namespace="Microsoft.Web.UI.WebControls" Assembly="Microsoft.Web.UI.WebControls" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title><%= strTitle %></title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="jsinclude.js"></script>
		<script language="javascript">
		function onCancel()
		{
			_refreshOpenerWindows();
			window.returnValue ="";
			window.close();
		}
		
		function onResultsOK()
		{
			_refreshOpenerWindows();
			window.close();
		}
		function showProgressPanel(currentPanel)
		{
			document.getElementById(currentPanel).style.visibility = 'hidden';
			document.getElementById('lblProgress').style.visibility = 'visible';
			
		}
		function init() 
		{
			document.getElementById('lblProgress').style.visibility='hidden';
			if (document.RoleInfo.tbRoleName!=null)
			{
				if (document.RoleInfo.tbRoleName.disabled)
					document.RoleInfo.tbDescription.focus();
				else
					document.RoleInfo.tbRoleName.focus();
			}
		}
		</script>
	</HEAD>
	<body onload="init();">
		<form id="RoleInfo" method="post" runat="server">
			<asp:panel id="ProgressBarPanel" style="Z-INDEX: 106; POSITION: absolute" Runat="server">
				<asp:Label id="lblProgress" Runat="server">here</asp:Label>
			</asp:panel>
			<asp:panel id="GetInfoPanel" Runat="server">
				<TABLE height="100%" width="100%">
					<TR vAlign="middle">
						<TD align="center">
							<TABLE id="Table2" height="100%" width="100%">
								<TR vAlign="middle" height="100%">
									<TD>
										<TABLE width="100%" class="style1" >
											<TR>
												<TD colSpan="2">
													<asp:Panel id="panelError" Runat="server" Visible="False">
														<asp:label id="lblRoleNameError" Runat="server" CssClass="errorText"></asp:label>
														<BR>
													</asp:Panel>
													<asp:ValidationSummary id="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False"></asp:ValidationSummary></TD>
											</TR>
											<TR>
												<TD>
													<asp:label id="lblRoleName" Runat="server"></asp:label></TD>
												<TD>
													<asp:textbox id="tbRoleName" Runat="server" Columns="20" TextMode="SingleLine" MaxLength="64"></asp:textbox></TD>
											</TR>
											<TR>
												<TD>
													<asp:label id="lblDescription" Runat="server"></asp:label></TD>
												<TD>
													<asp:textbox id="tbDescription" Runat="server" Columns="50" TextMode="SingleLine"></asp:textbox></TD>
											</TR>
											<TR>
												<TD colSpan="2">
													<asp:CheckBox id="cbAssignToDimensionNet" Runat="server" Checked="True"></asp:CheckBox></TD>
											</TR>
										</TABLE>
									</TD>
								</TR>
								<TR vAlign="bottom" height="100%">
									<TD align="right"><BR>
										<asp:Button id="btnOK" onclick="OnOK" Runat="server" cssclass="stdbutton"></asp:Button>&nbsp;
										<INPUT class="stdbutton" id="btnCancel" onclick="onCancel()" type="button" name="btnCancel"
											runat="server">
									</TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
			</asp:panel>
			<asp:panel id="ResultsPanel" Runat="server" Visible="False">
				<TABLE height="100%" width="100%">
					<TR vAlign="top">
						<TD>
							<asp:Label id="lblResults" Runat="server"></asp:Label><BR>
							<BR>
							<asp:LinkButton id="lbAddAnother" onclick="OnAddAnother" runat="server" CssClass="darklinks"></asp:LinkButton></TD>
					</TR>
					<TR vAlign="bottom">
						<TD align="right">
							<asp:Button id="btnResultsCancel" onclick="OnResultsCancel" runat="server" cssclass="stdbutton"></asp:Button>
							<asp:Panel id="ResultsOKPanel" Runat="server">
								<INPUT class="stdbutton" id="btnResultsOK" onclick="onResultsOK()" type="button" name="btnResultsOK"
									runat="server"></asp:Panel></TD>
					</TR>
				</TABLE>
			</asp:panel>
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
										</DIV>
									</TD>
								</TR>
								<TR vAlign="bottom">
									<TD align="right"><BR>
										<asp:Button id="btnTreeListOK" onclick="OnTreeListOK" runat="server" cssclass="stdbutton"></asp:Button>&nbsp;
										<INPUT class="stdbutton" id="btnTreeListCancel" onclick="onCancel()" type="button" name="btnTreeListCancel"
											runat="server">
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
