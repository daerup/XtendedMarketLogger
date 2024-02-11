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
                <h1>Welcome</h1>

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

    <!-- single menu item  -->
    <xsl:template match="item">
        <div class="dashboard-item card">
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="link"/>
                </xsl:attribute>
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
    <xsl:template match="tag">
        <span class="tag">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
</xsl:stylesheet>
