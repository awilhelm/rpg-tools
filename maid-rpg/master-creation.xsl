<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="colors.xsl"/>
<xsl:import href="common.xsl"/>
<xsl:import href="kanas.xsl"/>
<xsl:import href="lists.xsl"/>
<xsl:import href="special-qualities.xsl"/>
<xsl:variable name="attributes" select="document('attributes.xml')/*/*"/>
<xsl:variable name="maid-special-qualities" select="document('special-qualities.xml')/*/*[position() > 18]"/>
<xsl:variable name="maid-types" select="document('types.xml')/*/*"/>
<xsl:variable name="power-sources" select="document('master-power-sources.xml')/*/*"/>
<xsl:variable name="special-qualities" select="document('master-special-qualities.xml')/*/*"/>
<xsl:variable name="stress-explosions" select="document('stress-explosions.xml')/*/*"/>
<xsl:variable name="types" select="document('master-types.xml')/*/*"/>

<xsl:template match="/*">
	<xsl:call-template name="use-colors"/>
	<xsl:call-template name="use-kanas"/>
	<xsl:call-template name="use-lists"/>
	<form id="form">
		<table>
			<tbody id="misc">
				<tr>
					<th>Name</th>
					<td><input type="text"/></td>
					<td><input type="button" value="Roll" onclick="roll_name(this)"/></td>
				</tr>
				<tr id="age">
					<th>Age</th>
					<td><input type="text"/></td>
					<td><input type="button" value="Roll" onclick="roll_age(this)"/></td>
				</tr>
				<tr>
					<th>Eye Color</th>
					<xsl:call-template name="color"/>
				</tr>
				<tr>
					<th>Hair Color</th>
					<xsl:call-template name="color"/>
				</tr>
				<tr>
					<th>Master Type</th>
					<td><select onchange="type_changed(this)"><xsl:for-each select="$types"><option title="{@description}" x-age-dice="{@age-dice}" x-age-faces="{@age-faces}" x-age-base="{@age-base}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
					<td><input type="button" value="Roll" onclick="roll_select(this)"/></td>
				</tr>
				<tr>
					<th>Favorite Maid Type</th>
					<td><select><xsl:for-each select="$maid-types"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
					<td><input type="button" value="Roll" onclick="roll_select(this)"/></td>
				</tr>
				<tr>
					<th>Stress Explosion!</th>
					<td><select><xsl:for-each select="$stress-explosions"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
					<td><input type="button" value="Roll" onclick="roll_select(this)"/></td>
				</tr>
			</tbody>
			<tbody id="attributes">
				<tr>
					<th>Attributes</th>
					<td/>
					<td><input type="button" value="Roll" onclick="roll_all(this)"/></td>
				</tr>
				<xsl:for-each select="$attributes">
					<tr title="{@description}">
						<td><xsl:value-of select="@name"/></td>
						<td><input type="text"/></td>
						<td><input type="button" value="Roll" onclick="roll_attribute(this, '{@attribute}')"/></td>
					</tr>
				</xsl:for-each>
			</tbody>
			<xsl:call-template name="list">
				<xsl:with-param name="id">special-qualities</xsl:with-param>
				<xsl:with-param name="title">Special Qualities</xsl:with-param>
				<xsl:with-param name="prototype"><select><xsl:apply-templates select="$special-qualities" mode="select"/></select></xsl:with-param>
				<xsl:with-param name="roll">roll_select_with_frequencies(this, master_special_qualities)</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="list">
				<xsl:with-param name="id">power-sources</xsl:with-param>
				<xsl:with-param name="title">Power Sources</xsl:with-param>
				<xsl:with-param name="prototype"><select><xsl:for-each select="$power-sources"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></xsl:with-param>
				<xsl:with-param name="roll">roll_select(this)</xsl:with-param>
			</xsl:call-template>
		</table>
	</form>
	<script type="application/javascript">
		var master_special_qualities = [<xsl:apply-templates select="$special-qualities" mode="weights"/>]
	</script>
	<script type="application/javascript" src="master-creation.js"/>
</xsl:template>

<xsl:template match="maid-special-qualities" mode="select">
	<xsl:param name="indent"/>
	<xsl:apply-templates select="$maid-special-qualities" mode="select">
		<xsl:with-param name="indent" select="$indent"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="maid-special-qualities" mode="weights">
	<xsl:param name="parent"/>
	<xsl:apply-templates select="$maid-special-qualities" mode="weights">
		<!-- multiplié par 2 parce qu'on ne considère que la moitié de maid-special-qualities.xml -->
		<xsl:with-param name="parent" select="2 * $parent"/>
	</xsl:apply-templates>
</xsl:template>

</xsl:stylesheet>
