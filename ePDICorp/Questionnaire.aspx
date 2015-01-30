<%@ Register TagPrefix="uc1" TagName="CorpBanner" Src="CorpBanner.ascx" %>
<%@ Page language="c#" Codebehind="Questionnaire.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.Questionnaire" EnableEventValidation="false" %>
<%@ Register TagPrefix="disc" Assembly="DISC" NameSpace="DISC.Web.Controls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Questionnaire</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script src="findDOM.js"></script>
		<script src="CtrlBehavior.js"></script>
<script type="text/javascript" src="scripts/jquery-1.4.2.js"></script>
<script type="text/javascript" src="scripts/jquery.corners.js"></script>
		<LINK href="rs/<%= CorporateFolder %>/styles.css" type=text/css rel=stylesheet >
		<style type="text/css">
			.disc-row-header { PADDING-RIGHT: 5px; PADDING-LEFT: 5px; FONT-WEIGHT: bold; FONT-SIZE: 10pt; MARGIN-LEFT: 2px; COLOR: #435b69; MARGIN-RIGHT: 2px; BORDER-BOTTOM: #435b69 1px solid; FONT-FAMILY: verdana; BACKGROUND-COLOR: white; TEXT-ALIGN: center }
		</style>
		<script language="javascript">
			
			function autoMoveNext()
			{
				
				if(clickaction == "wait")
					return;
				
				var count = 0;
				
				for(i = 0; i < document.Form1.elements.length; i++)
				{	
					if(document.Form1.elements[i].type=="radio")
					{
											
						if(document.Form1.elements[i].checked)
						{
							count++;
						}
					}
				}
				
				
				if(count == 2)
				{
					//alert("Move to next page");
					doPostBack("btnAutoNext","");
				}
			}
			
			function doPostBack(eventTarget, eventArgument) {
				
				var theform;
				if (window.navigator.appName.toLowerCase().indexOf("microsoft") > -1) {
					theform = document.Form1;
				}
				else {
					theform = document.forms["Form1"];
				}
				theform.__EVENTTARGET.value = eventTarget.split("$").join(":");
				theform.__EVENTARGUMENT.value = eventArgument;
				
				//var msg = theform.__EVENTTARGET.value + " ... " + theform.__EVENTARGUMENT.value;
				//alert(msg);
				
				theform.submit();
			}
		</script>
	</HEAD>
	<body>
   	   <div id="page">
		<form id="Form1" method="post" runat="server">
			<input type="hidden" name="__EVENTTARGET"> <input type="hidden" name="__EVENTARGUMENT">
			<%= getHTML("header.inc") %>
			<div id="main-content">
			<TABLE align="center" id="tblLayout" cellSpacing="0" cellPadding="5" border="0">
				<TR>
					<td vAlign="top" align="left" rowSpan="3" class="left-column"><br>
						<br>
						<BR>
						<BR>
						Please choose one word that describes you <STRONG>MOST</STRONG>, and one word 
						that describes you <STRONG>LEAST</STRONG>.<BR>
						<BR>
						Remember to picture yourself in your work setting and go with your first 
						instinct.<BR>
						<BR>
						The word sets will advance when you have made both a <STRONG>MOST</STRONG> and <STRONG>
							LEAST</STRONG> selection. Use the left and right arrow buttons (when they're 
						visible)&nbsp;to review and advance through your answers.
						<BR>
						<BR>
						After you completed the last word set, you will not be able to make changes to 
						your answers</td>
					<TD class="style1" align="center"><%= getHTML("pagetitle.inc") %>&nbsp;DISC Assessment</TD>
					<td vAlign="top" align="center" rowSpan="3" class="right-column"><br>
						<br>
						<div class="style1-body" align="right">
						</div>
					</td>
				</TR>
				<TR>
					<TD class="section-divline" align="center">
						<TABLE id="Table7" style="HEIGHT: 22px" width="100%" border="0">
							<TR>
								<TD width="50%"></TD>
								<TD align="right" width="50%">
									<asp:linkbutton id=btnSelectContinue runat="server" Text='<%# getLocalString("next", true) %>' CssClass="q_Text-link" >
									</asp:linkbutton></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<tr>
					<td align="center" vAlign="top" class="center-column">
						<table id="tblWordSetControl">
							<TR>
								<TD style="HEIGHT: 7px" vAlign="bottom" align="right" width="82" height="7"></TD>
								<TD style="HEIGHT: 7px" align="center" height="7">
									<asp:Label id="lblProgress" runat="server"></asp:Label></TD>
								<TD style="HEIGHT: 7px" vAlign="bottom" width="82" height="7"></TD>
							</TR>
							<tr>
								<TD width="82" height="152" vAlign="bottom" align="right"><asp:imagebutton id="ibtnPrev" runat="server" ImageUrl="images/left_dark.gif" Height="125px" Width="67px"></asp:imagebutton></TD>
								<td height="152">
									<DIV id="mostleastinput" onclick="autoMoveNext()"><disc:mostleastradiobuttongroup id="mlrbTesting" runat="server" InputAppearance="RADIOBUTTON" Width="400px" Height="144px"
											KeyWordPosition="Left" KeyWordItemStyle="font-family:verdana; color: #435B69; font-size:10pt; background-color:#BECDD5; font-weight:bold; text-align:right; padding-right: 5px"
											KeyWordHeaderStyle="background-color:white" RowHeaderCssClass="disc-row-header" TableBorder="0"></disc:mostleastradiobuttongroup></DIV>
								</td>
								<TD width="82" height="152" vAlign="bottom"><asp:imagebutton id="ibtnNext" runat="server" ImageUrl="images/right_dark.gif" Height="125px" Width="67px"></asp:imagebutton></TD>
							</tr>
							<TR>
								<TD></TD>
								<TD align="center" width="401">
									<asp:Label id=lblFinished runat="server" Text='<%# getLocalString("finished") %>'>
									</asp:Label></TD>
								<TD></TD>
							</TR>
							<tr>
								<TD></TD>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:textbox id="txtCurrentGroupNumber" runat="server" Width="40px" Visible="False"></asp:textbox></td>
								<TD></TD>
							</tr>
							<TR>
								<TD></TD>
								<TD><asp:button id="btnAutoNext" runat="server" Visible="False"></asp:button></TD>
								<TD></TD>
							</TR>
						</table>
					</td>
				</tr>
				<tr class="bottom-row">
					<td class="left-column"></td>
					<td class="center-column">
						<TABLE id="Table4" style="HEIGHT: 22px" border="0">
							<TR>
								<TD></TD>
								<TD align="right">
									<asp:linkbutton id=Linkbutton1 runat="server" Text='<%# getLocalString("next", true) %>' CssClass="q_Text-link">
									</asp:linkbutton></TD>
							</TR>
						</TABLE>
					</td>
					<td class="right-column"></td>
				</tr>
			</TABLE>
			</div>
		<%= getHTML("footer.inc") %>
		</form>
	   </div>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	</body>
</HTML>
