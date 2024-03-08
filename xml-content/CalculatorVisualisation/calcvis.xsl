<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <xsl:template match="/">
        <html>
            <head>
                <title>Vis</title>
                <link rel="stylesheet" type="text/css" href="theme.css" />
            </head>
            <body>


                <!-- Title and nav  -->

                <h1>Vis</h1>
                <a href="index.xml" class="home-link">
                    <small>Home</small>
                </a>

                <div class="content card">

                    <div>
                        <p>
                            <i>Here's a logo and some data visualization:</i>
                        </p>

                        <!-- include logo  -->
                        <!--<xsl:call-template
                        name="logo">-->
                        <!--</xsl:call-template>-->

                        <!-- include statistics visualization  -->

                    </div>

                </div>
                <svg width="1000" height="1000" xmlns="http://www.w3.org/2000/svg">
                    <rect x="10" y="10" width="080" height="80" style="fill: blue" />
                    <path d="M 10 10 L 100 100" style="stroke: red; stroke-width: 3" />
                    <xsl:apply-templates select="/energie-data/energie-plant">
                    </xsl:apply-templates>
                </svg>

                <!--<xsl:apply-templates select="/energie-data/energie-plant">-->
                <!--</xsl:apply-templates>-->

            </body>
        </html>
    </xsl:template>


    <!-- Global variables -->
    <xsl:variable name="baseline" select="200" />

    <!--<xsl:template match="plant">-->
    <!--</xsl:template>-->

    <xsl:template match="price">
     <xsl:if test="position() mod 10 = 0">
     <path d="M 0{position() div 2 - 5} 0{./preceding-sibling::price[5] * 20} L 0{position() div 2} 0{. * 20}" style="stroke: red; stroke-width: 2" />
    </xsl:if>
    </xsl:template>

    <!-- stats header -->
    <xsl:template match="plant">
    <xsl:apply-templates select="/energie-data/energie-plant/plant[position()]/statistics">
        </xsl:apply-templates>
        <h2>
        <xsl:value-of select="name" />
        </h2>
    </xsl:template>





</xsl:stylesheet>
