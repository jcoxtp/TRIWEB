<%@ Page language="c#" Codebehind="getAppModuleReport.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.getAppModuleReport" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>getAppModuleReport</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script src="querystring.js"></script>
		<script src="AjaxEtc.js"></script>
		<script language="javascript">
			var qs = new Querystring();
			var rptURL = "http://www.pdiprofile.com/ePDICorp/AppModuleReport.aspx?FE=" + qs.get("FE") + "&PDFFN=" + qs.get("PDFFN") + "&SASP=" + qs.get("SASP") + "&TCID=" + qs.get("TCID") + "&PDITSID=" + qs.get("PDITSID") + "&TD=" + qs.get("TD") + "&HT1=" + qs.get("HT1") + "&HT2=" + qs.get("HT2") + "&UID=" + qs.get("UID") + "&lid=" + qs.get("lid");
			//document.write(rptURL);
			function handleAjax(response) {
				window.location = response;
			}
			
			ajaxClientHandler = handleAjax;
			
			var result = sendAjaxRequest(rptURL);
			if(!result)
				alert("An error occurred during the generation of your report. Please contact support.");
		</script>
		<style type="text/css">
			body { font-family: verdana, helvetic, arial, sans serif; }
		</style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
		<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD></TD>
					<TD align="center">&nbsp;</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD align="center">We are still generating your report. If you are not redirected 
						to your report in a few moments, please <a href="http://www.pdiprofile.com/PDI/ContactUs.asp?res=1&lid=1">
							contact us</a> and we'll ensure that you receive it.</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
