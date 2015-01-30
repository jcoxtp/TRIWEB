<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ctrlOkCancel.ascx.cs" Inherits="ProjectEditor.ctrlOkCancel" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>

<table style="WIDTH: 100%" border="0">
	<tr>
		<td style="TEXT-ALIGN: right">
			<div style="OVERFLOW: visible; WHITE-SPACE: nowrap"><input id="btnOK" onclick="javascript:btnOK_ClickedClient()" type="button" class="stdbutton" value=" OK " runat="server" NAME="btnOK">
				&nbsp;<input id="btnCancel" onclick="javascript:btnCancel_ClickedClient()" type="button" class="stdbutton" value="Cancel" runat="server" NAME="btnCancel">
				&nbsp;
			</div>
		</td>
	</tr>
</table>
