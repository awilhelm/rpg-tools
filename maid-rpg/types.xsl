<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="types" select="document('types.xml')/*/*"/>

<xsl:template name="use-types">
<script type="application/javascript">var type_table = [<xsl:for-each select="$types">{attributes: [<xsl:value-of select="@athletics"/>, <xsl:value-of select="@affection"/>, <xsl:value-of select="@skill"/>, <xsl:value-of select="@cunning"/>, <xsl:value-of select="@luck"/>, <xsl:value-of select="@will"/>]}, </xsl:for-each>]</script>
</xsl:template>

</xsl:stylesheet>
