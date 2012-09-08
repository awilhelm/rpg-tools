<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="common.xsl"/>
<xsl:import href="colors.xsl"/>
<xsl:import href="lists.xsl"/>
<xsl:variable name="worlds" select="document('worlds.xml')/*/*"/>
<xsl:variable name="moods" select="document('moods.xml')/*/*"/>
<xsl:variable name="special-facilities" select="document('special-facilities.xml')/*/*"/>
<xsl:variable name="appearances" select="document('appearances.xml')/*/*"/>

<xsl:template match="/*">
<xsl:call-template name="use-colors"/>
<xsl:call-template name="use-lists"/>
<form>
	<table>
		<tbody id="misc">
			<tr>
				<th>World</th>
				<td id="world"><select onchange="update_world(this)"><xsl:for-each select="$worlds"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
				<td><input type="button" value="Roll" onclick="roll_select(this)"/></td>
			</tr>
			<tr>
				<th>Mood</th>
				<td><select><xsl:for-each select="$moods"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
				<td><input type="button" value="Roll" onclick="roll_select(this)"/></td>
			</tr>
			<tr>
				<th>Mansion Appearance</th>
				<td id="appearance">
					<xsl:for-each select="$worlds">
						<xsl:variable name="world" select="@world"/>
						<select><xsl:for-each select="$appearances[@world = $world]"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select>
					</xsl:for-each>
				</td>
				<td><input type="button" value="Roll" onclick="roll_appearance(this)"/></td>
			</tr>
			<tr>
				<th>Primary Color</th>
				<xsl:call-template name="color"/>
			</tr>
			<tr>
				<th>Secondary Color</th>
				<xsl:call-template name="color"/>
			</tr>
		</tbody>
		<tbody id="special-facilities">
			<tr>
				<th>Special Facilities</th>
				<xsl:call-template name="list"/>
			</tr>
		</tbody>
		<tbody class="hidden">
			<tr>
				<td/>
				<td><select><xsl:for-each select="$special-facilities"><option title="{@description}"><xsl:value-of select="@name"/></option></xsl:for-each></select></td>
				<td>
					<input type="button" value="Roll" onclick="roll_select(this)"/>
					<input type="button" value="−" onclick="remove(this)"/>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<script src="mansion-creation.js" type="application/javascript"/>
</xsl:template>

</xsl:stylesheet>
