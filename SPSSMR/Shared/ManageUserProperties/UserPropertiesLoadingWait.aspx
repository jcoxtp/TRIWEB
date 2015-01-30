<%@ OutputCache Location="none" %>
<%@ Page language="c#" Codebehind="UserPropertiesLoadingWait.aspx.cs" AutoEventWireup="true" Inherits="ManageUserProperties.UserPropertiesLoadingWait" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
    <HEAD>
        <title>loading_wait</title>
        <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
        <meta name="CODE_LANGUAGE" Content="C#">
        <meta name="vs_defaultClientScript" content="JavaScript">
        <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
        <link href="../spssmrNet.css" type="text/css" rel="stylesheet">
    </HEAD>
    <body MS_POSITIONING="GridLayout" onload="window.location.replace('ManagePropertyGroups.aspx?hash=<%=Request["hash"]%>')">
        <form id="UserPropertiesLoadingWait" method="post" runat="server">
            <asp:Literal Runat="server" ID="lblWaitText"></asp:Literal>
        </form>
    </body>
</HTML>
