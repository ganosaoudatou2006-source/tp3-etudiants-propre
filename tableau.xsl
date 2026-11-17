<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8"/>
  <xsl:param name="seuil" select="10"/>

  <xsl:template match="/">
  <html>
    <head>
      <link rel="stylesheet" type="text/css" href="style.css"/>
      <style>tr.major td { background-color: #fff3b0 !important; font-weight: bold !important; }</style>
    </head>
    <body>
      <h2>Liste des etudiants</h2>
      <table border="1">
        <tr>
          <th>Rang</th>
          <th>Matricule</th>
          <th>Nom</th>
          <th>Prenom</th>
          <th>Classe</th>
          <th>Email</th>
          <th>XML</th>
          <th>XSD</th>
          <th>XPath</th>
          <th>Moyenne</th>
          <th>Resultat</th>
        </tr>
      <xsl:apply-templates select="promotion/etudiant[@classe='L1-A']">
  <xsl:sort select="sum(notes/note) div count(notes/note)" data-type="number" order="descending" />
</xsl:apply-templates>

<xsl:apply-templates select="promotion/etudiant[@classe='L1-B']">
  <xsl:sort select="sum(notes/note) div count(notes/note)" data-type="number" order="descending" />
</xsl:apply-templates>
      </table> 
<p>Total : <xsl:value-of select="count(promotion/etudiant)"/></p>
<p>Admis : <xsl:value-of select="count(promotion/etudiant[sum(notes/note) div count(notes/note) &gt;= 10])"/></p>
<p>Moyenne generale : <xsl:value-of select="format-number(sum(promotion/etudiant/notes/note) div count(promotion/etudiant/notes/note), '0.00')"/></p>
<p>Non renseigne : <xsl:value-of select="count(promotion/etudiant[count(notes/note) &lt; 3])"/></p>
    </body>
</html>
  </xsl:template>
  <xsl:template match="etudiant">
   
    <tr>
  <xsl:if test="position() = 1">
    <xsl:attribute name="class">major</xsl:attribute>
  </xsl:if>
  <xsl:if test="position() = 1">
<xsl:attribute name="class">major</xsl:attribute>
</xsl:if> 

<td><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="@matricule"/></td>
      <td><xsl:value-of select="nom"/></td>
      <td><xsl:value-of select="prenom"/></td>
      <td><xsl:value-of select="@classe"/></td>
      <td><xsl:value-of select="email"/></td>
      <td><xsl:value-of select="notes/note[@matiere='XML']"/></td>
      <td><xsl:value-of select="notes/note[@matiere='XSD']"/></td>
      <td><xsl:value-of select="notes/note[@matiere='XPath']"/></td>
      <td>
        <xsl:choose>
          <xsl:when test="count(notes/note[string-length(normalize-space(.)) &gt; 0]) &lt; 3">
            non renseigné
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="format-number((notes/note[@matiere='XML'] + notes/note[@matiere='XSD'] + notes/note[@matiere='XPath']) div 3, '0.00')"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="count(notes/note[string-length(normalize-space(.)) &gt; 0]) &lt; 3">
            non renseigné
          </xsl:when>
          <xsl:when test="(notes/note[@matiere='XML'] + notes/note[@matiere='XSD'] + notes/note[@matiere='XPath']) div 3 &gt;= $seuil">
            Admis
          </xsl:when>
          <xsl:otherwise>Ajourné</xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>