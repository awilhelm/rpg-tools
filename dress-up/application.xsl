<stylesheet version="1.0" xmlns="http://www.w3.org/1999/XSL/Transform">
	<strip-space elements="*"/>
	<template match="/*">
		<html xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
			<head>
				<title>Chibi Dress-up</title>
				<link href="style.css" rel="stylesheet" type="text/css"/>
				<script src="script.js" type="application/javascript"/>
				<script type="application/javascript">
					<xsl:call-template name="script"/>
				</script>
				<style type="text/css">
					<xsl:call-template name="style"/>
				</style>
			</head>
			<body id="form" onload="update()">
				<div class="preview">
					<xsl:call-template name="layers"/>
				</div>
				<table>
					<xsl:for-each select="params/*">
						<tr class="{@class}">
							<xsl:call-template name="params">
								<xsl:with-param name="param" select="name()"/>
								<xsl:with-param name="i" select="@count - 1"/>
							</xsl:call-template>
						</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</template>
	<template name="params">
		<param name="param"/>
		<param name="i"/>
		<if test="$i > 0">
			<call-template name="params">
				<with-param name="param" select="$param"/>
				<with-param name="i" select="$i - 1"/>
			</call-template>
		</if>
		<td xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
			<a href="javascript:set('{$param}', {$i})">
				<div id="{$param}-{$i}">
					<xsl:call-template name="layers"/>
				</div>
			</a>
		</td>
	</template>
	<template name="layers">
		<for-each select="//layers/*">
			<span class="{name()}" xmlns="http://www.w3.org/1999/xhtml"/>
		</for-each>
	</template>
	<template name="script">
		<text>var options = {</text>
		<for-each select="//params/*">
			<text>'</text>
			<value-of select="name()"/>
			<text>': 0, </text>
		</for-each>
		<text>};</text>
	</template>
	<template name="style">
		<for-each select="//layers/*">
			<text>.</text>
			<value-of select="name()"/>
			<text> { background-image: url(images/</text>
			<value-of select="name()"/>
			<text>.png) }&#10;</text>
			<call-template name="style-1">
				<with-param name="layer" select="name()"/>
				<with-param name="params" select="*"/>
			</call-template>
		</for-each>
	</template>
	<template name="style-1">
		<param name="layer"/>
		<param name="params"/>
		<param name="global"/>
		<param name="local"/>
		<param name="u" select="0"/>
		<param name="v" select="0"/>
		<variable name="count" select="//params/*[name() = name($params[1])]/@count"/>
		<choose>
			<when test="$count">
				<call-template name="style-2">
					<with-param name="layer" select="$layer"/>
					<with-param name="params" select="$params"/>
					<with-param name="global" select="$global"/>
					<with-param name="local" select="$local"/>
					<with-param name="count" select="$count"/>
					<with-param name="u" select="$u"/>
					<with-param name="v" select="$v"/>
					<with-param name="i" select="$count - 1"/>
				</call-template>
			</when>
			<otherwise>
				<value-of select="$global"/>
				<value-of select="$local"/>
				<text> .</text>
				<value-of select="$layer"/>
				<text> { background-position: </text>
				<value-of select="-96 * $u"/>
				<text>px </text>
				<value-of select="-128 * $v"/>
				<text>px }&#10;</text>
			</otherwise>
		</choose>
	</template>
	<template name="style-2">
		<param name="layer"/>
		<param name="params"/>
		<param name="global"/>
		<param name="local"/>
		<param name="count"/>
		<param name="u"/>
		<param name="v"/>
		<param name="i"/>
		<variable name="mod" select="count($params[1]/preceding-sibling::*) mod 2"/>
		<variable name="_u" select="($u * $count + $i) * $mod + $u * (1 - $mod)"/>
		<variable name="_v" select="($v * $count + $i) * (1 - $mod) + $v * $mod"/>
		<variable name="_params" select="$params/following-sibling::*"/>
		<variable name="_global" select="concat($global, '.', name($params[1]), '-', $i)"/>
		<variable name="_local" select="concat(' #', name($params[1]), '-', $i)"/>
		<call-template name="style-1">
			<with-param name="layer" select="$layer"/>
			<with-param name="params" select="$_params"/>
			<with-param name="global" select="$_global"/>
			<with-param name="local" select="$local"/>
			<with-param name="u" select="$_u"/>
			<with-param name="v" select="$_v"/>
		</call-template>
		<if test="not($local)">
			<call-template name="style-1">
				<with-param name="layer" select="$layer"/>
				<with-param name="params" select="$_params"/>
				<with-param name="global" select="$global"/>
				<with-param name="local" select="$_local"/>
				<with-param name="u" select="$_u"/>
				<with-param name="v" select="$_v"/>
			</call-template>
		</if>
		<if test="$i > 0">
			<call-template name="style-2">
				<with-param name="layer" select="$layer"/>
				<with-param name="params" select="$params"/>
				<with-param name="global" select="$global"/>
				<with-param name="local" select="$local"/>
				<with-param name="count" select="$count"/>
				<with-param name="u" select="$u"/>
				<with-param name="v" select="$v"/>
				<with-param name="i" select="$i - 1"/>
			</call-template>
		</if>
	</template>
</stylesheet>
