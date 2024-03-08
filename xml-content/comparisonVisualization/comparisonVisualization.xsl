<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <xsl:template match="/">
        <html>
            <head>
                <title>Visualization</title>
                <link rel="stylesheet" type="text/css" href="theme.css" />
            </head>
            <body>


                <!-- Title and nav  -->

                <h1>Visualization</h1>
                <a href="index.xml" class="home-link">
                    <small>Home</small>
                </a>

                <div style="margin: auto; width: 1100px;">
                    <xsl:apply-templates select="/energie-data/energie-plant">
                    </xsl:apply-templates>
                </div>

            </body>
        </html>
    </xsl:template>


    <!-- Global variables -->
    <xsl:variable name="baseline" select="350" />

    <xsl:template match="price">
        <xsl:param name="plant_index" />
        <xsl:variable name="x-per-step" select="1000 div count(../price)" />
        <xsl:if test="position() mod 10 = 0">
            <path d="M 0{position() div 2 * $x-per-step + 50 - $x-per-step * 6} 0{./preceding-sibling::price[5] * -20 + $baseline} L 0{position() div 2 * $x-per-step + 50} 0{. * -20 + $baseline}" style="stroke: red; stroke-width: 2" />
        </xsl:if>
    </xsl:template>

    <!-- stats header -->
    <xsl:template match="plant">
        <h1 style="margin-top: 30px;">
            <xsl:value-of select="name" />
        </h1>
        <svg width="1100" height="{$baseline + 30}"
            xmlns="http://www.w3.org/2000/svg">
            <rect x="0" y="0" width="1100" height="{$baseline + 30}" style="fill: #303030" />
            <path d="M 0 {$baseline - 1  } L 1100 {$baseline - 1  }" style="stroke: #505050; stroke-width: 2" />
            <path d="M 0 {$baseline - 100} L 1100 {$baseline - 100}" style="stroke: #505050; stroke-width: 2" />
            <path d="M 0 {$baseline - 200} L 1100 {$baseline - 200}" style="stroke: #505050; stroke-width: 2" />
            <path d="M 0 {$baseline - 300} L 1100 {$baseline - 300}" style="stroke: #505050; stroke-width: 2" />
            <path d="M 50 0 L 50 {$baseline}" style="stroke: #505050; stroke-width: 2" />
            <path d="M 1050 0 L 1050 {$baseline}" style="stroke: #505050; stroke-width: 2" />
            <xsl:apply-templates select="statistics">
                <xsl:with-param name="plant_index" select="position()" />
            </xsl:apply-templates>
            <text x="5" y="{$baseline - 310}" fill="white">300</text>
            <text x="5" y="{$baseline - 210}" fill="white">200</text>
            <text x="5" y="{$baseline - 110}" fill="white">100</text>
            <text x="5" y="{$baseline -  10}" fill="white">0</text>
            <text x="50" y="{$baseline + 20}" text-anchor="middle" fill="white">
                <xsl:value-of select="statistics/price[1]/@date" />
            </text>
            <text x="1050" y="{$baseline + 20}" text-anchor="middle" fill="white">
                <xsl:value-of select="statistics/price[last()]/@date" />
            </text>
        </svg>
    </xsl:template>


</xsl:stylesheet>
