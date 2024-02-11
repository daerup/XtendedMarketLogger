<?xml version="1.0" ?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template match="feature">
        <html>
            <head>
                <title>Xtended Market Logger</title>
                <link rel="stylesheet" type="text/css" href="theme.css"/>
            </head>
            <body>

                <!-- Title and nav  -->

                <h1>Feature #03</h1>
                <a href="index.xml" class="home-link">
                    <small>Home</small>
                </a>
                <p>
                    <i>Let's create a printable energie statistics:</i>
                </p>

                <div id="feature-3">
                    <a href="fo.xml" target="_blank">
                        <div class="card">
                            <h1>Create FO</h1>
                            <small>(directly in browser with XSTL)</small>
                        </div>
                    </a>

                    <a href="#" onclick="createPdf()">
                        <div class="card">
                            <h1>Create PDF</h1>
                            <small>(create FO and render as PDF via web service)</small>
                        </div>
                    </a>
                    <!-- Dummy-Link for PDF-Download -->
                    <a id="dummyLink"></a>
                </div>

                <!-- Javascript-Functions for FO-Transformation -->
                <script src="feature-03/fo-functions.js" type="text/javascript"></script>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
