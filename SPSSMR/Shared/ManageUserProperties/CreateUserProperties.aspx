<%@ OutputCache Location="none" %>
<%@ Reference Control="UserPropertiesDefinitionControl.ascx" %>
<%@ Reference Control="TableFrame.ascx" %>
<%@ Page language="c#" Codebehind="CreateUserProperties.aspx.cs" AutoEventWireup="true" Inherits="ManageUserProperties.CreateUserProperties" EnableEventValidation="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
    <HEAD>
        <title>
            <%=GetResourceString("IDS_EUP_TOPBOX_TITLE")%>
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
            <br>
            <div align="left"><asp:placeholder id="CreateUserPropertiesTopBoxHolder" runat="server"></asp:placeholder></div>
            <br>
            <div align="left"><asp:placeholder id="CreateUserPropertiesBottonBoxHolder" runat="server"></asp:placeholder></div>
            <br>
            <div align="left">
                <asp:button id="CreateBtn" CommandName="Create" Width="70px" Runat="server" />
                <asp:button id="CloseBtn" CausesValidation="False" CommandName="Close" Width="70px" Runat="server" />
            </div>
        </form>
    </body>
</HTML>
