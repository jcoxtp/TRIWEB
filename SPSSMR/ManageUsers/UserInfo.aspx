<%@ Page language="c#" Codebehind="UserInfo.aspx.cs" Inherits="ManageUsers.UserInfo" EnableEventValidation="false" %>
<%@ Register TagPrefix="treeview" Namespace="Microsoft.Web.UI.WebControls" Assembly="Microsoft.Web.UI.WebControls" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title><%= strTitle %></title>
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script language="javascript" src="jsinclude.js"></script>
		<script language="javascript">
		function onCancel()
		{
			_refreshOpenerWindows();
			window.returnValue="";
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
			if (document.UserInfo.tbUserName!=null)
			{
				if (document.UserInfo.tbUserName.disabled)
					document.UserInfo.tbDescription.focus();
				else
					document.UserInfo.tbUserName.focus();
			}
		}
		</script>
	</HEAD>
	<body onload="init();" style="margin: 0 0 0 0">
		<form id="UserInfo" method="post" runat="server">
			<asp:panel id="ProgressBarPanel" style="Z-INDEX: 106; POSITION: absolute" Runat="server">
				<asp:Label id="lblProgress" Runat="server"></asp:Label>
			</asp:panel>
			<asp:panel id="GetInfoPanel" style="Z-INDEX: 107; POSITION: absolute" Runat="server" Height="100%">
			<TABLE height="100%" width="100%">
				<TR vAlign="middle">
						<TD align="center">
							<TABLE id="Table2" width="100%" height="100%">
							<tr valign="middle" height="100%">
							<td>
							<table width="100%" class="style1">
								<TR>
									<TD colSpan="2">
										<asp:Panel id="panelError" Runat="server" Visible="False">
											<asp:label id="lblUserNameError" Runat="server" CssClass="errorText"></asp:label>
											<BR>
											<asp:label id="lblPasswordError" Runat="server" CssClass="errorText"></asp:label>
											<BR>
										</asp:Panel>
										<asp:ValidationSummary id="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False"></asp:ValidationSummary></TD>
								</TR>
								<TR>
									<TD>
										<asp:label id="lblUserName" Runat="server"></asp:label></TD>
									<TD>
										<asp:textbox id="tbUserName" Runat="server" Columns="20" TextMode="SingleLine" MaxLength="128"></asp:textbox></TD>
								</TR>
								<TR>
									<TD>
										<asp:label id="lblDescription" Runat="server"></asp:label></TD>
									<TD>
										<asp:textbox id="tbDescription" Runat="server" Columns="50" TextMode="SingleLine"></asp:textbox></TD>
								</TR>
								<TR>
									<TD>
										<asp:label id="lblChangePswd" Runat="server"></asp:label></TD>
									<TD>
										<asp:CheckBox id="cbChangePswd" Runat="server" OnCheckedChanged="cbChangePswd_CheckedChanged"
											AutoPostBack="True"></asp:CheckBox></TD>
								</TR>
								<TR>
									<TD></TD>
									<TD>
										<asp:Panel id="ChangePswdPanel" Runat="server">
											<TABLE id="Table3">
												<TR>
													<TD>
														<asp:label id="lblPassword" Runat="server"></asp:label></TD>
													<TD>
														<asp:textbox id="tbPassword" Runat="server" Columns="10" TextMode="Password" ></asp:textbox></TD>
												</TR>
												<TR>
													<TD>
														<asp:label id="lblConfirmPassword" Runat="server"></asp:label></TD>
													<TD>
														<asp:textbox id="tbConfirmPassword" Runat="server" Columns="10" TextMode="Password"></asp:textbox></TD>
												</TR>
											</TABLE>
										</asp:Panel></TD>
								</TR>
								<TR>
									<TD>
										<asp:label id="lblCanChangePswd" Runat="server"></asp:label></TD>
									<TD>
										<asp:checkbox id="cbCanChangePswd" Runat="server"></asp:checkbox></TD>
								</TR>
								<TR>
									<TD>
										<asp:Label id="lblMustChangePswd" Runat="server"></asp:Label></TD>
									<TD>
										<asp:CheckBox id="cbMustChangePswd" Runat="server"></asp:CheckBox></TD>
								</TR>
								<TR>
									<TD>
										<asp:Label id="lblAccountIsDisabled" Runat="server"></asp:Label></TD>
									<TD>
										<asp:CheckBox id="cbAccountIsDisabled" Runat="server"></asp:CheckBox></TD>
								</TR>
								<TR>
									<TD>
										<asp:Button id="btnUserProperties" onclick="OnUserPropertiesSelect" Runat="server" Visible="False"></asp:Button></TD>
								</TR>
								</table>
								</td>
								</tr>
								<TR vAlign="bottom" height="100%">
									<TD align="right">
										<asp:Button id="btnOK" onclick="OnOK" Runat="server" cssclass="stdbutton"></asp:Button>&nbsp;
										<INPUT class="stdbutton" id="btnCancel" onclick="onCancel()" type="button" name="btnCancel"	runat="server">
									</TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
			</asp:panel><asp:panel id="ResultsPanel" Runat="server" Visible="False">
				<TABLE id="Table4" height="100%" width="100%">
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
			</asp:panel><asp:panel id="WarningPanel" Runat="server" Visible="False">
				<TABLE id="Table5" height="100%" width="100%">
					<TR vAlign="top">
						<TD>
							<asp:Label id="lblWarning" Runat="server"></asp:Label><BR>
						</TD>
					</TR>
					<TR vAlign="bottom">
						<TD align="right">
							<asp:Button id="btnWarningOK" onclick="OnWarningOK" runat="server" cssclass="stdbutton"></asp:Button>&nbsp;
							<asp:Button id="btnWarningCancel" onclick="OnWarningCancel" runat="server" cssclass="stdbutton"></asp:Button></TD>
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
			</asp:Panel></form>
	</body>
</HTML>
