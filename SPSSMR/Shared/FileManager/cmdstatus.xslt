<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="globals.xsl" />
	<xsl:output method="html" indent="yes" encoding="UTF-8" />
	<xsl:key name="getoption" match="option" use="@name" />
	<xsl:template match="/">
		<meta name="vs_showGrid" content="False" />
		<script language="javascript">
			msg_upload_confirm_upload		= "<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='upload_confirm_upload']/value" />";
			msg_upload_confirm_to			= "<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='upload_confirm_to']/value" />";
			msg_please_select_file			= "<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='please_select_file']/value" />";
			msg_filename_absolute_invalid	= "<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='filename_absolute_invalid']/value" />";
		</script>
		<form method="post" name="cmdstatus_form">
			<table width="100%">
				<tr>
					<xsl:if test="key('getoption','download')='true'">
						<td valign="center" width="18" class="imagebuttons" onclick="javascript:doCommand('download')">
							<img src="images/download.gif" height="16" width="16">
								<xsl:attribute name="alt">
									<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='download']/value" />
								</xsl:attribute>
								<xsl:attribute name="title">
									<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='download']/value" />
								</xsl:attribute>
							</img>
						</td>
					</xsl:if>
					<xsl:if test="key('getoption','upload')='true'">
						<td valign="center" width="18" class="imagebuttons" onclick="javascript:doCommand('upload')" >
							<img src="images\upload.gif" height="16" width="16">
								<xsl:attribute name="alt">
									<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='upload']/value" />
								</xsl:attribute>
								<xsl:attribute name="title">
									<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='upload']/value" />
								</xsl:attribute>
							</img>
						</td>
					</xsl:if>
					<td align="left">
						<div style="DISPLAY: none">
							<div id="aliasentryitem" class="dirfile_selection" style="DISPLAY: inline; COLOR: red"></div>
							<div id="direntryitem" class="dirfile_selection" style="DISPLAY: inline; COLOR: green"></div>
						</div>
						<table>
							<tr>
								<td align="left" class="dirfile_selection">
									<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='selectedfile_label']/value" />
								</td>
								<td align="left">
									<input type="text" id="fileentryitem" name="fileentryitem" size="25" class="dirfile_selection"></input>
								</td>
							</tr>
						</table>
					</td>
					<td class="dirfile_selection" style="WIDTH:1%" nowrap="nowrap">
						<xsl:attribute name="title">
							<xsl:value-of select="/application/options/@wildcard" />
						</xsl:attribute>
						<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='filemask_label']/value" />
						<input id="fmask" name="fmask" style="WIDTH: 60px" class="dirfile_selection" onContextMenu="return false;">
							<xsl:attribute name="value">
								<xsl:value-of select="/application/options/@wildcard" />
							</xsl:attribute>
						</input>
					</td>
					<xsl:variable name="modechosen" select="/application/options/@mode" />
					<td align="right" style="WIDTH:1%" nowrap="nowrap">
						<input type="button" id="confirm_button">
							<xsl:attribute name="value">
								<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name=$modechosen]/value" />
							</xsl:attribute>
							<xsl:attribute name="onclick">javascript:doCommand('<xsl:value-of select="$modechosen" />')</xsl:attribute>
						</input>
						<xsl:text></xsl:text>
						<input type="button" id="close_button">
							<xsl:attribute name="value">
								<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='close']/value" />
							</xsl:attribute>
							<xsl:attribute name="onclick">javascript:doClose()</xsl:attribute>
						</input>
					</td>
				</tr>
			</table>
		</form>
	</xsl:template>
</xsl:stylesheet>