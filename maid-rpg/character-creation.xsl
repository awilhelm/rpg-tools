<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="common.xsl"/>
<xsl:import href="colors.xsl"/>
<xsl:import href="types.xsl"/>
<xsl:import href="special-qualities.xsl"/>
<xsl:import href="kanas.xsl"/>
<xsl:import href="lists.xsl"/>
<xsl:variable name="attributes" select="document('attributes.xml')/*/*"/>
<xsl:variable name="roots" select="document('roots.xml')/*/*"/>
<xsl:variable name="stress-explosions" select="document('stress-explosions.xml')/*/*"/>
<xsl:variable name="weapons" select="document('weapons.xml')/*/*"/>
<xsl:variable name="powers" select="document('powers.xml')/*/*"/>

<xsl:template match="/*">
<xsl:call-template name="use-colors"/>
<xsl:call-template name="use-types"/>
<xsl:call-template name="use-special-qualities"/>
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
				<th>Clothes Color</th>
				<xsl:call-template name="color"/>
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
				<th>Maid Roots</th>
				<td><select><xsl:for-each select="$roots"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
				<td><input type="button" value="Roll" onclick="roll_select(this)"/></td>
			</tr>
			<tr>
				<th>Stress Explosion!</th>
				<td><select><xsl:for-each select="$stress-explosions"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
				<td><input type="button" value="Roll" onclick="roll_select(this)"/></td>
			</tr>
		</tbody>
		<tbody id="types">
			<tr>
				<th>Maid Types</th>
				<xsl:call-template name="list"/>
			</tr>
		</tbody>
		<tbody class="hidden">
			<tr>
				<td/>
				<td><select onchange="update_types()"><xsl:for-each select="$types"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
				<td>
					<input type="button" value="Roll" onclick="roll_select(this)"/>
					<input type="button" value="−" onclick="remove(this)"/>
				</td>
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
					<td>
						<input id="{generate-id(.)}" name="max" type="radio" value="count(preceding::attribute)" onchange="update_powers()"/>
						<label for="{generate-id(.)}"><xsl:value-of select="@name"/></label>
					</td>
					<td>
						<input type="text" onchange="update_attributes()"/>
						<xsl:text> + </xsl:text>
						<input disabled="disabled" type="text"/>
						<xsl:text> = </xsl:text>
						<input disabled="disabled" type="text"/>
					</td>
					<td><input type="button" value="Roll" onclick="roll_attribute(this)"/></td>
				</tr>
			</xsl:for-each>
		</tbody>
		<tbody id="special-qualities">
			<tr>
				<th>Special Qualities</th>
				<xsl:call-template name="list"/>
			</tr>
		</tbody>
		<tbody class="hidden">
			<tr>
				<td/>
				<td><select><xsl:apply-templates mode="form" select="$special-qualities"/></select></td>
				<td>
					<input type="button" value="Roll" onclick="roll_special_quality(this)"/>
					<input type="button" value="−" onclick="remove(this)"/>
				</td>
			</tr>
		</tbody>
		<tbody id="weapons">
			<tr>
				<th>Maid Weapons</th>
				<xsl:call-template name="list"/>
			</tr>
		</tbody>
		<tbody class="hidden">
			<tr>
				<td/>
				<td><select><xsl:for-each select="$weapons"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
				<td>
					<input type="button" value="Roll" onclick="roll_select(this)"/>
					<input type="button" value="−" onclick="remove(this)"/>
				</td>
			</tr>
		</tbody>
		<tbody id="powers">
			<tr>
				<th>Maid Power</th>
				<td/>
				<td>
					<input type="button" value="Roll" onclick="roll_all(this)"/>
					<input type="button" value="+" onclick="append_power(this)"/>
				</td>
			</tr>
		</tbody>
		<tbody class="hidden">
			<xsl:for-each select="$attributes">
				<xsl:variable name="attribute" select="@attribute"/>
				<tr>
					<td/>
					<td><select><xsl:for-each select="$powers[@attribute = $attribute]"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
					<td>
						<input type="button" value="Roll" onclick="roll_select(this)"/>
						<input type="button" value="−" onclick="remove(this)"/>
					</td>
				</tr>
			</xsl:for-each>
		</tbody>
	</table>
</form>
<script src="character-creation.js" type="application/javascript"/>
</xsl:template>

<xsl:template match="special-quality" mode="form">
<xsl:choose>
	<xsl:when test="*"><optgroup label="{@name}" title="{@description}"><xsl:apply-templates mode="form"/></optgroup></xsl:when>
	<xsl:otherwise><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>