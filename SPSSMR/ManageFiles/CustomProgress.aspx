<%@ Page language="c#" Codebehind="CustomProgress.aspx.cs" AutoEventWireup="false"   Inherits="ManageFiles.CustomProgress" EnableEventValidation="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>CustomProgress</title>
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<style>
		.progressBarOuter 
		{
			border: #006000 1px solid;
			padding: 0; 
			BORDER-TOP: #006000 1px solid; 
			WIDTH: 100%; 
			HEIGHT: 15px
		}
		
		.progressBarInner 
		{
			HEIGHT: 100%; 
			BACKGROUND-COLOR: #eff7ff
		}
		</style>
		<script type="text/javascript" src="Main.js"></script>
		<script src="Shared/Dialog/dialog.js" type="text/javascript"></script>
		<script type="text/javascript" src="CustomDialog/MessageBox.js"></script>
</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:panel id="panelProgress" runat="server" visible="True">
				<TABLE width="100%" id="TABLE1" language="javascript" onclick="return TABLE1_onclick()">
					<TR>
                        <td runat="server" colspan="2" align="left">
                            <asp:Label ID="lblFileCount" runat="server"></asp:Label><asp:Label ID="lblCurrentFileName" runat="server" Font-Bold="True"></asp:Label></td>
					</TR>
					<TR>
						<TD colspan=2 width=100%>
                            <br />
							<DIV class="progressBarOuter"><SPAN class="progressBarInner" id="progressBar" runat="server"></SPAN></DIV>
						</TD>
					</TR>
					<TR>
						<TD colspan=2>
<asp:label id="lblSize" runat="server"></asp:label></TD>
					</TR>
                    <tr>
                        <td colspan=2>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        
                        <td align="center" colspan="2">
                           <input id="btnCancel" type="button" value="Cancel"  runat="server" onclick="CancelClick();" style="width: 90px"/></td>
                    </tr>
				</TABLE>
			</asp:panel><asp:label id="lblError" runat="server"></asp:label>
            <input id="hCancelState" runat="server" style="width: 84px" type="hidden" value="false" />
            <input id="hBarFileCount" runat="server" style="width: 56px" type="hidden" value="11" />
            <input id="hCancelUploadWarn" runat="server" style="width: 67px" type="hidden" />
            </form>
                        <script type='text/javascript'>
						function CancelClick()
						{				
                            hCancelMsg=document.getElementById('hCancelUploadWarn').value;     					
                   			if ( ShowYesNoQuestion(hCancelMsg) )                 		
                   			{
                   			    document.getElementById('hCancelState').value='true';
                   			    document.Form1.submit(); 
                   			}
						}
                        function TABLE1_onclick() {

                        }
	       </script>  
	</body>
</HTML>
