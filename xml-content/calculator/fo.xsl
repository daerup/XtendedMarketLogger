<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:template match="/">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4" page-height="29.7cm" page-width="21cm" margin="2cm">
          <fo:region-body margin-top="1cm" margin-bottom="2cm" />
          <fo:region-before extent="2cm" />
        </fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence master-reference="A4">
        <fo:static-content flow-name="xsl-region-before">
          <fo:block text-align="center" font-size="8pt"> XtendedMarketLogger - Calculator - Page <fo:page-number />
          </fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <fo:block font-size="24pt" text-align="center" margin-bottom="1cm">
            <fo:inline font-weight="bold">Your personal power usage calculator</fo:inline>
          </fo:block>
          <fo:block font-size="12pt">
            <fo:table>
              <fo:table-column column-width="auto" />
              <fo:table-column column-width="auto" />
              <fo:table-column column-width="auto" />
              <fo:table-header>
                <fo:table-row>
                  <fo:table-cell>
                    <fo:block font-weight="bold">Device</fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block font-weight="bold">Runtime (h)</fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block font-weight="bold">Power usage (kWh)</fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-header>
              <fo:table-body>
                <xsl:apply-templates select="//device" />
              </fo:table-body>
            </fo:table>
          </fo:block>
          <fo:block font-size="12pt" text-align="right" margin-top="1cm">
            <fo:inline font-weight="bold">Total daily power usage: </fo:inline>
            <xsl:variable name="totalPower" select="sum(//device/power)" />
            <xsl:value-of select="format-number($totalPower, '0.00')" />
            <xsl:text> kWh</xsl:text>
          </fo:block>
          <fo:block font-size="12pt" text-align="right" margin-top="1cm">
            <fo:inline font-weight="bold">Total yearly power usage: </fo:inline>
            <xsl:variable name="totalPower" select="sum(//device/power) * 365" />
            <xsl:value-of select="format-number($totalPower, '0.00')" />
            <xsl:text> kWh</xsl:text>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="device">
    <fo:table-row>
      <fo:table-cell>
        <fo:block>
          <xsl:value-of select="name" />
        </fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block>
          <xsl:value-of select="runtime" />
        </fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block>
          <xsl:value-of select="power" />
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

</xsl:stylesheet>
