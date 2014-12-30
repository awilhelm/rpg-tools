<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="*" mode="weights">
<xsl:param name="parent" select="1"/>
<xsl:variable name="frequency" select="$parent * @frequency div sum(../*/@frequency)"/>
<xsl:choose>
	<xsl:when test="*"><xsl:apply-templates mode="weights"><xsl:with-param name="parent" select="$frequency"/></xsl:apply-templates></xsl:when>
	<xsl:otherwise>{frequency: <xsl:value-of select="$frequency"/>}, </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="*" mode="select">
	<xsl:param name="indent"/>
	<xsl:choose>
		<xsl:when test="*">
			<optgroup label="{$indent}{@name}" title="{@description}"/>
			<xsl:apply-templates mode="select">
				<xsl:with-param name="indent" select="concat($indent,'  ')"/>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<option title="{@description}" value="{@value}">
				<xsl:value-of select="$indent"/>
				<xsl:value-of select="@name"/>
			</option>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
