<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="special-qualities" select="document('special-qualities.xml')/*/*"/>

<xsl:template name="use-special-qualities">
<script type="application/javascript">var special_quality_table = [<xsl:apply-templates select="$special-qualities"/>]</script>
</xsl:template>

<xsl:template match="special-quality">
<xsl:param name="parent" select="1"/>
<xsl:variable name="frequency" select="$parent div count(parent::*/*)"/>
<xsl:choose>
	<xsl:when test="*"><xsl:apply-templates><xsl:with-param name="parent" select="$frequency"/></xsl:apply-templates></xsl:when>
	<xsl:otherwise>{frequency: <xsl:value-of select="$frequency"/>}, </xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>
