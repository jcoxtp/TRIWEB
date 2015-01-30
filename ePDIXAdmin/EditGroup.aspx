<%@ Page language="c#" Codebehind="EditGroup.aspx.cs" AutoEventWireup="false" Inherits="ePDIXAdmin.EditGroup" %>
<%@ Register TagPrefix="uc1" TagName="GroupEditTabs" Src="GroupEditTabs.ascx" %>
<%@ Register TagPrefix="uc1" TagName="BannerAndTabs" Src="BannerAndTabs.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>ePDIX Administration: </title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../styles/styles.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../scripts/trUser.js"></script>
		<script language="javascript" src="../scripts/findDOM.js"></script>
		<script language="javascript" src="../scripts/CtrlBehavior.js"></script>
		<script language="javascript">
			var myWin;
			
			function popUp(url, callbackMethod)
			{
				frmPDIAdmin.callbackMethod.value = callbackMethod;
				myWin = window.open(url, "popDialog", "width=500,height=600;resizable=yes;scrollbars=yes");
			}
			
			function editLeader(user) {
				frmPDIAdmin.hidLeaderID.value = user.UserID;
				frmPDIAdmin.txtLeaderName.value = user.Name;
				myWin.close();
				
				setVisibility("rfvLeader", "hidden");
			}
			
			function editCompany(company) {
				frmPDIAdmin.hidCompanyID.value = company.CompanyID;
				frmPDIAdmin.txtCompany.value = company.Name;
				myWin.close();
				
				setVisibility("rfvCompany", "hidden");
			}
			
			function isNotZero(sender, args)
			{
				var hiddenID = parseInt(args.Value);
				
				if(hiddenID < 1)
				{
					args.IsValid = false;
					return;
				}
				
				args.IsValid = true;
			}
			
			function ValidateOnSubmit()
			{
				var bRetVal = true;
				
				if(document.frmPDIAdmin.txtTeamName.value.length < 1)
				{
					setVisibility("rfvTeam", "visible");
					bRetVal = false;
				}
				
				if(document.frmPDIAdmin.hidCompanyID.value == "0")
				{
					setVisibility("rfvCompany", "visible");
					bRetVal = false;
				}
				
				if(document.frmPDIAdmin.hidLeaderID.value == "0")
				{
					setVisibility("rfvLeader", "visible");
					bRetVal = false;
				}
				
				return bRetVal;
			}
			
		</script>
	</HEAD>
	<body>
		<form id="frmPDIAdmin" method="post" encType="multipart/form-data" runat="server">
			<uc1:bannerandtabs id="BannerAndTabs1" runat="server"></uc1:bannerandtabs>
			<TABLE id="tblMain" cellSpacing="5" cellPadding="0" width="100%" border="0">
				<TR>
					<TD class="page-title"><asp:linkbutton id="btnGoToGroupListing" runat="server" CssClass="pagetitle">Group Listing</asp:linkbutton>&nbsp;<span style="FONT-WEIGHT: normal; FONT-FAMILY: webdings">8</span>&nbsp;Edit 
						Group</TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<tr>
					<td colSpan="3">&nbsp;</td>
				</tr>
				<TR>
					<TD colSpan="3"><uc1:groupedittabs id="GroupEditTabs1" runat="server"></uc1:groupedittabs>
						<TABLE class="admin-tan-border" id="tblTabs" cellSpacing="5" cellPadding="0" width="100%"
							border="0">
							<TR>
								<TD class="tan-border" style="WIDTH: 280px" vAlign="bottom" align="left" width="280"><asp:imagebutton id="btnSave" runat="server" AlternateText="Save changes to group" ImageUrl="../images/icon-floppy.gif"></asp:imagebutton>&nbsp;|&nbsp;
									<asp:imagebutton id="btnCancel" runat="server" AlternateText="Cancel and return to group listing"
										ImageUrl="../images/icon-pencil-x.gif" CausesValidation="False"></asp:imagebutton></TD>
								<TD class="tan-border" vAlign="top" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="standard-text" id="filSelect" style="WIDTH: 368px; HEIGHT: 18px" type="file"
										size="42" runat="server">&nbsp;&nbsp;&nbsp;&nbsp;
									<asp:linkbutton id="btnImportList" runat="server" CssClass="link-button">Import</asp:linkbutton></TD>
							</TR>
							<tr>
								<TD class="tan-border" style="WIDTH: 280px" vAlign="top" align="left" width="280">
									<TABLE id="Table1" cellSpacing="5" cellPadding="0" width="300" border="0">
										<TR>
											<TD style="WIDTH: 255px">
												<P>Team Name:<BR>
													<asp:textbox id=txtTeamName runat="server" CssClass="standard-text" Text="<%# _team.Name %>" Width="250px">
													</asp:textbox></P>
											</TD>
											<TD></TD>
										</TR>
										<TR>
											<TD style="WIDTH: 255px"><span id="rfvTeam" style="VISIBILITY:hidden;COLOR:red">Team 
													name is required</span></TD>
											<TD></TD>
										</TR>
										<TR>
											<TD style="WIDTH: 255px">Team Leader:<BR>
												<asp:textbox id=txtLeaderName runat="server" CssClass="standard-text" Text="<%# _team.Leader %>" Width="250px" ReadOnly="True">
												</asp:textbox></TD>
											<TD vAlign="bottom">
												<div onmouseover="this.style.cursor='hand'" onclick="popUp('AddMember.aspx', 'editLeader')"
													onmouseout="this.style.cursor='default'"><asp:image id="imgEditLeader" runat="server" AlternateText="Edit Group Leader" ImageUrl="../images/users.gif"></asp:image></div>
											</TD>
										</TR>
										<TR>
											<TD style="WIDTH: 255px"><span id="rfvLeader" style="VISIBILITY:hidden;COLOR:red">Leader 
													is required.</span></TD>
											<TD vAlign="bottom"></TD>
										</TR>
										<TR>
											<TD style="WIDTH: 255px">Company:<BR>
												<asp:textbox id=txtCompany runat="server" CssClass="standard-text" Text="<%# _team.Company %>" Width="250px" ReadOnly="True">
												</asp:textbox></TD>
											<TD vAlign="bottom">
												<div onmouseover="this.style.cursor='hand'" onclick="popUp('AddCompany.aspx', 'editCompany')"
													onmouseout="this.style.cursor='default'"><asp:image id="imgEditCompany" runat="server" AlternateText="Edit Associated Company" ImageUrl="../images/Contacts.gif"></asp:image></div>
											</TD>
										</TR>
										<TR>
											<TD style="WIDTH: 255px"><span id="rfvCompany" style="VISIBILITY:hidden;COLOR:red">Company 
													is required.</span></TD>
											<TD></TD>
										</TR>
									</TABLE>
								</TD>
								<TD class="tan-border" vAlign="top">
									<table cellSpacing="5" cellPadding="0" border="0">
										<tr>
											<td><asp:datagrid id=dtgMembers runat="server" AutoGenerateColumns="False" BorderWidth="0px" DataKeyField="ID" DataSource="<%# _team.Members %>">
													<HeaderStyle CssClass="datagrid-header"></HeaderStyle>
													<Columns>
														<asp:BoundColumn DataField="Name" HeaderText="Member">
															<HeaderStyle Width="150px"></HeaderStyle>
														</asp:BoundColumn>
														<asp:BoundColumn DataField="UserName" HeaderText="Username">
															<HeaderStyle Width="150px"></HeaderStyle>
														</asp:BoundColumn>
														<asp:BoundColumn DataField="Email" HeaderText="Email">
															<HeaderStyle Width="300px"></HeaderStyle>
														</asp:BoundColumn>
														<asp:BoundColumn DataField="Company" HeaderText="Company">
															<HeaderStyle Width="150px"></HeaderStyle>
														</asp:BoundColumn>
														<asp:TemplateColumn>
															<ItemTemplate>
																<asp:ImageButton runat="server" ImageUrl="../images/icon-delete.gif" AlternateText="Remove this member from the group"
																	CommandName="Delete" CausesValidation="false"></asp:ImageButton>
															</ItemTemplate>
														</asp:TemplateColumn>
													</Columns>
												</asp:datagrid>
											</td>
										</tr>
									</table>
								</TD>
							</tr>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD colSpan="3">
						<input type=hidden id=hidLeaderID runat="server" value="<%# _team.LeaderID %>" Width="50px" >
						<input type=hidden id=hidCompanyID runat="server" value="<%# _team.CompanyID %>" Width="50px" >
						<input id="callbackMethod" type="hidden" value="addNewMember" name="callbackMethod"></TD>
				</TR>
				<TR>
					<TD colSpan="3">
						<asp:DataGrid id="dtgExceptions" runat="server">
							<AlternatingItemStyle ForeColor="Red"></AlternatingItemStyle>
							<ItemStyle ForeColor="Red"></ItemStyle>
						</asp:DataGrid></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
