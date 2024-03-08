<?xml version="1.0"?>
<!--copied from the import feature I just need it to but it is not my feature-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <xsl:template match="/">
        <html>
            <head>
                <title>Upload for visualisation</title>
                <link rel="stylesheet" type="text/css" href="theme.css" />
            </head>
            <body>
                <h1>Upload for visualisation</h1>
                <a href="index.xml" class="home-link">
                    <small>Home</small>
                </a>

                <div class="content" id="content">
                    <div>
                        <p>
                            <i>Upload data to be visualised</i>
                        </p>
                        <form action="/vis" method="post" class="request-form">
                            <input type="file" id="xmlFileInput" accept=".xml" />
                            <button type="button" id="addPlant">Add</button>
                            <div class="message" id="successMessage"></div>
                            <div class="message" id="errorMessage"></div>
                        </form>
                        <script src="CalculatorVisualisation/calcvis.js" type="text/javascript"></script>

                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
