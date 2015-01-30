<%@ OutputCache Location="none" %>
<%@ Page language="c#" Codebehind="ManagePropertyGroups.aspx.cs" AutoEventWireup="true" Inherits="ManageUserProperties.ManagePropertyGroups" %>
<%@ Reference Control="TableFrame.ascx" %>
<%@ Reference Control="PropertyGroupListControl.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
    <HEAD>
        <title>
            <%=GetResourceString("IDS_MUP_TOPBOX_TITLE")%>
        </title>
        <base target="_self">
        <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
        <meta name="CODE_LANGUAGE" Content="C#">
        <meta name="vs_defaultClientScript" content="JavaScript">
        <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
        <!-- SPSS Launcher applications stylesheet -->
        <link href="../spssmrNet.css" type="text/css" rel="stylesheet">
        <script language='javascript' src="../Dialog/dialog.js"></script>
    </HEAD>
    <body MS_POSITIONING="GridLayout">
        <form id="Main" method="post" runat="server">
            <br>
            <div align="left">
                <asp:PlaceHolder id="ManageUserPropertiesTopBoxHolder" runat="server"></asp:PlaceHolder>
            </div>
            <br>
            <div align="left">
                <asp:PlaceHolder id="ManageUserPropertiesBottonBoxHolder" runat="server"></asp:PlaceHolder>
            </div>
        </form>
    </body>
</HTML>
