<?xml version="1.0" ?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template match="about">
        <html>
            <head>
                <title>Xtended Market Logger</title>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>

                <h1>About</h1>
                <a href="index.xml" class="home-link">
                    <small>Home</small>
                </a>
                <div id="about">
                    <div class="about-original card">
                        <h2>Energiewerke Mittelland Reloaded</h2>
                        <small>original</small>
                        <xsl:apply-templates select="original"/>
                    </div>

                    <div class="about-original card">
                        <h2>Xtended Market Logger</h2>
                        <small>fork</small>
                        <xsl:apply-templates select="fork"/>
                    </div>
                </div>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="*">
        <xsl:variable name="source" select="source"/>
        <span>
            <a href="{$source}" target="_blank">Source</a>
        </span>
        <b>Version</b>
        <div>
            <xsl:value-of select="version"/>
        </div>
        <br/>
        <b>Date</b>
        <div>
            <xsl:value-of select="date"/>
        </div>
        <br/>
        <b>Author(s)</b>
        <div>
            <xsl:apply-templates select="authors/author"/>
        </div>
    </xsl:template>

    <xsl:template match="author">
        <div class="author">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>

</xsl:stylesheet>
