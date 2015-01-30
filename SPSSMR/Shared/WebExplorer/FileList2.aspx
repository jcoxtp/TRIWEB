<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileList2.aspx.cs" Inherits="WebExplorer.FileList2" ValidateRequest="false" %>
<%@ Register TagPrefix="ignav" Namespace="Infragistics.WebUI.UltraWebGrid" Assembly="Infragistics2.WebUI.UltraWebGrid.v7.2, Version=7.2.20072.61, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
   
    <script language="javascript" src="../uploadfile/uploadfile.js"></script>
    <script language="javascript" src="scripts/FileList.js"></script>
    <script language="javascript" src="scripts/WebExplorer.js"></script>
    <link href="WebExplorer.css" type="text/css" rel="stylesheet">
</head>
<body style="BACKGROUND-COLOR: white" leftmargin="0" topmargin="0">
    <script language=vbscript type="text/vbscript">
        Function ShowYesNoQuestion(Prompt, Title)
	        If MsgBox(Prompt, vbYesNo+vbQuestion, Title) = vbYes Then
		        ShowYesNoQuestion = True
	        Else
		        ShowYesNoQuestion = False
	        End If
        End Function
    </script>
     <form id="fileList2Form" runat="server">
    <table width="100%" height="100%">
        <tr><td style="width: 933px"><ignav:UltraWebGrid ID="MyGrid" runat="server" Width="100%" Height="100%"></ignav:UltraWebGrid></td></tr></table>
        
            <input id="currentName" type="hidden" name="currentName" runat="server">
            <input id="currentAlias" type="hidden" name="currentAlias" runat="server">
            <input id="currentIsDirectory" type="hidden" name="currentIsDirectory" runat="server">
            <input id="currentIdentifier" type="hidden" name="currentIdentifier" runat="server">
            <input id="subFolder" type="hidden" name="subFolder" runat="server">
            <input id="gridName" type="hidden" name="gridName" runat="server">
            <input id="newName" type="hidden" name="newName" runat="server">
            <input id="newAlias" type="hidden" name="newAlias" runat="server">
            <input id="filePattern" type="hidden" name="filePattern" value="<" runat="server">
            <input id="isUpdating" type="hidden" name="isUpdating" value="false" runat="server">
            <input id="userControlId" type="hidden" name="userControlId" runat="server">&nbsp;
            <asp:Button id="deleteBtn" runat="server" CommandName="delete" CssClass="hideable"></asp:Button>&nbsp;
            <asp:Button id="createBtn" runat="server" CommandName="create" CssClass="hideable"></asp:Button>
            <asp:Button id="changeViewBtn" CommandName="changeView" CssClass="hideable" runat="server"></asp:Button>
            <asp:Button id="uploadBtn" CommandName="upload" CssClass="hideable" runat="server"></asp:Button>
            <asp:Button id="downloadBtn" CommandName="download" CssClass="hideable" runat="server"></asp:Button>
            <asp:Button id="renameBtn" CommandName="rename" CssClass="hideable" runat="server"></asp:Button>
            <asp:Button id="copyBtn" CommandName="copy" CssClass="hideable" runat="server"></asp:Button>
            <asp:Button id="pasteBtn" CommandName="paste" CssClass="hideable" runat="server"></asp:Button>
            <asp:Button id="cutBtn" CommandName="cut" CssClass="hideable" runat="server"></asp:Button>
            <asp:Button id="displayFilesBtn" CommandName="displayFiles" CssClass="hideable" runat="server"></asp:Button>&nbsp;
            <input id="confirmDeleteMsg" type="hidden" name="confirmDeleteMsg" runat="server">
            <input id="invalidFileNameMsg" type="hidden" name="invalidFileNameMsg" runat="server">
            <input id="invalidFirstCharMsg" type="hidden" name="invalidFirstCharMsg" runat="server">     
            <input id="hOverwrite" type="hidden" name="HOverwriteFolderOrFile" runat="server" value="false">&nbsp;
        <input id="hConfirmedOverwrite" type="hidden" name="hConfirmedOverwrite" runat="server" value="false">
    </form>
</body>
</html>
