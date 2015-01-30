<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:include href="globals.xsl" />
	<xsl:template match="/">
		<xsl:variable name="modechosen" select="/application/options/@mode" />
		<head>
			<meta http-equiv="pragma" content="no-cache" />
			<meta http-equiv="content-type" content="text/html; charset=utf-8" />
			<title>
				<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name=$modechosen]/value" />
			</title>
		</head>
		<frameset rows="0,40,*" frameborder="0" border="0" framespacing="0">
			<frame name="frmFilemgrAction" id="frmFilemgrAction" src="action.asp" frameborder="0" marginwidth="0" noresize="1" />
			<frame name="frmFilemgrCmdStatus" id="frmFilemgrCmdStatus" src="CmdStatus.asp" frameborder="1" scrolling="no" marginwidth="0" noresize="1" />
			<frame name="frmFilemgrOpenDownload" id="frmFilemgrOpenDownload" src="OpenDownload.asp" frameborder="0" marginwidth="0" />
		</frameset>
	</xsl:template>
</xsl:stylesheet>
