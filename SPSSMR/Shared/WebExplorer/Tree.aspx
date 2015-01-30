<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tree.aspx.cs" Inherits="WebExplorer.Tree" %>
<%@ Register TagPrefix="ignav" Namespace="Infragistics.WebUI.UltraWebNavigator" Assembly="Infragistics2.WebUI.UltraWebNavigator.v7.2, Version=7.2.20072.61, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
     <script language="javascript" src="scripts/WebExplorer.js"></script>
     <script language="javascript" type="text/javascript" src="scripts/tree.js"></script>
     <link href="WebExplorer.css" type="text/css" rel="stylesheet">
</head>
<body style="BACKGROUND-COLOR: white; margin: 0 0 0 0">
    <form id="treeForm" runat="server">
        <table width="100%" height="100%">
        <tr><td><ignav:UltraWebTree ID="MyTree" runat="server" Width="100%" Height="100%" BackImageUrl="" BorderColor="White" CssClass="" Cursor="Default" ImageDirectory="images" CollapseImage="" ExpandImage="" DefaultImage="ftv2folderclosed.gif" DefaultSelectedImage="ftv2folderopen.gif" Section508Compliant="true" ExpandOnClick="true" Indentation="20" JavaScriptFilename="" JavaScriptFileNameCommon="" WebTreeTarget="HierarchicalTree" XslFile=""></ignav:UltraWebTree></td></tr></table>
        <input id="userControlId" type="hidden" name="userControlId" runat="server">
    </form>
</body>
</html>
