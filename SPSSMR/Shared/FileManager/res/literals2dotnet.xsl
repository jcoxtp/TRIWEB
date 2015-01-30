<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes" />
	<xsl:param name="lang" />
	<xsl:template match="/">
		<root>
			<xsd:schema id="root" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
				<xsd:element name="root" msdata:IsDataSet="true">
					<xsd:complexType>
						<xsd:choice maxOccurs="unbounded">
							<xsd:element name="data">
								<xsd:complexType>
									<xsd:sequence>
										<xsd:element name="value" type="xsd:string" minOccurs="0" msdata:Ordinal="1" />
										<xsd:element name="comment" type="xsd:string" minOccurs="0" msdata:Ordinal="2" />
									</xsd:sequence>
									<xsd:attribute name="name" type="xsd:string" />
									<xsd:attribute name="type" type="xsd:string" />
									<xsd:attribute name="mimetype" type="xsd:string" />
								</xsd:complexType>
							</xsd:element>
							<xsd:element name="resheader">
								<xsd:complexType>
									<xsd:sequence>
										<xsd:element name="value" type="xsd:string" minOccurs="0" msdata:Ordinal="1" />
									</xsd:sequence>
									<xsd:attribute name="name" type="xsd:string" use="required" />
								</xsd:complexType>
							</xsd:element>
						</xsd:choice>
					</xsd:complexType>
				</xsd:element>
			</xsd:schema>
			<resheader name="ResMimeType">
				<value>text/microsoft-resx</value>
			</resheader>
			<resheader name="Version">
				<value>1.0.0.0</value>
			</resheader>
			<resheader name="Reader">
				<value>System.Resources.ResXResourceReader, System.Windows.Forms, Version=1.0.3102.0, Culture=neutral, PublicKeyToken=b77a5c561934e089</value>
			</resheader>
			<resheader name="Writer">
				<value>System.Resources.ResXResourceWriter, System.Windows.Forms, Version=1.0.3102.0, Culture=neutral, PublicKeyToken=b77a5c561934e089</value>
			</resheader>
			<xsl:for-each select="/literals/literal">
				<data>
					<xsl:attribute name="name">
						<xsl:value-of select="@name" />
					</xsl:attribute>
					<value>
						<xsl:value-of select="./child::node()[name()=$lang]" />
					</value>
					<xsl:if test="./child::node()[name()='comment']!=''">
						<comment><xsl:value-of select="./child::node()[name()='comment']" /></comment>
					</xsl:if>
				</data>
			</xsl:for-each>
		</root>
	</xsl:template>
</xsl:stylesheet>
