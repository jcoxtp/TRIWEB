<%@ Page language="c#" Codebehind="EmailGroup.aspx.cs" AutoEventWireup="false" Inherits="ePDIXAdmin.EmailGroup" %>
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
		<script src="../scripts/findDOM.js"></script>
		<script src="../scripts/CtrlBehavior.js"></script>
		<script language="javascript">
		function setGroupVisibility()
		{
			var divID;
			for(i=0;i<3;i++)
			{
				var divTag = document.frmPDIAdmin.rblToType[i].value;
				var obj = findDOM(divTag,1);
				obj.visibility = 'hidden';
				
				if(document.frmPDIAdmin.rblToType[i].checked == true)
				{
					divID = divTag;
				}	
			}
			var visObj = findDOM(divID,1);
			visObj.visibility = 'visible';
			
		}
		
		function appendMergeCode(mergeCode)
		{
			var obj = findDOM('txtMessage',0);
			obj.value += mergeCode;
		}
		
		</script>
	</HEAD>
	<body>
		<form id="frmPDIAdmin" method="post" runat="server" enctype="multipart/form-data">
			<uc1:bannerandtabs id="BannerAndTabs1" runat="server"></uc1:bannerandtabs>
			<TABLE id="tblMain" cellSpacing="5" cellPadding="0" width="100%" border="0">
				<TR>
					<TD class="page-title"><asp:linkbutton id="btnGoToGroupListing" runat="server" CssClass="pagetitle">Group Listing</asp:linkbutton>&nbsp;<span style="FONT-WEIGHT: normal; FONT-FAMILY: webdings">8</span>&nbsp;Email 
						Group</TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<tr>
					<td colSpan="3">&nbsp;</td>
				</tr>
				<TR>
					<TD><uc1:groupedittabs id="GroupEditTabs1" runat="server"></uc1:groupedittabs>
						<TABLE class="admin-tan-border" id="tblTabs" cellSpacing="5" cellPadding="0" width="100%"
							border="0">
							<tr>
								<td>
									<table border="0" style="WIDTH: 608px; HEIGHT: 345px">
										<tr>
											<td colspan="2">&nbsp;
												<asp:button id="bSend" runat="server" text="Send" CssClass="standard-text" /></td>
										</tr>
										<TR>
											<TD style="WIDTH: 102px" vAlign="top" align="left">To:</TD>
											<TD style="WIDTH: 570px; POSITION: relative" vAlign="top" colSpan="2">
												<asp:radiobuttonlist id="rblToType" tabIndex="1" runat="server" Width="128px">
													<asp:ListItem Value="emptyforAll" Selected="True">All Participants</asp:ListItem>
													<asp:ListItem Value="status">By Status</asp:ListItem>
													<asp:ListItem Value="adHocList">Ad hoc List</asp:ListItem>
												</asp:radiobuttonlist>
												<DIV id="emptyforAll"></DIV>
												<DIV id="status" style="Z-INDEX: 100; LEFT: 150px; POSITION: absolute; TOP: 30px">
													<asp:DropDownList id="lstStatus" runat="server" CssClass="standard-text" Height="96px">
														<asp:ListItem Value="Completed">Completed</asp:ListItem>
														<asp:ListItem Value="Unfinished" Selected="True">Unfinished</asp:ListItem>
													</asp:DropDownList>&nbsp;&nbsp;</DIV>
												<DIV id="adHocList" style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; LEFT: 150px; OVERFLOW: auto; BORDER-LEFT: gray 1px solid; WIDTH: 272px; BORDER-BOTTOM: gray 1px solid; POSITION: absolute; TOP: 0px; HEIGHT: 72px">
													<asp:datalist id="listParticipants" runat="server" DataKeyField="ID" Height="56px" DataSource="<%# _team.Members %>">
														<ItemTemplate>
															<asp:CheckBox id="chkParticipant" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>'>
															</asp:CheckBox>
														</ItemTemplate>
													</asp:datalist></DIV>
											</TD>
										</TR>
										<TR>
											<TD></TD>
											<TD></TD>
										</TR>
										<tr>
											<td>CC: (optional)</td>
											<td><asp:textbox id="tCc" runat="server" columns="50" CssClass="standard-text" Width="272px" /></td>
										</tr>
										<tr>
											<td>Copy to Yourself?</td>
											<td>
												<asp:CheckBox id="chkCopyUser" runat="server"></asp:CheckBox></td>
										</tr>
										<tr>
											<td>Subject:</td>
											<td><asp:textbox id="tSubject" runat="server" columns="50" CssClass="standard-text" Width="272px" /></td>
										</tr>
										<tr>
											<td valign="top">Body:</td>
											<td>
												<asp:textbox id="tBody" runat="server" columns="50" rows="5" textmode="multiline" CssClass="standard-text" />
												<asp:checkbox id="cbIsHtml" runat="server" text="HTML" />
											</td>
										</tr>
										<tr>
											<td style="HEIGHT: 22px">Attachment:</td>
											<td style="HEIGHT: 22px"><input id="iAttachment" type="file" runat="server" NAME="iAttachment" class="standard-text"
													style="WIDTH: 272px; HEIGHT: 18px" size="26"></td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:label id="lResult" runat="server" font-bold="true" text="&nbsp;" />
											</td>
										</tr>
										<tr>
											<td colspan="2" align="right">
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</TABLE>
					</TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
			</TABLE>
		</form>
		<script language="javascript">setGroupVisibility();</script>
	</body>
</HTML>
