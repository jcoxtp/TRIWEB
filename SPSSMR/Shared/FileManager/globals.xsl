<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:variable name="lang">
		<xsl:value-of select="application/@lang" />
	</xsl:variable>
	<xsl:output method="html" indent="yes" encoding="UTF-8" />
	
	<!-- -->
	
	<xsl:template name="OKCancelButtons">
		<table style="width: 100%" border="0">
			<tr>
				<td style="text-align: right">
					<div style="overflow: visible; white-space: nowrap">
						<input type="button" id="btn_ok" onclick="javascript:doOK()">
							<xsl:attribute name="value">
								<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='ok']/value" />
							</xsl:attribute>
						</input>
						<xsl:text>&#x20;</xsl:text>
						<input type="button" id="btn_cancel" onclick="javascript:doCancel()">
							<xsl:attribute name="value">
								<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='cancel']/value" />
							</xsl:attribute>
						</input>
						<xsl:text>&#x20;</xsl:text>
					</div>
				</td>
			</tr>
		</table>
	</xsl:template>

	<!-- -->
	
	<xsl:template name="OKButton">
		<table style="width:100%">
			<tr>
				<td style="text-align: center">
					<input type="button" onclick="javascript:doOK()">
						<xsl:attribute name="value">
							<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='ok']/value" />
						</xsl:attribute>
					</input>
				</td>
			</tr>
		</table>
	</xsl:template>
	
</xsl:stylesheet>
