<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DateSelecter.ascx.cs" Inherits="SPSS.ManageLogs.View.DateSeleter" %>
<%@ Register Src="DateTimeControl.ascx" TagName="DateTimeControl" TagPrefix="uc1" %>


<table cellpadding="0" width="100%" cellspacing="0" >
<TR>
				<TD style="width: 228px" valign="top">
                  <asp:Literal ID="litTimeFrame" runat="server"></asp:Literal>
                </TD>	
                <TD colspan="2" align="left" style="width: 500px;height:30px;">
                    
                    &nbsp;<asp:DropDownList ID="rad" runat="server" Width="190px">
                    
                    </asp:DropDownList>
                </TD>
				<td></td>				
			</TR>
			
			
			<tr><td colspan="4">
			<asp:Panel id="normal" runat="server" Width="100%"  style="Z-INDEX: 30; POSITION: absolute">
			<table cellpadding="0" cellspacing="0" >
			
			<TR>
			    <TD  style="width: 225px">
                   <asp:Literal ID="litFilter" runat="server" ></asp:Literal>
                </TD>
                <TD style="width: 78px;height:30px;" align="left" valign="middle">
                    &nbsp;&nbsp;<asp:Literal ID="litStart" runat="server" ></asp:Literal>
                </td>
                <TD style="width: 300px" >
                    <uc1:DateTimeControl id="datePickerStartDate" runat="server">
                    </uc1:DateTimeControl></TD>	
                <td></td>					
		    </TR> 
		    <tr>
		        <td ></td>
		        <TD style="width: 78px; " align="left" valign="middle">
                   &nbsp;&nbsp;<asp:Literal ID="litEnd" runat="server" ></asp:Literal>
                </td>
                <TD style="width: 300px; height:30px;" >
                    <uc1:DateTimeControl id="datePickerEndDate" runat="server">
                    </uc1:DateTimeControl></TD>
			    <td></td>		
		    </tr>
		</table>
		</asp:Panel>
         </td></tr>  
</table>