<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:strip-space elements="*"/>
<xsl:output doctype-public="-//W3C//DTD HTML 4.01//EN" doctype-system="http://www.w3.org/TR/html4/strict.dtd" encoding="UTF-8" media-type="text/html" method="html"/>
<xsl:template match="/">
<html>
	<head>
		<title>Maid - The Role-Playing Game</title>
		<link href="common.css" rel="stylesheet" type="text/css"/>
		<script src="common.js" type="application/javascript"/>
	</head>
	<body><xsl:apply-templates/></body>
</html>
</xsl:template>
</xsl:stylesheet>
