<?xml version="1.0" encoding="utf-8"?>

<!--
	(c) 2002-2003 SPSS MR

	Created by: MikkelFJ 

	Apply to a res/literals.<my-lang>.resx file
	to generate translated text in hidden fields.
-->

<xsl:stylesheet    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" />
<xsl:template match="root" >

    <input type="hidden" id="mdm-properties-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='mdm-properties']/value" />
     </xsl:attribute>
    </input>

    <input type="hidden" id="error-processing-doc-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='error-processing-doc']/value" />
     </xsl:attribute>
    </input>
    
    <input type="hidden" id="ok-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='ok']/value" />
     </xsl:attribute>
    </input>
    
    <input type="hidden" id="cancel-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='cancel']/value" />
     </xsl:attribute>
    </input>

    <input type="hidden" id="apply-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='apply']/value" />
     </xsl:attribute>
    </input>

     <input type="hidden" id="latest-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='latest']/value" />
     </xsl:attribute>
    </input>
    
    <input type="hidden" id="all-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='all']/value" />
     </xsl:attribute>
    </input>
       
    <input type="hidden" id="bad-version-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='bad-version']/value" />
     </xsl:attribute>
    </input>
    
    <input type="hidden" id="versions-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='versions']/value" />
     </xsl:attribute>
    </input>
    
    <input type="hidden" id="current-version-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='current-version']/value" />
     </xsl:attribute>
    </input>
    
    <input type="hidden" id="languages-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='languages']/value" />
     </xsl:attribute>
    </input>
    
    <input type="hidden" id="contexts-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='contexts']/value" />
     </xsl:attribute>
    </input>
    
    <input type="hidden" id="label-types-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='label-types']/value" />
     </xsl:attribute>
    </input>
    
     <input type="hidden" id="unable-to-open-document-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='unable-to-open-document']/value" />
     </xsl:attribute>
    </input>

    <input type="hidden" id="document-path-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='document-path']/value" />
     </xsl:attribute>
    </input>
    
    <input type="hidden" id="mdsc-not-suppported-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='mdsc-not-suppported']/value" />
     </xsl:attribute>
    </input>
    
     <input type="hidden" id="select-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='select']/value" />
     </xsl:attribute>
    </input>

    <input type="hidden" id="name-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='name']/value" />
     </xsl:attribute>
    </input>
    
    <input type="hidden" id="created-by-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='created-by']/value" />
     </xsl:attribute>
    </input>
    
    <input type="hidden" id="created-date-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='created-date']/value" />
     </xsl:attribute>
    </input>
    
    <input type="hidden" id="description-text">
     <xsl:attribute name="value">
          <xsl:value-of select="data[@name='description']/value" />
     </xsl:attribute>
    </input>

</xsl:template>
</xsl:stylesheet>