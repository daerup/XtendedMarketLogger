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

                <h1>Feature #04</h1>
                <a href="index.xml" class="home-link">
                    <small>Home</small>
                </a>
                <div class="content">

                    <div>
                        <p>
                            <i>Let's add some price data:</i>
                        </p>

                        <!-- Form -->
                        <form action="/updateData" method="post" class="request-form">
                            <div>
                                <label for="plant-input">Plant</label>
                                <select name="plant" id="plant-input" required="">
                                    <option selected="" disabled="" value="">-- select Plant --</option>
                                    <xsl:apply-templates select="document('../database/database.xml')/energie-data/energie-plant/plant"/>
                                </select>
                            </div>
                            <div>
                                <label for="date-input">New date</label>
                                <input type="date" name="date" required="" onfocus="this.showPicker()"/>
                            </div>
                            <div>
                                <label for="price-input">New price</label>
                                <input type="text" name="price" id="price-input" placeholder="new price" required=""/>
                            </div>

                            <button type="submit">Insert</button>
                        </form>

                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="plant">
        <option>
            <xsl:value-of select="name"/>
        </option>
    </xsl:template>

</xsl:stylesheet>
