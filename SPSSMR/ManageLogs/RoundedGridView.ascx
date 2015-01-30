<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RoundedGridView.ascx.cs" Inherits="SPSS.Dimensions.Web.UI.CommonControls.RoundedGridView" %>
<table class="RoundedTable" cellpadding="0" cellspacing="0">
    <tr>
        <td rowspan="2"><img style="height:30px;width:10px" alt="" src="../shared/images/RoundedTableControl/dark_topleft.gif" /></td>
        <td class="RoundedTableOuterBorder" style="height:1px"></td>
        <td rowspan="2"><img style="height:30px;width:10px" alt="" src="../shared/images/RoundedTableControl/dark_topright.gif" /></td>
    </tr>
    <tr style="height:29px">
        <td style="width:100%; vertical-align:middle;" class="RoundedTableDarkHeader">
            <asp:PlaceHolder ID="phMainHeader" runat="server"></asp:PlaceHolder>
        </td>
    </tr>
</table>
<div id="myDiv" style="vertical-align top; OVERFLOW: auto;WIDTH: 100%; background-color:White" runat="server">
 
       
             
<table class="RoundedTable" cellpadding="0" cellspacing="0">
    <tr>
        <td class="RoundedTableOuterBorder" style="width:1px"></td>
        <td class="RoundedTableLightInfo" style="width:auto" >
        <asp:GridView ID="gvContent" runat="server" Width="100%" BorderWidth="0">
                <HeaderStyle CssClass="DG_VIEW_HEADER" />
                <RowStyle CssClass="RoundedTableDarkInfo" />
                <AlternatingRowStyle CssClass="RoundedTableLightInfo" />
        </asp:GridView> <asp:PlaceHolder ID="phMainBody" runat="server"></asp:PlaceHolder>     
        </td>
        <td class="RoundedTableOuterBorder" style="width:1px"></td>
    </tr>
</table>
</div> 
<table class="RoundedTable" cellpadding="0" cellspacing="0">
    <tr>
        <td class="RoundedTableDarkInfo" rowspan="2"><img style="height:10px;width:10px" alt="" src="../shared/images/RoundedTableControl/light_bottomleft.gif" /></td>
        <td class="RoundedTableDarkInfo" style="height:9px;width:100%"></td>
        <td class="RoundedTableDarkInfo" rowspan="2"><img style="height:10px;width:10px" alt="" src="../shared/images/RoundedTableControl/light_bottomright.gif" /></td>
    </tr>
    <tr>
        <td class="RoundedTableOuterBorder" style="height:1px;">
        <asp:PlaceHolder ID="phMainFooter" runat="server"></asp:PlaceHolder>
        </td>
    </tr>
</table>



