<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="globals.xsl" />
	<xsl:output method="html" indent="yes" encoding="UTF-8" />
	<xsl:template match="/">
		<div id="popupUploadDIV" style="position: absolute; top: 100px; left 3px; z-index: 99; visibility: hidden">
			<table class="PopupMessageTable">
				<tr>
					<td style="padding: 10px">
						<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='upload_in_progress']/value" />
					</td>
				</tr>
			</table>
		</div>
		<form method="post" name="filelist_form">
			<input type="hidden" name="aliasentryitem">
				<xsl:attribute name="value">
					<xsl:value-of select="/application/files/@alias" />
				</xsl:attribute>
			</input>
			<input type="hidden" name="reldirentryitem">
				<xsl:attribute name="value">
					<xsl:value-of select="/application/files/@path" />
				</xsl:attribute>
			</input>
			<table border="0" width="100%">
				<tr class="filelistheader">
					<th align="left">
						<input type="button" class="headerbutton">
							<xsl:attribute name="value">
								<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='name']/value" />
							</xsl:attribute>
						</input>
					</th>
					<th align="left">
						<input type="button" class="headerbutton">
							<xsl:attribute name="value">
								<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='type']/value" />
							</xsl:attribute>
						</input>
					</th>
					<th align="left">
						<input type="button" class="headerbutton">
							<xsl:attribute name="value">
								<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='date']/value" />
							</xsl:attribute>
						</input>
					</th>
				</tr>
				<xsl:for-each select="application/files/file">
					<xsl:sort select="@name" />
					<tr class="filelistitem">
						<xsl:attribute name="ondblclick">javascript:rowchosen('<xsl:number />', '<xsl:value-of select="@name" />')</xsl:attribute>
						<xsl:attribute name="onclick">javascript:selectrow('<xsl:number />', '<xsl:value-of select="@name" />')</xsl:attribute>
						<xsl:attribute name="id">tr<xsl:number /></xsl:attribute>
						<td align="left">
							<xsl:attribute name="id">cola<xsl:number /></xsl:attribute>
							<xsl:value-of select="@name" />
						</td>
						<td align="left">
							<xsl:value-of select="@type" />
						</td>
						<td align="left">
							<xsl:value-of select="@date" />
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</form>
		<script language="javascript">selectrow('-1', '')</script>
	</xsl:template>
</xsl:stylesheet>
