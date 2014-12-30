<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="common.xsl"/>
<xsl:import href="kanas.xsl"/>
<xsl:import href="lists.xsl"/>
<xsl:import href="special-qualities.xsl"/>
<xsl:variable name="attributes" select="document('attributes.xml')/*/*"/>
<xsl:variable name="colors" select="document('colors.xml')/*/*"/>
<xsl:variable name="hair-colors" select="document('butler-hair-colors.xml')/*/*"/>
<xsl:variable name="powers" select="document('butler-powers.xml')/*/*"/>
<xsl:variable name="roots" select="document('butler-roots.xml')/*/*"/>
<xsl:variable name="special-qualities" select="document('butler-special-qualities.xml')/*/*"/>
<xsl:variable name="suit-colors" select="document('butler-suit-colors.xml')/*/*"/>
<xsl:variable name="types" select="document('butler-types.xml')/*/*"/>
<xsl:variable name="weapons" select="document('butler-weapons.xml')/*/*"/>

<xsl:template match="/*">
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
				<tr>
					<th>Age</th>
					<td><input type="text"/></td>
					<td><input type="button" value="Roll" onclick="roll_age(this)"/></td>
				</tr>
				<tr>
					<th>Suit Color</th>
					<td class="color"><select onchange="update_color(this)"><xsl:apply-templates select="$suit-colors" mode="select"/></select> ██ </td>
					<td><input type="button" value="Roll" onclick="roll_select_with_frequencies(this, butler_suit_colors)"/></td>
				</tr>
				<tr>
					<th>Eye Color</th>
					<td class="color"><select onchange="update_color(this)"><xsl:apply-templates select="$colors" mode="select"/></select> ██ </td>
					<td><input type="button" value="Roll" onclick="roll_select_with_frequencies(this, butler_eye_colors)"/></td>
				</tr>
				<tr>
					<th>Hair Color</th>
					<td class="color"><select onchange="update_color(this)"><xsl:apply-templates select="$hair-colors" mode="select"/></select> ██ </td>
					<td><input type="button" value="Roll" onclick="roll_select_with_frequencies(this, butler_hair_colors)"/></td>
				</tr>
				<tr>
					<th>Butler Roots</th>
					<td><select><xsl:for-each select="$roots"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
					<td><input type="button" value="Roll" onclick="roll_select(this)"/></td>
				</tr>
			</tbody>
			<tbody id="types">
				<tr>
					<th>Butler Types</th>
					<td/>
					<td><input type="button" value="Roll" onclick="roll_all(this)"/></td>
				</tr>
				<xsl:for-each select="$types[position() &lt;= 2]">
					<tr>
						<td/>
						<td><select onchange="type_changed(this, {position()})"><xsl:for-each select="$types"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
						<td><input type="button" value="Roll" onclick="roll_select(this)"/></td>
					</tr>
				</xsl:for-each>
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
						<td>
							<input type="text" onchange="attribute_changed(this)"/>
							<xsl:text> + </xsl:text>
							<input disabled="disabled" type="text"/>
							<xsl:text> = </xsl:text>
							<input disabled="disabled" type="text"/>
						</td>
						<td><input type="button" value="Roll" onclick="roll_attribute(this, '{@attribute}')"/></td>
					</tr>
				</xsl:for-each>
			</tbody>
			<xsl:call-template name="list">
				<xsl:with-param name="id">special-qualities</xsl:with-param>
				<xsl:with-param name="title">Special Qualities</xsl:with-param>
				<xsl:with-param name="prototype"><select><xsl:for-each select="$special-qualities"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></xsl:with-param>
				<xsl:with-param name="roll">roll_select(this)</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="list">
				<xsl:with-param name="id">weapons</xsl:with-param>
				<xsl:with-param name="title">Butler Weapons</xsl:with-param>
				<xsl:with-param name="prototype"><select><xsl:for-each select="$weapons"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></xsl:with-param>
				<xsl:with-param name="roll">roll_select(this)</xsl:with-param>
			</xsl:call-template>
			<tbody id="powers">
				<tr>
					<th>Butler Powers</th>
					<td/>
					<td><input type="button" value="Roll" onclick="roll_all(this)"/></td>
				</tr>
				<xsl:for-each select="$types[position() &lt;= 2]">
					<tr>
						<td/>
						<td><select onchange="type_changed(this, {position()})"><xsl:for-each select="$types"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
						<td><input type="button" value="Roll" onclick="roll_select(this)"/></td>
					</tr>
				</xsl:for-each>
			</tbody>
			<tbody class="hidden">
				<xsl:for-each select="$types">
					<xsl:variable name="type" select="@id"/>
					<tr>
						<td/>
						<td><select title="{$types[@id = $type]/@name} Power"><xsl:for-each select="$powers[@type = $type]"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
						<td><input type="button" value="Roll" onclick="roll_power(this)"/></td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</form>
	<script type="application/javascript">
		var butler_types = [<xsl:for-each select="$types">{attributes: [<xsl:value-of select="@athletics"/>,<xsl:value-of select="@affection"/>,<xsl:value-of select="@skill"/>,<xsl:value-of select="@cunning"/>,<xsl:value-of select="@luck"/>,<xsl:value-of select="@will"/>]},</xsl:for-each>]
		var butler_suit_colors = [<xsl:apply-templates select="$suit-colors" mode="weights"/>]
		var butler_eye_colors = [<xsl:apply-templates select="$colors" mode="weights"/>]
		var butler_hair_colors = [<xsl:apply-templates select="$hair-colors" mode="weights"/>]
	</script>
	<script src="colors.js" type="application/javascript"/>
	<script type="application/javascript" src="butler-creation.js"/>
</xsl:template>

<xsl:template match="maid-colors" mode="select">
	<xsl:param name="indent"/>
	<xsl:apply-templates select="$colors" mode="select">
		<xsl:with-param name="indent" select="$indent"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="maid-colors" mode="weights">
	<xsl:param name="parent"/>
	<xsl:apply-templates select="$colors" mode="weights">
		<xsl:with-param name="parent" select="$parent"/>
	</xsl:apply-templates>
</xsl:template>

</xsl:stylesheet>
