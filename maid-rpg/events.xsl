<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="common.xsl"/>
<xsl:variable name="events" select="document('events.xml')/*/*"/>

<xsl:template match="/*">
<form onsubmit="return roll_event(this)" onreset="return clear_events(this)">
	<xsl:apply-templates/>
	<input type="submit"/>
	<input type="reset"/>
</form>
<p><br/></p>
<script src="events.js" type="application/javascript"/>
</xsl:template>

<xsl:template match="group">
<fieldset>
	<legend><xsl:value-of select="@name"/></legend>
	<xsl:apply-templates/>
</fieldset>
</xsl:template>

<xsl:template match="event-set">
<div class="event">
	<xsl:value-of select="@name"/>
	<input type="text" value="0"/>
	<select class="hidden">
		<xsl:variable name="type" select="@type"/>
		<xsl:variable name="mood" select="@mood"/>
		<xsl:variable name="world" select="@world"/>
		<xsl:for-each select="$events[@type = $type or @mood = $mood or @world = $world]"><option><xsl:value-of select="@description"/></option></xsl:for-each>
	</select>
</div>
</xsl:template>

</xsl:stylesheet>
