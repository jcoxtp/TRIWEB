<%@ Page Language="C#" CodeBehind="MailOptions.aspx.cs" Inherits="SPSSMR.Management.Monitoring.Web.MailOptions" AutoEventWireup="true" EnableEventValidation="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>
        <%=title%>
    </title>
    <link href="Shared/spssmrNet.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <base target="_self">
    
    <script type="text/javascript">
     
        function Add()
        {
            
            var labError = document.getElementById("labError");
            if(labError)
            {
               labError.style.display="none";
            }
            
            var url = "EditMail.aspx";

            var args = {opener: window};
	        var txt = window.showModalDialog(url, args, "dialogHeight:100px;dialogWidth:150px;status:no;help:no;resizeable:yes;scroll:no;edge:sunken;unadorned:yes;");
	       
	        if(txt==""||txt==null)
	        {
	            return;
	        }
	        else
	        {

	            var oOption = document.createElement("option");
                
                var oListbox = document.getElementById("mailList");
                oOption.appendChild(document.createTextNode(txt));
                
                oListbox.appendChild(oOption);
                ResetMailAddress();
	        }
            
        }
        
        function Edit()
        {
            var labError = document.getElementById("labError");
            if(labError)
            {
               labError.style.display="none";
            }
            
            
            var oListbox = document.getElementById("mailList");
            if(oListbox.selectedIndex<0)
            {
                return;
            }
            var args = {opener: window};
            var url = "EditMail.aspx?mail="+oListbox.options[oListbox.selectedIndex].text;

	        var txt = window.showModalDialog(url, args, "dialogHeight:100px;dialogWidth:150px;status:no;help:no;resizeable:yes;scroll:no;edge:sunken;unadorned:yes;");
	        if(txt==""||txt==null)
	        {
	            return;
	        }
	        else
	        {
                oListbox.options[oListbox.selectedIndex].text = txt;
                ResetMailAddress();
	        }
            
        }
        
        function Delete()
        {
            var labError = document.getElementById("labError");
            if(labError)
            {
               labError.style.display="none";
            }
            
            var oListbox = document.getElementById("mailList");
            if(oListbox.selectedIndex<0)
            {
                return;
            }
            oListbox.remove(oListbox.selectedIndex);
            ResetMailAddress();
	        
            
        }

        function ResetMailAddress()
        {
             var hid = document.getElementById("hidMailList");
             var mailList = "";
             var oListbox = document.getElementById("mailList");
             
             for(var i=0; i<oListbox.options.length; i++)
             {
                mailList = mailList + oListbox.options[i].text +";";   
             }
             if(mailList!="")
             {
                mailList=mailList.substr(0,mailList.length-1);
             }
             hid.value = mailList;
             
        }
   
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <table width="360px" style="height:400">
            <tr>
                <td style="width: 100%" colspan="2">
                    <asp:Label ID="labLicExceeded" runat="server" Text="Label"></asp:Label></td>
            </tr>
            
            <tr>
                <td style="width: 80%">
                    <asp:ListBox ID="mailList" runat="server" Height="280px" Width="100%"></asp:ListBox>
                </td>
                <td style="width: 20%" align="center" valign="top">
                    <input type="button" id="btnAdd" onclick="Add();" class="stdbutton" value="<%=addText%>" /><br/>
                    
                    <input type="button"  id="btnEdit" class="stdbutton" onclick="Edit();" value="<%=editText%>" /><br/>
                    <asp:Button ID="btnTest" runat="server" CssClass="stdbutton" OnClick="btnTest_Click" /><br/>
                    <input type="button" id="btnDelete" onclick="Delete();" class="stdbutton" value="<%=deleteText%>" />
                   
                    
                </td>
                
            </tr>
            <%--<tr>
                <td style="width: 80%" >
                <br />
                    <asp:TextBox ID="txtAdd" Width="98%" runat="server"></asp:TextBox>
                 </td>
                <td style="width: 20%" align="center" valign="bottom">
                    </td>
                
            </tr>--%>
            <tr>
                <td style="width: 100%" colspan="2" align=right>
                    <asp:Label ID="labError" runat="server" ForeColor="Red" Text="Label"></asp:Label>
                    <br />
                    <input id="hidMailList" type="hidden" runat="server" />
                    <asp:Button ID="btnOK" runat="server" OnClick="btnOK_Click" CssClass="stdbutton" />
                    <asp:Button ID="btnCancel" runat="server" OnClientClick="window.close();return false;" CssClass="stdbutton" /></td>
                
            </tr>
            
        </table>
    
    </div>
    </form>
</body>
</html>
