<%@ Page language="c#" Codebehind="getPDIReport.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.getPDIReport" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>getPDIReport</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script src="querystring.js"></script>
		<script src="AjaxEtc.js"></script>
		<script language="javascript">
			var qs = new Querystring();
			var rptURL = "http://www.pdiprofile.com/ePDICorp/PDIReport.aspx?TCID=" + qs.get("TCID") + "&lid=" + qs.get("lid") + "&res=" + qs.get("res") + "&u=" + qs.get("u");
			//alert(rptURL);

			function handleAjax(response) {
				window.location = response;
			}
			
			ajaxClientHandler = handleAjax;
			
			sendAjaxRequest(rptURL);
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
