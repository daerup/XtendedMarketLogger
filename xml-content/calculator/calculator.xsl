<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

  <xsl:output method="html" indent="yes" />

  <xsl:template match="/">
    <html>
      <head>
        <title>Power Usage Calculator</title>
        <link rel="stylesheet" type="text/css" href="theme.css" />
      </head>
      <body>
        <h1>Power Usage Calculator</h1>
        <a href="index.xml" class="home-link">
          <small>Home</small>
        </a>

        <div class="content">
          <div>
            <p>
              <i>Add a new device to the calculation</i>
            </p>
            <div class="request-form">
              <div>
                <label for="start">Device:</label>
                <input type="text" id="name" />
              </div>
              <div>
                <label for="end">Runtime per day (h):</label>
                <input type="number" id="runtime" />
              </div>
              <div>
                <label for="end">Power usage (W):</label>
                <input type="number" id="power" />
              </div>
              <button id="add">Add</button>
              <button id="createPDF">Download PDF</button>
              <button id="createXML">Download XML</button>
              <a id="dummyPDF"></a>
              <a id="dummyXML"></a>
            </div>
          </div>
          <h2>Devicelist</h2>
          <table id="deviceTable">
            <tr>
              <th>Device</th>
              <th>Daily runtime (h)</th>
              <th>Power usage (kWh)</th>
              <th>Total power usage (kWh)</th>
            </tr>
          </table>
        </div>
        <script src="calculator/calculator.js"></script>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
