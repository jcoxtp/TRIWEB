<?xml version="1.0" encoding="utf-8" ?> <!--
    (c) 2002-2003 SPSS MR
    
    Created by: MikkelFJ 
   
    Significant parts of this application is javascript in tabs.html
    The entry point is test.html which opens a dialog with index.html.
    index.html binds the tab control to the datalink.aspx file which defines the tab pages.
    The properties.xsl stylesheet generates the actual content of datalink.aspx.

    The id's of input / select fields and the text in the first column in the PropertyList table
    are used to synchronize data between tabs. Each top-level div is a tab.
   
    The stylesheet is applied to properties.xml which is used to build the PropertyList table
    and to define options in select tags.
    
    The xml files MDSCItems.xml and CDSCItems.xml are used to define MDSC and CDSC
    select options.
    
    The DSC Component in datalink.aspx generates javascript objects also used to initialize
    the the MDSC/CDSC items. The xml entries are added first. XML entries can be used to add
    DSC's that are not registered on the web server. They also define the default (none), i.e.
    no DSC selected.
    
    This application was originally written in aspx, but most logic ended up client side in javascript
    and in the end it was easier to create everything using xslt.
    
    Language translations:
    The relative path the .resx used for translations is passed in the "resource" global variable
    from the caller of the transformation.
    
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" />
	<xsl:param name="resource" />
	<xsl:template match="/properties">
		<div id="AdvancedDiv" style="display:none">
			<br />
			<p>
				<b>
					<xsl:value-of select="document($resource)//root/data[@name='metadata-source-diff-loc']/value" />
				</b>
				<br />
				<xsl:for-each select="property[@name='MR Init MDM DataSource Use']">
					<select id="MR Init MDM DataSource Use">
						<xsl:call-template name="apply-categories" />
					</select>
				</xsl:for-each>
			</p>
			<p>
				<b>
					<xsl:value-of select="document($resource)//root/data[@name='categorical-variables']/value" />
				</b>
				<br />
				<xsl:for-each select="property[@name='MR Init Category Names']">
					<select id="MR Init Category Names">
						<xsl:call-template name="apply-categories" />
					</select>
				</xsl:for-each>
			</p>
			<p>
				<input id="Validation" type="checkbox" />
				<b>
					<xsl:value-of select="document($resource)//root/data[@name='validation']/value" />
				</b>
				<br />
				<input id="AllowDirty" type="checkbox" />
				<b>
					<xsl:value-of select="document($resource)//root/data[@name='allow-dirty']/value" />
				</b>
				<br />
			</p>
			<p>
				<b>
					<xsl:value-of select="document($resource)//root/data[@name='user-name']/value" />
				</b>
				<br />
				<input id="UserName" type="text" style="WIDTH: 255px" />
			</p>
			<p>
				<b>
					<xsl:value-of select="document($resource)//root/data[@name='password']/value" />
				</b>
				<br />
				<input id="Password" type="password" style="WIDTH: 255px" />
			</p>
		</div>
		<div id="AllDiv" style="display:none">
			<br />
			<p>
				<table cellspacing="0" rules="all" border="0" id="PropertyList" style="border-collapse:collapse;">
					<td>
						<b>
							<xsl:value-of select="document($resource)//root/data[@name='property']/value" />
						</b>
					</td>
					<td>
						<b>
							<xsl:value-of select="document($resource)//root/data[@name='value']/value" />
						</b>
					</td>
					<xsl:apply-templates select="property" />
				</table>
			</p>
		</div>
	</xsl:template>
	
	<!-- -->
	
	<xsl:template name="apply-categories">
		<xsl:for-each select='category'>
			<option>
				<xsl:attribute name="value">
					<xsl:value-of select="@value" />
				</xsl:attribute>
				<xsl:variable name="stroption" select="@res-name" />
				<xsl:value-of select="document($resource)//root/data[@name=$stroption]/value" />
			</option>
		</xsl:for-each>
	</xsl:template>
	
	<!-- -->
	
	<xsl:template match="property">
		<tr>
			<td>
				<xsl:value-of select="@name" />
			</td>
			<td>
				<input type="text"  style="WIDTH: 230px">
					<xsl:attribute name="value">
						<xsl:value-of select="@value" />
					</xsl:attribute>
				</input>
			</td>
      <td style="display:none">
        <xsl:value-of select="@name" />
      </td>
		</tr>
	</xsl:template>
	
	<!-- -->
	
	<xsl:template match="property[@type='bool']">
		<tr>
			<td>
				<xsl:value-of select="@name" />
			</td>
			<td>
				<input type="checkbox">
					<xsl:if test="@value='true' ">
						<xsl:attribute name="checked">true</xsl:attribute>
					</xsl:if>
				</input>
			</td>
      <td style="display:none">
        <xsl:value-of select="@name" />
      </td>
		</tr>
	</xsl:template>
	
	<!-- -->
	
	<xsl:template match="property[@type='single']">
		<tr>
			<td>
				<xsl:value-of select="@name" />
			</td>
			<td>
				<select>
					<xsl:call-template name="apply-categories" />
				</select>
			</td>
      <td style="display:none">
        <xsl:value-of select="@name" />
      </td>
		</tr>
	</xsl:template>
	
	<!-- -->
	
	<xsl:template match="property[@type='password']">
		<tr>
			<td>
				<xsl:value-of select="@name" />
			</td>
			<td>
				<input type="password" style="WIDTH: 230px">
					<xsl:attribute name="value">
						<xsl:value-of select="@value" />
					</xsl:attribute>
				</input>
			</td>
      <td style="display:none">
        <xsl:value-of select="@name" />
      </td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
