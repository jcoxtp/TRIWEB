<%@ OutputCache Location="none" %>
<%@ Page language="c#" Codebehind="Action.aspx.cs" Inherits="ManageUsers.Action"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title><%= strTitle %></title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="jsinclude.js"></script>
		<script language="javascript">
			 var StringHelper = new Object();
             StringHelper.Format = function(format)
             {
                if ( arguments.length == 0 )
                {
                    return '';
                }
                if ( arguments.length == 1 )
                {
                    return String(format);
                }

                var strOutput = '';
                for ( var i=0 ; i < format.length-1 ; )
                {
                    if ( format.charAt(i) == '{' && format.charAt(i+1) != '{' )
                    {
                        var index = 0, indexStart = i+1;
                        for ( var j=indexStart ; j <= format.length-2 ; ++j )
                        {
                            var ch = format.charAt(j);
                            if ( ch < '0' || ch > '9' ) break;
                        }
                        if ( j > indexStart )
                        {
                            if ( format.charAt(j) == '}' && format.charAt(j+1) != '}' )
                            {
                                 for ( var k=j-1 ; k >= indexStart ; k-- )
                                 {
                                     index += (format.charCodeAt(k)-48)*Math.pow(10, j-1-k);
                                 }  
                                var swapArg = arguments[index+1];
                                strOutput += swapArg;
                                i += j-indexStart+2;
                                continue;
                            }
                        }
                        strOutput += format.charAt(i);
                        i++;
                    }
                    else
                    {
                        if ( ( format.charAt(i) == '{' && format.charAt(i+1) == '{' )
                            || ( format.charAt(i) == '}' && format.charAt(i+1) == '}' ) )
                        {
                            i++
                        }
                        strOutput += format.charAt(i);
                        i++;
                    }
                }
                strOutput += format.substr(i);
                return strOutput;
             } 
			
			function onResultsOK()
			{
				_refreshOpenerWindows();
				if(window.opener!=null)               
                    window.opener.location.reload();  
				window.close();
			}
			function onCancel()
			{
				window.close();
			}
			
			function checkSelected(name ,currentPanel)
			{
			    var hasSelection=false;
			    var oListbox = document.getElementById('lbItems');
			    for(var i=0; i<oListbox.options.length; i++)
                {
                    if(oListbox.options[i].selected)
                    {
                        hasSelection=true;
                        break;
                    }
                }
                if(!hasSelection)
                {
                    alert(StringHelper.Format(submitErrMsg, name));
                    return false;
                }
                showProgressPanel(currentPanel);
                return true;
			}
			
			function showProgressPanel(currentPanel)
			{
				document.getElementById(currentPanel).style.visibility = 'hidden';
				document.getElementById('lblProgress').style.visibility = 'visible';
				
			}
			function init() 
			{
				document.getElementById('lblProgress').style.visibility='hidden';
			}
			
			
		</script>
		<base target="_top">
	</head>
	<body onload="init();">
		<form id="Action" method="post" runat="server">
			<asp:panel id="ProgressBarPanel" runat="server" style="Z-INDEX: 106; POSITION: absolute">
				<asp:label id="lblProgress" runat="server">here</asp:label>
			</asp:panel>
			<asp:panel id="ListPanel" runat="server">
				<table height="100%" width="100%">
					<tr valign="top">
						<td>
							<table height="100%" width="100%" align="center">
								<tr>
									<td>
										<asp:label id="lblTask" runat="server"></asp:label><br>
										<br>
									</td>
								</tr>
								<tr>
									<td align="center" width="75%"><select id="lbItems" multiple size="8" name="lbItems" runat="server"></select><br>
										<asp:label id="lblHelpText" runat="server"></asp:label>
                                        </td>
								</tr>
							</table>
						</td>
					</tr>
					<tr valign="bottom">
						<td align="right"><br>
							<asp:button id="btnOK" onclick="OnListOK" runat="server" cssclass="stdbutton" text=""></asp:button>&nbsp;
							<input class="stdbutton" id="btnCancel" onclick="onCancel()" type="button" name="btnCancel"
								runat="server">
						</td>
					</tr>
				</table>
			</asp:panel>
			<asp:panel id="NoItemsPanel" runat="server" visible="False">
				<table height="100%" width="100%">
					<tr valign="top">
						<td>
							<asp:label id="lblNoItemsText" runat="server"></asp:label></td>
					</tr>
					<tr valign="bottom">
						<td align="right"><input class="stdbutton" id="btnNoItemsOK" onclick="onCancel()" type="button" name="btnNoItemsOK"
								runat="server"></td>
					</tr>
				</table>
			</asp:panel>
			<asp:panel id="ResultsPanel" runat="server" visible="False">
				<table height="100%" width="100%">
					<tr valign="top">
						<td>
							<asp:label id="lblResults" runat="server"></asp:label><br>
						</td>
					</tr>
					<tr valign="bottom">
						<td align="right"><input class="stdbutton" id="btnResultsOK" onclick="onResultsOK()" type="button" name="btnOK"
								runat="server"></td>
					</tr>
				</table>
			</asp:panel>
			<asp:panel id="ConfirmPanel" runat="server" visible="False">
				<table height="100%" width="100%">
					<tr valign="top">
						<td>
							<asp:label id="lblConfirm" runat="server"></asp:label><br>
						</td>
					</tr>
					<tr valign="bottom">
						<td align="right"><br>
							<asp:button id="btnConfirmOK" onclick="OnConfirmOK" runat="server" cssclass="stdbutton" text=""></asp:button>&nbsp;
							<input class="stdbutton" id="btnConfirmCancel" onclick="onCancel()" type="button" name="btnCancel"
								runat="server">
							<br>
						</td>
					</tr>
				</table>
				<asp:textbox id="tbRoleName" runat="server" visible="False"></asp:textbox>
				<asp:textbox id="tbUserName" runat="server" visible="False"></asp:textbox>
				<asp:textbox id="tbTask" runat="server" visible="False"></asp:textbox>
			</asp:panel>
		</form>
	</body>
</html>
