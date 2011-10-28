<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="list">
<td/>
<td>
	<input type="button" value="Roll" onclick="roll_all(this)"/>
	<input type="button" value="+" onclick="append(this)"/>
</td>
</xsl:template>

<xsl:template name="use-lists">
<script src="lists.js" type="application/javascript"/>
</xsl:template>

</xsl:stylesheet>
