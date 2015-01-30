<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="globals.xsl" />
	<xsl:output method="html" indent="yes" encoding="UTF-8" />
	<xsl:template match="/">
		<xsl:variable name="uploadenabled">
			<xsl:value-of select="//application/options/option[@name='includeupload']" />
		</xsl:variable>
		<form id="errorMessageForm" style="DISPLAY: none" name="errorMessageForm" method="post">
			<input id="errOneRequiredFileMissing" type="hidden">
				<xsl:attribute name="value">
					<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_err_required_files_missing_one']/value" />
				</xsl:attribute>
			</input>
			<input id="errMoreRequiredFileMissing" type="hidden">
				<xsl:attribute name="value">
					<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_err_required_files_missing_more']/value" />
				</xsl:attribute>
			</input>
			<input id="confirmOverWriteUserFiles" type="hidden">
				<xsl:attribute name="value">
					<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_confirm_overwriteuserfiles']/value" />
				</xsl:attribute>
			</input>
			<input id="errCheckOneRequiredFileMissing" type="hidden">
				<xsl:attribute name="value">
					<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_err_check_required_files_missing_one']/value" />
				</xsl:attribute>
			</input>
			<input id="errCheckMoreRequiredFileMissing" type="hidden">
				<xsl:attribute name="value">
					<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_err_check_required_files_missing_more']/value" />
				</xsl:attribute>
			</input>
			<input id="errRequiredFileSelectionMissing" type="hidden">
				<xsl:attribute name="value">
					<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_err_required_file_selection_missing']/value" />
				</xsl:attribute>
			</input>
		</form>
		<center>
			<table id="maintable">
				<form method="post" name="mfs_form">
					<tr>
						<td>
							<table class="OuterTable" style="WIDTH: 500px; HEIGHT: 200px; VERTICAL-ALIGN: text-top">
								<tr style="HEIGHT: 1px">
									<td>
										<div style="WIDTH: 500px; HEIGHT: 200px; OVERFLOW-X: auto; OVERFLOW-Y: scroll; VERTICAL-ALIGN: text-top">
											<table class="InnerTable">
												<tr>
													<td class="InnerTableMainData">
														<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_select_explanation']/value" />
													</td>
												</tr>
											</table>
											<table class="InnerTable">
												<thead>
													<tr class="InnerTableMainDataDark">
														<td class="InnerTableMainData" style="BACKGROUND-COLOR: transparent">
															<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_required_legend']/value" />
														</td>
														<td style="WIDTH: 31px; BACKGROUND-COLOR: transparent"></td>
														<xsl:if test="$uploadenabled='true'">
															<td style="WIDTH: 31px; BACKGROUND-COLOR: transparent"></td>
														</xsl:if>
														<td style="WIDTH: 71px; PADDING-LEFT: 4px; PADDING-RIGHT: 4px; TEXT-ALIGN: center">
															<b>
																<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_column_name_shared']/value" />
															</b>
														</td>
														<td style="WIDTH: 71px; TEXT-ALIGN: center">
															<b>
																<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_column_name_user']/value" />
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
														<xsl:if test="$uploadenabled='true'">
															<td style="WIDTH: 31px; TEXT-ALIGN: center"><xsl:text>&#x20;</xsl:text></td>
														</xsl:if>
														<td style="TEXT-ALIGN: center">
															<input type="radio" id="radioallfilesmaster" name="radioallfiles" value="master" style="WIDTH: 100%">
																<xsl:attribute name="onclick">
																	<xsl:text>return allFileOptionClicked(this,</xsl:text><xsl:value-of select="count(//application/filelist/file[@master='false' and @required='true'])" /><xsl:text>)</xsl:text>
																</xsl:attribute>
															</input>
														</td>
														<td style="TEXT-ALIGN: center">
															<input type="radio" id="radioallfilesuser" name="radioallfiles" value="user" style="WIDTH: 100%">
																<xsl:attribute name="onclick">
																	<xsl:text>return allFileOptionClicked(this,</xsl:text><xsl:value-of select="count(//application/filelist/file[@user='false' and @required='true'])" /><xsl:text>)</xsl:text>
																</xsl:attribute>
															</input>
														</td>
													</tr>
												</tbody>
												<tbody id="filelistbody" style="DISPLAY: none">
													<xsl:attribute name="totalRequiredMissing">
														<xsl:value-of select="count(//application/filelist/file[@master='false' and @user='false' and @required='true'])" />
													</xsl:attribute>
													<xsl:for-each select="//application/filelist/file">
														<xsl:choose>
															<xsl:when test="@dependency!=''">
																<!--
																<tr class="InnerTableMainDataDark">
																	<td colspan="5">
																		<i>(TODO : dont show this - test only) <xsl:value-of select="@name"/> dependent of <xsl:value-of select="@dependency"/></i>
																	</td>
																</tr>
																-->
															</xsl:when>
															<xsl:otherwise>
																<tr class="InnerTableMainDataDark">
																	<td style="PADDING-LEFT: 20px">
																		<xsl:if test="@required='true' and @master='false' and @user='false'">
																			<xsl:attribute name="style">
																				<xsl:text>COLOR: red; FONT-WEIGHT: bold; PADDING-LEFT: 20px</xsl:text>
																			</xsl:attribute>
																		</xsl:if>
																		<xsl:value-of select="@name"/><xsl:if test="@required='true'"> *</xsl:if>
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
																	<xsl:if test="$uploadenabled='true'">
																		<td style="WIDTH: 31px; TEXT-ALIGN: center">
																			<a>
																				<xsl:attribute name="title">
																					<xsl:value-of select="document(concat('res/literals.', $lang, '.resx'))//root/data[@name='mfs_tooltip_upload_file_as']/value" /><xsl:value-of select="@name"/>
																				</xsl:attribute>
																				<xsl:attribute name="onclick">
																					<xsl:text>doUpload('</xsl:text><xsl:value-of select="@name" /><xsl:text>')</xsl:text>
																				</xsl:attribute>
																				<img src="images/f_upload.png" border="0"/>
																			</a>
																		</td>
																	</xsl:if>
																	<td style="TEXT-ALIGN: center">
																		<xsl:choose>
																			<xsl:when test="not(@master='false')">
																				<input type="radio" value="master" ismasteroption="true" onclick="return fileOptionClicked(this)"  style="WIDTH: 100%">
																					<xsl:attribute name="id">
																						<xsl:text>radiomasterid</xsl:text><xsl:value-of select="@name" />
																					</xsl:attribute>
																					<xsl:attribute name="name">
																						<xsl:text>radioname</xsl:text><xsl:value-of select="@name" />
																					</xsl:attribute>
																					<xsl:attribute name="filename">
																						<xsl:value-of select="@name" />
																					</xsl:attribute>
																					<xsl:attribute name="requiredfile">
																						<xsl:value-of select="@required" />
																					</xsl:attribute>
																				</input>
																			</xsl:when>
																			<xsl:otherwise>
																				<xsl:text>&#x20;</xsl:text>
																			</xsl:otherwise>
																		</xsl:choose>
																	</td>
																	<td style="TEXT-ALIGN: center">
																		<xsl:choose>
																			<xsl:when test="not(@user='false')">
																				<input type="radio" value="user" isuseroption="true" onclick="return fileOptionClicked(this)" style="WIDTH: 100%">
																					<xsl:attribute name="id">
																						<xsl:text>radiouserid</xsl:text><xsl:value-of select="@name" />
																					</xsl:attribute>
																					<xsl:attribute name="name">
																						<xsl:text>radioname</xsl:text><xsl:value-of select="@name" />
																					</xsl:attribute>
																					<xsl:attribute name="filename">
																						<xsl:value-of select="@name" />
																					</xsl:attribute>
																					<xsl:attribute name="requiredfile">
																						<xsl:value-of select="@required" />
																					</xsl:attribute>
																				</input>
																			</xsl:when>
																			<xsl:otherwise>
																				<xsl:text>&#x20;</xsl:text>
																			</xsl:otherwise>
																		</xsl:choose>
																	</td>
																</tr>
															</xsl:otherwise>
														</xsl:choose>
													</xsl:for-each>
												</tbody>
											</table>
										</div>
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
