<%@ Page language="c#" Codebehind="finished.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.finished" %>
<%@ Register TagPrefix="uc1" TagName="CorpBanner" Src="CorpBanner.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>DISC Assessment Complete</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script src="findDOM.js"></script>
		<script src="CtrlBehavior.js"></script>
		<script src="AjaxEtc.js"></script>
<script type="text/javascript" src="scripts/jquery-1.4.2.js"></script>
<script type="text/javascript" src="scripts/jquery.corners.js"></script>
		<script language="javascript">
			var keepRunning = true;
			var t;
			var completedMsg = "Your PDI Report(s) will be emailed to you within 1 business day.";
			
			function processReportComplete( responseText )
			{
				keepRunning = false;
				var msgWait = findDOM("msgWait", 0); // 1);
				//msgWait.display = "none";
				
				msgWait.innerHTML = completedMsg;
				
				// var rptLink = findDOM("reportLink");
				// rptLink.href = responseText;
				// rptLink.innerHTML = "Click Here to Retrieve Your Report";
				
			}
			
			ajaxClientHandler = processReportComplete;
			
			function waitForReport()
			{
				if(!keepRunning)
				{
					clearTimeout(t);
					return;
				}
				var msgWait = findDOM("msgWait", 0)
				msgWait.innerHTML += ".";
				
				t = window.setTimeout("waitForReport()", 1000);
			}
			
			
		</script>
		<LINK href="rs/<%= CorporateFolder %>/styles.css" type=text/css rel=stylesheet >
	</HEAD>
	<body>
	   <div id="page">
		<form id="Form1" method="post" runat="server">
			<%= getHTML("header.inc") %>
			<div id="main-content">
			<TABLE align="center" id="tblLayout" cellSpacing="0" cellPadding="0" border="0">
				<TR>
					<TD class="left-column"></TD>
					<TD class="center-column"><%= getHTML("finished.inc") %></TD>
					<TD class="right-column"></TD>
				</TR>
				<TR>
					<TD class="left-column"></TD>
					<TD align="center" class="center-column"><a id="reportLink" href="#"></a><span id="msgWait">Your 
							report is being generated.</span></TD>
					<TD class="right-column"></TD>
				</TR>
				<TR class="bottom-row">
					<TD class="left-column"></TD>
					<TD align="center" class="center-column"><input id="reportURL" type="hidden" runat="server"></TD>
					<TD class="right-column"></TD>
				</TR>
			</TABLE>
			</div>
		<%= getHTML("footer.inc") %>
		</form>
	   </div>
		<script language="javascript">
			waitForReport();
		</script>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	</body>
</HTML>
