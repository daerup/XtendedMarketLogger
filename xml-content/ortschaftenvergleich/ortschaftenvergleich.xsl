<?xml version="1.0" ?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template name="getFirstWithSorting">
        <xsl:param name="sorting"/>
        <xsl:for-each select="document('../database/database.xml')//@date">
            <xsl:sort select="." data-type="text" order="{$sorting}"/>
            <xsl:if test="position() = 1">
                <xsl:value-of select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="feature">
        <xsl:variable name="firstDate">
            <xsl:call-template name="getFirstWithSorting">
                <xsl:with-param name="sorting" select="'ascending'"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="lastDate">
            <xsl:call-template name="getFirstWithSorting">
                <xsl:with-param name="sorting" select="'descending'"/>
            </xsl:call-template>
        </xsl:variable>

        <html>
            <head>
                <title>Xtended Market Logger</title>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>
                <h1>Ortschaftenvergleich</h1>
                <small>
                    <a href="index.xml">Home</a>
                </small>

                <div class="content">
                    <div>
                        <p>
                            <i>Compare plants accross timeframe</i>
                        </p>
                        <div>
                            <label for="start-">Start of Timeframe:</label>
                            <input type="date" id="start" name="start" value="2022-12-15" min="{$firstDate}" max="{$lastDate}"/>
                        </div>
                        <div>
                            <label for="end">End of Timeframe:</label>
                            <input type="date" id="end" name="end" value="{$lastDate}" min="{$firstDate}" max="{$lastDate}"/>
                        </div>
                        <button id="compare">Compare</button>
                    </div>
                </div>
                <script src="ortschaftenvergleich/comparison.js" type="text/javascript"></script>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
