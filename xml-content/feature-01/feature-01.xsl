<?xml version="1.0" ?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template match="feature">
        <html>
            <head>
                <title>Xtended Market Logger</title>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>


                <!-- title and nav  -->
                <h1>Feature #01</h1>
                <a href="index.xml" class="home-link">
                    <small>Home</small>
                </a>

                <div id="feature-1" class="content">
                    <i>Let's access some data</i>
                    <!-- load data from DB and render  -->
                    <h2>Our energie plants:</h2>
                    <div>
                        <xsl:apply-templates select="document('../database/database.xml')/energie-data/energie-plant">
                        </xsl:apply-templates>
                    </div>
                </div>

            </body>
        </html>
    </xsl:template>

    <xsl:template match="plant">
        <h1 class="card">
            <xsl:value-of select="name"/>
        </h1>
    </xsl:template>

</xsl:stylesheet>
