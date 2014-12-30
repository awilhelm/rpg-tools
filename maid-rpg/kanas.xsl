<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="kanas" select="document('kanas.xml')/*/*"/>

<xsl:template name="use-kanas">
<script type="application/javascript" src="kanas.js"/>
<script type="application/javascript">var kana_table = [<xsl:for-each select="$kanas">{latin: '<xsl:value-of select="@latin"/>', frequency: <xsl:value-of select="@frequency div sum($kanas/@frequency)"/>}, </xsl:for-each>]</script>
</xsl:template>

</xsl:stylesheet>
