<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="colors" select="document('colors.xml')/*/*"/>

<xsl:template name="color">
<td class="color">
	<select onchange="update_color(this)"><xsl:for-each select="$colors"><option value="{@value}"><xsl:value-of select="@name"/></option></xsl:for-each></select>
	<xsl:text> ██</xsl:text>
</td>
<td><input type="button" value="Roll" onclick="roll_color(this)"/></td>
</xsl:template>

<xsl:template name="use-colors">
<script type="application/javascript">var color_table = [<xsl:for-each select="$colors">{frequency: <xsl:value-of select="@frequency div sum($colors/@frequency)"/>}, </xsl:for-each>]</script>
<script src="colors.js" type="application/javascript"/>
</xsl:template>

</xsl:stylesheet>
