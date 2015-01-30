<%@ OutputCache Location="none" %>
<%@ Reference Control="TableFrame.ascx" %>
<%@ Reference Control="AssignUserPropertiesControl.ascx" %>
<%@ Page language="c#" Codebehind="AssignUserProperties.aspx.cs" AutoEventWireup="true" Inherits="ManageUserProperties.AssignUserProperties" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
    <HEAD>
        <title>
            <%=GetResourceString("IDS_AUP_DIALOG_TITLE")%>
        </title>
        <base target="_self">
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
        <meta content="C#" name="CODE_LANGUAGE">
        <meta content="JavaScript" name="vs_defaultClientScript">
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <LINK href="../spssmrNet.css" type="text/css" rel="stylesheet">
    </HEAD>
    <body MS_POSITIONING="GridLayout">
        <form id="Form1" method="post" runat="server">
            <asp:Label Runat="server" ID="IntroductionLbl" Font-Bold="True"></asp:Label><br>
            <asp:Label Runat="server" ID="InstructionLbl"></asp:Label>
            <p></p>
            <div align="left"><asp:placeholder id="AssignUserPropertiesDialogHolder" runat="server"></asp:placeholder>
                <p></p>
            </div>
            <div align="left">
                <asp:button id="OKBtn" Width="60px" Runat="server"></asp:button>
                &nbsp;
                <asp:button id="CancelBtn" Width="60px" Runat="server"></asp:button>
            </div>
        </form>
    </body>
</HTML>
