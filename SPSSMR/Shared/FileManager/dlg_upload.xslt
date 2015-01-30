<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:include href="globals.xsl" />
	<xsl:output method="html" indent="yes" encoding="UTF-8" />
	<xsl:template match="/">
		<form name="action_form" method="post" enctype="multipart/form-data" style="margin: 0px">
			<table class="OuterTable" style="width: 500px" cellspacing="0">
				<tr>
					<td class="OuterTableHeading">
						<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='upload_file_heading']/value" />
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" cellspacing="2">
							<tr>
								<td class="InnerTableExplanatory">
									<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='upload_file_explain']/value" />
								</td>
							</tr>
							<tr>
								<td class="InnerTableHeading">
									<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='upload_file_local_file']/value" />
								</td>
							</tr>
							<tr>
								<td class="InnerTableMainDataDark">
									<input type="FILE" size="1" name="File1" id="File1" class="InnerTableMainDataCtrl" style="width: 100%" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- OK / Cancel -->
			<xsl:call-template name="OKCancelButtons" />
		</form>
	</xsl:template>
</xsl:stylesheet>
