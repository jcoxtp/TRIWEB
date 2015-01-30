<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="globals.xsl" />
	<xsl:output method="html" indent="yes" encoding="UTF-8" />
	<xsl:template match="/">
		<script language='javascript'>
			strConfirmLooseChanges = '<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='pfs_gui_confirm_loose_changes']/value" />';
		</script>
		<center>
			<table id="maintable" style="width: 300px">
				<form method="post" name="pfs_form">
					<tr>
						<td>
							<table class="OuterTable" style="width: 300px">
								<tr>
									<td>
										<table class="InnerTable">
											<tr class="InnerTableHeading">
												<td colspan="2">
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='pfs_checkin_gui_apply_changes_header']/value" />
												</td>
											</tr>
											<tr class="InnerTableMainDataDark">
												<xsl:attribute name="onclick">
													clickItem( 'rmasterworkspace');
												</xsl:attribute>
												<td width="1%">
													<input id="rmasterworkspace" type="radio" name="applyoption" value="masterworkspace" onclick="applyoptionChanged()" onfocus="applyoptionChanged()" checked="checked" />
												</td>
												<td>
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='pfs_checkin_gui_apply_to_shared']/value" />
												</td>
											</tr>
											<tr class="InnerTableMainDataDark">
												<xsl:attribute name="onclick">
													clickItem( 'ruserworkspace');
												</xsl:attribute>
												<td width="1%">
													<input id="ruserworkspace" type="radio" name="applyoption" value="userworkspace" onclick="applyoptionChanged()" onfocus="applyoptionChanged()" />
												</td>
												<td>
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='pfs_checkin_gui_dont_apply_to_shared']/value" />
												</td>
											</tr>
											<tr class="InnerTableHeading">
												<td colspan="2"><br />
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='pfs_checkin_gui_keep_file_header']/value" />
												</td>
											</tr>
											<tr class="InnerTableMainDataDark">
												<xsl:attribute name="onclick">
													clickItem( 'ckeepfile');
												</xsl:attribute>
												<td width="1%">
													<input id="ckeepfile" type="checkbox" name="keepfile" />
												</td>
												<td>
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='pfs_checkin_gui_keep_my_changes']/value" />
												</td>
											</tr>
											<tr class="helptext">
												<td colspan="2">
													<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='pfs_checkin_gui_keep_my_changes_explain']/value" />
												</td>
											</tr>
											<xsl:if test="/application/options/option[@name='unlockproject']/@show='true'">
												<tr class="InnerTableHeading">
													<td colspan="2"><br />
														<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='checkin_gui_projectlock_header']/value" />
													</td>
												</tr>
												<tr class="InnerTableMainDataDark">
													<xsl:attribute name="onclick">
														clickItem( 'ckeepprojectlock');
													</xsl:attribute>
													<td width="1%">
														<input id="ckeepprojectlock" type="checkbox" name="keepprojectlock">
															<xsl:if test="/application/options/option[@name='unlockproject']/@selected='true'">
																<xsl:attribute name="checked">
																	<xsl:text>checked</xsl:text>
																</xsl:attribute>
															</xsl:if>
														</input>
													</td>
													<td>
														<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='checkin_gui_projectlock']/value" />
													</td>
												</tr>
											</xsl:if>
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
