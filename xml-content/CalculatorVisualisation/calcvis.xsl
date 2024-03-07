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
                <svg width="100" height="100" xmlns="http://www.w3.org/2000/svg">
                    <rect x="10" y="10" width="80" height="80" style="fill: blue" />
                    <path d="M 10 10 L 90 90" style="stroke: red; stroke-width: 3" />
                </svg>

                <xsl:apply-templates select="/energie-data/energie-plant">
                </xsl:apply-templates>

            </body>
        </html>
    </xsl:template>


    <!-- Global variables -->
    <xsl:variable name="baseline" select="200" />

    <!-- stats header -->
    <xsl:template match="plant">
        <p>
            <xsl:value-of select="name" />
        </p>
        <p>
        <xsl:value-of select="position() div 2" />
        </p>
        <p>
            <xsl:value-of select="count(/energie-data/energie-plant/*)" />
        </p>

    </xsl:template>


    <!-- stats bars  -->


    <!-- logo template -->
    <xsl:template name="logo">
        <svg:svg width="600" height="300">

            <svg:defs>
                <svg:pattern id="img" patternUnits="userSpaceOnUse" width="150" height="50">
                    <svg:image
                        xlink:href="https://www.hslu.ch/-/media/campus/common/images/header/hslu-logo-hslu.svg"
                        width="100" height="50" x="0" y="0" />
                </svg:pattern>
            </svg:defs>

            <svg:ellipse cx="100" cy="100" rx="100" ry="75" fill="url(#img)" stroke="1" />

        </svg:svg>
    </xsl:template>

</xsl:stylesheet>
