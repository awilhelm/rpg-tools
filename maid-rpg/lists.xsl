<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="list">
	<xsl:param name="id"/>
	<xsl:param name="title"/>
	<xsl:param name="prototype"/>
	<xsl:param name="roll"/>
	<tbody id="{$id}">
		<tr>
			<th colspan="2"><xsl:value-of select="$title"/></th>
			<td>
				<input type="button" value="Roll" onclick="roll_all(this)"/>
				<input type="button" value="+" onclick="list_add(this)"/>
			</td>
		</tr>
	</tbody>
	<tbody class="hidden">
		<tr>
			<td/>
			<td><xsl:copy-of select="$prototype"/></td>
			<td>
				<input type="button" value="Roll" onclick="{$roll}"/>
				<input type="button" value="−" onclick="list_remove(this)"/>
			</td>
		</tr>
	</tbody>
</xsl:template>

<xsl:template name="use-lists">
<script src="lists.js" type="application/javascript"/>
</xsl:template>

</xsl:stylesheet>
