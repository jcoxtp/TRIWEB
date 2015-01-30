<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="globals.xsl" />
	<xsl:output method="html" indent="yes" encoding="UTF-8" />
	
	<!-- Filter remaing XML away -->
	<xsl:template match="/">
		<xsl:apply-templates select="//application/filelist/file[@showinfo='true']" />
	</xsl:template>
	
	<!-- template that renders HTML -->
	<xsl:template match="file">
		<center>
			<table id="maintable">
				<form method="post" name="mfs_fileinfo_form">
					<tr>
						<td>
							<table class="OuterTable" style="WIDTH: 300px; VERTICAL-ALIGN: text-top">
								<tr>
									<td>
										<table class="InnerTable">
											<tr>
												<td class="InnerTableHeading" colspan="2">
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_fileinfo_header_master']/value" />
												</td>
											</tr>
											<tr>
												<td class="InnerTableMainDataDark">
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_fileinfo_last_modified']/value" />
												</td>
												<td class="InnerTableMainDataDark">
													<xsl:value-of select="@masterdate" />
												</td>
											</tr>
											<tr>
												<td class="InnerTableMainDataDark">
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_fileinfo_file_size']/value" />
												</td>
												<td class="InnerTableMainDataDark">
													<xsl:value-of select="@mastersize" />
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<br/>
												</td>
											</tr>
											<tr>
												<td class="InnerTableHeading" colspan="2">
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_fileinfo_header_user']/value" />
												</td>
											</tr>
											<tr>
												<td class="InnerTableMainDataDark">
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_fileinfo_last_modified']/value" />
												</td>
												<td class="InnerTableMainDataDark">
													<xsl:value-of select="@userdate" />
												</td>
											</tr>
											<tr>
												<td class="InnerTableMainDataDark">
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_fileinfo_file_size']/value" />
												</td>
												<td class="InnerTableMainDataDark">
													<xsl:value-of select="@usersize" />
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<!-- OK -->
							<xsl:call-template name="OKButton" />
						</td>
					</tr>
				</form>
			</table>
		</center>
	</xsl:template>
	
</xsl:stylesheet>
