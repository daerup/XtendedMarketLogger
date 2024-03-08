<?xml version="1.0" ?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template match="menu">
        <html>
            <head>
                <title>Xtended Market Logger</title>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>

                <!-- title and nav  -->
                <h1>Welcome Xtended Market Logger</h1>

                <div class="content">
                    <!-- render menu nav  -->
                    <div id="dashboard">
                        <xsl:apply-templates select="item">
                            <xsl:sort select="index" data-type="text" order="ascending"/>
                        </xsl:apply-templates>
                    </div>

                    <hr></hr>
                    <div class="links">
                        <a href="about.xml" target="_blank">about</a>
                        <a href="database/database.xml" target="_blank">database</a>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="item">
        <div class="dashboard-item card">
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="link"/>
                </xsl:attribute>
                <small class="tagline">
                    <xsl:call-template name="process-each-character">
                        <xsl:with-param name="text" select="tagline"/>
                    </xsl:call-template>
                </small>
                <h2>
                    <xsl:value-of select="text"/>
                </h2>
                <small>
                    <xsl:value-of select="description"/>
                </small>
                <div class="tags">
                    <xsl:apply-templates select="tags/tag"/>
                </div>
                <small class="author">
                    <xsl:value-of select="author"/>
                </small>
            </a>
        </div>
    </xsl:template>
    <xsl:template name="process-each-character">
        <xsl:param name="text"/>
        <xsl:param name="count" select="0"/>
        <xsl:if test="string-length($text) > 0">
            <span>
                <xsl:attribute name="style">
                    <xsl:text>animation-delay: </xsl:text>
                    <!-- Calculate the delay based on the count -->
                    <xsl:value-of select="format-number($count * 0.1, '#.0')">s</xsl:value-of>
                    <xsl:text>s;</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="substring($text, 1, 1)"/>
            </span>
            <xsl:call-template name="process-each-character">
                <xsl:with-param name="text" select="substring($text, 2)"/>
                <xsl:with-param name="count" select="$count + 1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tag">
        <span class="tag">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
</xsl:stylesheet>
