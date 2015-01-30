<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="globals.xsl" />
	<xsl:output method="html" indent="yes" encoding="UTF-8" />
	<xsl:template match="/">
		<center>
			<table id="maintable" style="width: 300px">
				<form method="post" name="pfs_form">
					<tr>
						<td>
							<table class="OuterTable" style="width: 300px">
								<tr>
									<td>
										<table class="InnerTable">
											<xsl:for-each select="application/choices/choice">
												<xsl:if test="@allow='true' and .='true'">
													<tr class="InnerTableMainDataDark">
														<xsl:attribute name="onclick">
															clickItem( '<xsl:value-of select="@name" />');
														</xsl:attribute>
														<td width="1%">
															<input type="radio" name="projectfileoption">
																<xsl:attribute name="id">
																	<xsl:value-of select="@name" />
																</xsl:attribute>
																<xsl:attribute name="value">
																	<xsl:value-of select="@name" />
																</xsl:attribute>
															</input>
														</td>
														<td>
															<xsl:variable name="workspacename" select="@name" />
															<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name=$workspacename]/value" />
															<xsl:variable name="filemodified" select="//application/workspaces/workspace[@name=$workspacename]/@filedate" />
															<xsl:if test="$filemodified!=''">
																<br/>
																<nobr>
																	<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='pfs_gui_filemodified']/value" />
																	<xsl:value-of select="$filemodified" />
																</nobr>
															</xsl:if>
														</td>
													</tr>
												</xsl:if>
											</xsl:for-each>
											<tr class="helptext">
												<td colspan="2">
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='pfs_gui_select_explanation']/value" />
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
							<!-- OK / Cancel -->
							<xsl:call-template name="OKCancelButtons" />
						</td>
					</tr>
				</form>
			</table>
		</center>
	</xsl:template>
</xsl:stylesheet>
