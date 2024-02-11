<?xml version="1.0" ?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template match="/energie-data">
        <html>
            <head>
                <title>Xtended Market Logger</title>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>

                <h1>Ortschaftenvergleich - Resultat</h1>
                <h3>
                    <span> from </span>
                    <xsl:value-of select="//plant[1]//price[1]/@date"/>
                    <span> to </span>
                    <xsl:value-of select="//plant[1]//price[last()]/@date"/>
                    <span>
                        <span> (</span>
                        <xsl:value-of select="count(//plant[1]//price)"/>
                        <span> days) </span>
                    </span>
                </h3>
                <small>
                    <a href="index.xml">Home</a>
                </small>

                <div class="content">
                    <xsl:apply-templates select="//plant">
                        <xsl:sort select="sum(statistics/price) div count(statistics/price)" data-type="number"/>
                    </xsl:apply-templates>
                </div>
            </body>
        </html>
    </xsl:template>


    <xsl:template match="plant">
        <xsl:variable name="prices" select="statistics/price"/>
        <xsl:variable name="name" select="name"/>
        <h2>
            <xsl:value-of select="$name"/>
        </h2>
        <div>
            <span>Average Price: </span>
            <xsl:value-of select="format-number(sum($prices) div count($prices), '#.##')"/>
        </div>
        <div>
            <span>Most Expensive Day: </span>
            <xsl:call-template name="getFirstWithSorting">
                <xsl:with-param name="plantName" select="$name"/>
                <xsl:with-param name="sorting" select="'descending'"/>
            </xsl:call-template>
        </div>
        <div>
            <span>Cheapest Day: </span>
            <xsl:call-template name="getFirstWithSorting">
                <xsl:with-param name="plantName" select="$name"/>
                <xsl:with-param name="sorting" select="'ascending'"/>
            </xsl:call-template>
        </div>
    </xsl:template>

    <xsl:template name="getFirstWithSorting">
        <xsl:param name="plantName"/>
        <xsl:param name="sorting"/>
        <xsl:for-each select="//plant[name = $plantName]//price">
            <xsl:sort select="." data-type="number" order="{$sorting}"/>
            <xsl:if test="position() = 1">
                <xsl:value-of select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
