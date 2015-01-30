<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Toolbar.aspx.cs" Inherits="WebExplorer.Toolbar" ValidateRequest="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <script language="javascript" src="../uploadfile/uploadfile.js"></script>
    <script language="javascript" src="scripts/WebExplorer.js"></script>
    <link href="WebExplorer.css" type="text/css" rel="stylesheet">
</head>
<body style="margin:0 0 0 0">
    <form id="toolbarForm" runat="server">
      <table id="toolTable" cellspacing="0" cellpadding="0" border="0">
        <tr>
          <td><nobr><asp:label id="lblLookIn" visible="false" runat="server"></asp:label></nobr></td>
          <td><asp:dropdownlist id="cmbFilePath" visible="false" width="221px" TabIndex="10" runat="server"></asp:dropdownlist></td>
          <td width="100%"></td>
          <td width="20"><asp:image id="imgUp" width="20px" AccessKey="h" TabIndex="11" runat="server" cssclass="dimmed" imageurl="images\folder_up.png" height="20px"></asp:image>&nbsp;&nbsp;</td>
          <td width="20"><asp:image id="imgDelete" width="20px" AccessKey="r" TabIndex="12" runat="server" cssclass="dimmed" imageurl="images\delete.png" height="20px"></asp:image></td>
          <td width="20"><asp:image id="imgCreate" width="20px" AccessKey="f" TabIndex="13" runat="server" cssclass="dimmed" imageurl="images\folderNew.gif" height="20px"></asp:image>&nbsp;&nbsp;</td>
          <td width="20"><asp:image id="imgChangeView" visible="false" width="20px" AccessKey="a" TabIndex="14" runat="server" cssclass="dimmed" imageurl="images\folder.png" height="20px"></asp:image></td>
          <td width="20"><asp:image id="imgUpload" width="20px" AccessKey="u" TabIndex="15" runat="server" cssclass="dimmed" imageurl="images\import.png" height="20px"></asp:image></td>
          <td width="20"><asp:image id="imgDownload" width="20px" AccessKey="d" TabIndex="16" runat="server" cssclass="dimmed" imageurl="images\export.gif" height="20px"></asp:image>&nbsp;&nbsp;</td>
          <td width="20"><asp:image id="imgCut" width="20px" AccessKey="x" TabIndex="17" runat="server" cssclass="dimmed" imageurl="images\cut.gif" height="20px"></asp:image></td>
          <td width="20"><asp:image id="imgCopy" width="20px" AccessKey="c" TabIndex="18" runat="server" cssclass="dimmed" imageurl="images\copy.gif" height="20px"></asp:image></td>
          <td width="20"><asp:image id="imgPaste" width="20px" AccessKey="v" TabIndex="19" runat="server" cssclass="dimmed" imageurl="images\paste.gif" height="20px"></asp:image></td>
        </tr>
     </table>
    <input id="currentTreeAlias" type="hidden" name="currentTreeAlias" value="" runat="server">
    <input id="currentFileListAlias" type="hidden" name="currentFileListAlias" value="" runat="server">
    </form>
</body>
</html>
