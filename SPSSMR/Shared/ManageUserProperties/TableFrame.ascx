<%@ Control Language="c#" AutoEventWireup="false" Codebehind="TableFrame.ascx.cs" Inherits="ManageUserProperties.TableFrame" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table cellPadding="0" Class="RoundedTable" width="100%">
	<THEAD>
		<tr>
			<td class="RoundedTableDarkHeaderTL">
				<div style="HEIGHT: 30px; WIDTH: 10px"></div>
			</td>
			<td class="RoundedTableDarkHeaderT" align="left" valign="middle">
				<asp:Label CssClass="RoundedTableLabel10" Runat="server" ID="Caption"></asp:Label>
			</td>
			<td class="RoundedTableDarkHeaderT" align="right" valign="middle">
				<nobr>
					<a class="staticdark" style="CURSOR: hand; TEXT-DECORATION: none" id="DeleteAnc" tabIndex="-1" runat="server" onserverclick="TableFrame_Delete">
						<img runat="server" src="~/Shared/images/delete.png" style="MARGIN-LEFT: 15px" border="0" width="16" height="16" align="right">
					</a>
					<a class="staticdark" style="CURSOR: hand; TEXT-DECORATION: none" id="EditAnc" tabIndex="-1" runat="server" onserverclick="TableFrame_Edit">
						<img runat="server" src="~/Shared/images/edit.png" border="0" width="16" height="16" align="right">
					</a>
					<a class="staticdark" style="CURSOR: hand; TEXT-DECORATION: none" id="AddAnc" tabIndex="-1" runat="server" onserverclick="TableFrame_Add">
						<img runat="server" src="~/Shared/images/add.png" border="0" width="16" height="16" align="right">
					</a>
					<a class="staticdark" style="CURSOR: hand; TEXT-DECORATION: none" id="MinAnc" tabIndex="-1" runat="server" onserverclick="TableFrame_Collapse">
						<img runat="server" src="~/Shared/images/roundedtablecontrol/collapse.gif" border="0" width="18" height="16" align="right"> 
					</a>
					<a class="staticdark" style="CURSOR: hand; TEXT-DECORATION: none" id="MaxAnc" tabIndex="-1" runat="server" onserverclick="TableFrame_Expand">
						<img runat="server" src="~/Shared/images/roundedtablecontrol/expand.gif" border="0" width="18" height="16" align="right"> 
					</a>
				</nobr>
			</td>
			<td class="RoundedTableDarkHeaderTR">
				<div style="HEIGHT: 30px; WIDTH: 10px"></div>
			</td>
		</tr>
	</THEAD>
	<TBODY>
		<TR>
			<TD class="RoundedTableLightInfoL"></TD>
			<TD width="100%" colSpan="2">
				<asp:placeholder id="GridPlaceholder" runat="server"></asp:placeholder>
			</TD>
			<TD class="RoundedTableLightInfoR"></TD>
		</TR>
	</TBODY>
    <TFOOT>
		<tr>
			<td class="RoundedTableDarkFooterBL">
				<div style="HEIGHT: 10px; WIDTH: 10px"></div>
			</td>
			<td height="9" class="RoundedTableDarkFooterB" colspan="2">&nbsp;</td>
			<td class="RoundedTableDarkFooterBR">
				<div style="HEIGHT: 10px; WIDTH: 10px"></div>
			</td>
		</tr>
    </TFOOT>
</table>
