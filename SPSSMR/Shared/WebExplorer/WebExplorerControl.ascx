<%@ Control Language="C#" ClassName="WebExplorerControl" AutoEventWireup="true" CodeBehind="WebExplorerControl.ascx.cs" Inherits="WebExplorer.WebExplorerControl" %>
<%@ Register TagPrefix="ignav" Namespace="Infragistics.WebUI.UltraWebNavigator" Assembly="Infragistics2.WebUI.UltraWebNavigator.v7.2, Version=7.2.20072.61, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title></title>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <script language="javascript" src="Shared/uploadfile/uploadfile.js"></script>
        <script language="javascript" src="Shared/WebExplorer/scripts/WebExplorer.js"></script>
        <link href="Shared/WebExplorer/WebExplorer.css" type="text/css" rel="stylesheet">
    </head>
    <body onload="setFocus();">
        <table height="100%" width="100%">
            <tr width="100%">
            
                <!-- left side -->
                <td width="30%" height="100%">
                    <!-- Treeview -->
                    <iframe id="tree" name="tree" src="Shared/WebExplorer/Tree.aspx" width="100%" height="100%" ></iframe>
                </td>
                <!-- Right side -->
                <td width="70%" height="100%">
                    <table height="100%" width="100%">

                        <!-- Toolbar -->
                        <tr width="100%">
                            <td>
                        <iframe id="toolbar" name="toolbar" src="Shared/WebExplorer/Toolbar.aspx" width="100%" height="25" frameborder="0" scrolling="no" ></iframe>
                        </td>
                        </tr>
                        <!-- File list -->
                        <tr width="100%">
                            <td width="100%">
                           <iframe id="filelist" name="filelist" src="Shared/WebExplorer/Filelist2.aspx" width="100%" height="300" ></iframe></td></tr>

                        <!-- File name and type -->
                        <tr width="100%">
                            <td width="100%">
                                <table id="Table1" cellspacing="1" cellpadding="1" border="0">
                                    <tr>
                                        <td><nobr><asp:label id="lblFileName" runat="server"></asp:label></nobr></td>
                                        <td><asp:textbox id="txtFileName" width="300px" TabIndex="3" runat="server"></asp:textbox></td></tr>
                                    <tr>
                                        <td><nobr><asp:label id="lblFileTypes" runat="server"></asp:label></nobr></td>
                                        <td><asp:dropdownlist id="ddlFilesOfType" name="ddlFilesOfType" width="300px" TabIndex="4" runat="server"></asp:dropdownlist></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                        <tr width="100%" height="100%"><td width="100%" height="100%"></td></tr>

                        <!-- Buttons -->
                        <tr height="75" width="100%">
                            <td valign="bottom" width="100%">
                                <table id="Table2" cellspacing="1" cellpadding="1" width="100%" border="0">
                                    <tr valign="bottom" width="100%">
                                        <td width="100%"></td>
                                        <td align="right"><nobr><asp:button id="btnOK" CommandName="openOrSave" width="75px" Tabindex="5" disabled="true" runat="server"></asp:button>
                                            </nobr></td>
                                        <td align="right"><asp:button id="btnCancel" CommandName="cancel" width="75px" TabIndex="6" runat="server"></asp:button></td>
                                        <td align="right"><asp:button id="btnHelp" CommandName="help" width="75px" TabIndex="7" runat="server" OnClientClick="openHelp();"></asp:button></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <input id="selectedAlias" type="hidden" value="" runat="server">
    </body>
</html>
