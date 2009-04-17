<?xml version="1.0"?>

<!-- renders the JPivot Table -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- the id of the table for httpUnit -->
<xsl:output method="html" indent="no" encoding="utf-8"/>
<xsl:param name="context"/>
<xsl:param name="renderId"/>
<xsl:param name="token"/>
<xsl:param name="imgpath" select="'jpivot/table'"/>

<!-- Tabelle:  -->
<xsl:param name="maxColHdrLen" select="20"/>


<xsl:template match="mdxtable">
  <xsl:if test="@message">
    <div class="table-message"><xsl:value-of select="@message"/></div>
  </xsl:if>
  <table border="1" cellspacing="0" cellpadding="2" id="{$renderId}">
    <xsl:apply-templates select="head"/>
    <xsl:apply-templates select="body"/>
  </table>
</xsl:template>

<xsl:template match="head | body">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="row">
  <tr>
    <xsl:apply-templates/>
  </tr>
</xsl:template>


<xsl:template match="corner">
  <th nowrap="nowrap" class="corner-heading" colspan="{@colspan}" rowspan="{@rowspan}">
    <xsl:apply-templates/>
    <!-- &#160; == &nbsp; -->
    <xsl:text>&#160;</xsl:text>
  </th>
</xsl:template>


<xsl:template match="column-heading[@indent]">
  <th class="column-heading-{@style}" colspan="{@colspan}" rowspan="{@rowspan}">
    <xsl:call-template name="nowrap"/>
    <div style="margin-top: {@indent}em">
      <xsl:apply-templates/>
    </div>
  </th>
</xsl:template>


<xsl:template match="row-heading[@indent]">
  <th nowrap="nowrap" class="row-heading-{@style}" colspan="{@colspan}" rowspan="{@rowspan}">
    <div style="margin-left: {@indent}em">
      <xsl:apply-templates/>
    </div>
  </th>
</xsl:template>


<xsl:template match="column-heading">
  <th class="column-heading-{@style}" colspan="{@colspan}" rowspan="{@rowspan}">
    <xsl:call-template name="nowrap"/>
    <xsl:apply-templates/>
  </th>
</xsl:template>


<xsl:template match="row-heading">
  <th nowrap="nowrap" class="row-heading-{@style}" colspan="{@colspan}" rowspan="{@rowspan}">
    <xsl:apply-templates/>
  </th>
</xsl:template>


<xsl:template match="heading-heading">
  <th nowrap="nowrap" class="heading-heading" colspan="{@colspan}" rowspan="{@rowspan}">
    <xsl:apply-templates/>
  </th>
</xsl:template>



<xsl:template match="caption">
  <xsl:call-template name="render-label">
    <xsl:with-param name="label">
      <xsl:value-of select="@caption"/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>


<!-- navigation: expand / collapse / leaf node -->
<xsl:template match="drill-expand | drill-collapse">
  <input type="image" title="{@title}" name="{@id}" src="{$context}/{$imgpath}/{@img}.gif" />
</xsl:template>

<xsl:template match="drill-other">
  <img src="{$context}/{$imgpath}/{@img}.gif" border="0" width="9" height="9"/>
</xsl:template>

<!-- navigation: sort -->
<xsl:template match="sort">
  <input name="{@id}" title="{@title}" type="image" src="{$context}/{$imgpath}/{@mode}.gif" />
</xsl:template>

<xsl:template match="drill-through">
  <input name="{@id}" title="{@title}" type="image" src="{$context}/{$imgpath}/drill-through.gif" />
</xsl:template>


<xsl:template match="cell">
  <td nowrap="nowrap" class="cell-{@style}">
    <xsl:apply-templates select="drill-through"/>
    <xsl:call-template name="render-label">
      <xsl:with-param name="label">
        <xsl:value-of select="@value"/>
      </xsl:with-param>
    </xsl:call-template>
  </td>
</xsl:template>

<xsl:template match="cellspan">
  <td colspan="{@colspan}" style="color:red" >
    <xsl:call-template name="render-label">
      <xsl:with-param name="label">
        <xsl:value-of select="@value"/>
      </xsl:with-param>
    </xsl:call-template>
  </td>
</xsl:template>

<xsl:template name="render-label">
  <xsl:param name="label"/>
  <xsl:choose>
    <!-- clickable member -->
    <xsl:when test="@href">
      <a>
        <xsl:call-template name="make-href">
          <xsl:with-param name="href" select="@href"/>
        </xsl:call-template>
        <xsl:value-of select="$label"/>
        <xsl:apply-templates select="property"/>
      </a>
    </xsl:when>
    <!-- member property -->
    <xsl:when test="property[@name='link']">
      <a target="_blank">
        <xsl:call-template name="make-href">
          <xsl:with-param name="href" select="property[@name='link']/@value"/>
        </xsl:call-template>
        <xsl:value-of select="$label"/>
        <xsl:apply-templates select="property"/>
      </a>
    </xsl:when>
    <!-- default -->
    <xsl:otherwise>
      <xsl:value-of select="$label"/>
      <xsl:apply-templates select="property"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template name="make-href">
  <xsl:param name="href"/>
  <xsl:choose>
    <xsl:when test="starts-with($href, '/')">
      <xsl:attribute name="href">
        <xsl:value-of select="concat($context, $href)"/>
      </xsl:attribute>
    </xsl:when>
    <xsl:otherwise>
      <xsl:attribute name="href">
        <xsl:value-of select="$href"/>
      </xsl:attribute>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="nowrap">
  <xsl:if test="string-length(string(caption/@caption))&lt;$maxColHdrLen">
    <xsl:attribute name="nowrap">nowrap</xsl:attribute>
  </xsl:if>
</xsl:template>


<xsl:template match="property[@name='arrow']">
  <span style="margin-left: 0.5ex">
    <img border="0" src="{$context}/{$imgpath}/arrow-{@value}.gif" width="10" height="10"/>
  </span>
</xsl:template>

<xsl:template match="property[@name='image']">
  <span style="margin-left: 0.5ex">
    <xsl:choose>
      <xsl:when test="starts-with(@value, '/')">
        <img border="0" src="{$context}{@value}"/>
      </xsl:when>
      <xsl:otherwise>
        <img border="0" src="{@value}"/>
      </xsl:otherwise>
    </xsl:choose>
  </span>
</xsl:template>

<xsl:template match="property[@name='cyberfilter']">
  <span style="margin-left: 0.5ex">
    <img align="middle" src="{$context}/{$imgpath}/filter-{@value}.gif" width="51" height="12"/>
  </span>
</xsl:template>

<!-- ignore other properties (e.g. "link") -->
<xsl:template match="property"/>


<xsl:template match="*|@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|node()"/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
