<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="globals.xsl" />
	<xsl:output method="html" indent="yes" encoding="UTF-8" />
	<xsl:template match="/">
		<form id="errorMessageForm" style="DISPLAY: none" name="errorMessageForm" method="post">
		</form>
		<center>
			<table id="maintable">
				<form method="post" name="mfs_form">
					<tr>
						<td>
							<table class="OuterTable" style="WIDTH: 500px; HEIGHT: 200px; VERTICAL-ALIGN: text-top">
								<xsl:if test="/application/options/option[@name='unlockproject']/@show='true'">
									<tr class="InnerTableHeading">
										<td>
											<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='checkin_gui_projectlock_header']/value" />
										</td>
									</tr>
									<tr>
										<td>
											<table class="InnerTable" style="width: 100%">
												<tr class="InnerTableMainDataDark">
													<xsl:attribute name="onclick">
														clickItem( 'ckeepprojectlock');
													</xsl:attribute>
													<td style="VERTICAL-ALIGN: middle; WIDTH: 1%">
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
											</table>
											<br/>
										</td>
									</tr>
								</xsl:if>
								<tr class="InnerTableHeading">
									<td>
										<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_checkin_gui_filelist_header']/value" />
									</td>
								</tr>
								<tr style="HEIGHT: 1px">
									<td>
										<xsl:choose>
											<xsl:when test="count(//application/filelist/file[@user='true' and @dependency=''])=0">
												<div style="WIDTH: 500px; HEIGHT: 200px; OVERFLOW-X: auto; OVERFLOW-Y: scroll; VERTICAL-ALIGN: text-top;">
												<table class="InnerTable">
													<tr>
														<td class="InnerTableMainData">
															<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_checkin_no_files_in_user_folder']/value" />
														</td>
													</tr>
												</table>
												</div>
											</xsl:when>
											<xsl:otherwise>
												<table class="InnerTable">
													<tr>
														<td class="InnerTableMainData">
															<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_checkin_select_files_text']/value" />
														</td>
													</tr>
												</table>
												<div style="WIDTH: 500px; HEIGHT: 200px; OVERFLOW-X: auto; OVERFLOW-Y: scroll; VERTICAL-ALIGN: text-top;">
													<table class="InnerTable">
														<thead>
															<tr class="InnerTableMainDataDark">
																<td style="BACKGROUND-COLOR: transparent"></td>
																<td style="WIDTH: 31px; BACKGROUND-COLOR: transparent"></td>
																<td style="WIDTH: 71px; PADDING-LEFT: 4px; PADDING-RIGHT: 4px; TEXT-ALIGN: center">
																	<b>
																		Update Shared
																	</b>
																</td>
																<td style="WIDTH: 71px; TEXT-ALIGN: center">
																	<b>
																		Keep Local
																	</b>
																</td>
															</tr>
														</thead>
														<tbody>
															<tr class="InnerTableMainDataDark">
																<td><img id="f_all" src="images/f_plus.png" border="0" onclick="toggleDisplayFiles()" />
																	<xsl:text>&#x20;</xsl:text>
																	<b>
																		<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_row_all_files']/value" />
																	</b>
																</td>
																<td style="WIDTH: 31px; TEXT-ALIGN: center"><xsl:text>&#x20;</xsl:text></td>
																<td style="TEXT-ALIGN: center">
																	<input type="checkbox" id="checkallfiles" name="checkallfiles" style="WIDTH: 100%" checked="checked">
																		<xsl:attribute name="onclick">
																			<xsl:text>return allFileOptionClicked(this, 'checkin')</xsl:text>
																		</xsl:attribute>
																	</input>
																</td>
																<td style="TEXT-ALIGN: center">
																	<input type="checkbox" id="checkallfileskeep" name="checkallfileskeep" style="WIDTH: 100%">
																		<xsl:attribute name="onclick">
																			<xsl:text>return allFileOptionClicked(this, 'keep')</xsl:text>
																		</xsl:attribute>
																	</input>
																</td>
															</tr>
														</tbody>
														<tbody id="filelistbody" style="DISPLAY: none">
															<xsl:for-each select="//application/filelist/file[@user='true' and @dependency='']">
																<!--
																Only show files that exists in the user folder and
																don't show files that are dependent of other files
																-->
																<tr class="InnerTableMainDataDark">
																	<td style="PADDING-LEFT: 20px">
																		<xsl:value-of select="@name"/>
																	</td>
																	<td style="WIDTH: 31px; TEXT-ALIGN: center">
																		<a>
																			<xsl:attribute name="title">
																				<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_tooltip_show_fileinfo']/value" />
																			</xsl:attribute>
																			<xsl:attribute name="onclick">
																				<xsl:text>fileInformationClicked('</xsl:text><xsl:value-of select="@name" /><xsl:text>')</xsl:text>
																			</xsl:attribute>
																			<img src="images/f_info.png" border="0"/>
																		</a>
																	</td>
																	<td style="TEXT-ALIGN: center">
																		<input type="checkbox" style="WIDTH: 100%" onclick="return fileCheckinOptionClicked(this)" checked="checked">
																			<xsl:attribute name="id">
																				<xsl:text>checkid</xsl:text><xsl:value-of select="@name" />
																			</xsl:attribute>
																			<xsl:attribute name="name">
																				<xsl:text>checkname</xsl:text><xsl:value-of select="@name" />
																			</xsl:attribute>
																			<xsl:attribute name="filename">
																				<xsl:value-of select="@name" />
																			</xsl:attribute>
																			<xsl:attribute name="optiontype">
																				<xsl:text>checkin</xsl:text>
																			</xsl:attribute>
																		</input>
																	</td>
																	<td style="TEXT-ALIGN: center">
																		<input type="checkbox" onclick="return fileKeepOptionClicked(this)" style="WIDTH: 100%" >
																			<xsl:attribute name="id">
																				<xsl:text>checkidkeep</xsl:text><xsl:value-of select="@name" />
																			</xsl:attribute>
																			<xsl:attribute name="name">
																				<xsl:text>checknamekeep</xsl:text><xsl:value-of select="@name" />
																			</xsl:attribute>
																			<xsl:attribute name="filename">
																				<xsl:value-of select="@name" />
																			</xsl:attribute>
																			<xsl:attribute name="optiontype">
																				<xsl:text>keep</xsl:text>
																			</xsl:attribute>
																		</input>
																	</td>
																</tr>
															</xsl:for-each>
														</tbody>
													</table>
												</div>
											</xsl:otherwise>
										</xsl:choose>
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
