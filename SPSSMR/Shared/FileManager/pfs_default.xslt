<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="globals.xsl" />
	<xsl:output method="html" indent="yes" encoding="UTF-8" />
	<xsl:template match="/">
		<xsl:variable name="modechosen" select="/application/options/@mode" />
		<head>
			<meta http-equiv="pragma" content="no-cache" />
			<meta http-equiv="content-type" content="text/html; charset=utf-8" />
			<title>
				<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='pfs_dialog_title']/value" />
			</title>
		</head>
		<frameset rows="0,*" frameborder="0" border="0" framespacing="0">
			<noframes>
				<body>
					<p>This page uses frames, but your browser doesn't support them.</p>
				</body>
			</noframes>
			<frame name="frmPFSAction" id="frmPFSAction" src="pfs_action.asp" frameborder="0" marginwidth="0" noresize="0" />
			<frame name="frmPFS_gui" id="frmPFS_gui" src="pfs_gui.asp" frameborder="1" scrolling="no" marginwidth="0" noresize="1" />
		</frameset>
	</xsl:template>
</xsl:stylesheet>
