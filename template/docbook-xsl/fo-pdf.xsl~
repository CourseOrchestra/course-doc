<?xml version="1.0" encoding="UTF-8"?>
<!--
  Generates a FO document from a DocBook XML document using the DocBook XSL stylesheets.
  See http://docbook.sourceforge.net/release/xsl/1.78.1/doc/fo for all parameters.
-->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:common="http://www.curs.ru/docbook"
                exclude-result-prefixes="db">
	<!--
      The absolute URL imports point to system-wide locations by way of this /etc/xml/catalog entry:

        <rewriteURI
          uriStartString="http://docbook.sourceforge.net/release/xsl/current"
          rewritePrefix="file:///usr/share/sgml/docbook/xsl-stylesheets-%docbook-style-xsl-version%"/>

      %docbook-style-xsl-version% represents the version installed on the system.
    -->
	<!--<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/fo/docbook.xsl"/>-->
	<xsl:import href="../docbook/fo/docbook.xsl"/>
	<xsl:import href="common.xsl"/>
	<xsl:import href="highlight.xsl"/>
	<xsl:import href="callouts.xsl"/>

	<!-- Enable extensions for FOP version 0.90 and later -->
	<xsl:param name="fop1.extensions">1</xsl:param>

	<xsl:attribute-set name="header.content.properties">
		<xsl:attribute name="font-family">PT Serif,Cambria,DejaVu Serif</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select = "$body.font.master * 0.9"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="footer.content.properties">
		<xsl:attribute name="font-family">PT Serif,Cambria,DejaVu Serif</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select = "$body.font.master * 0.9"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>

	<!--
      AsciiDoc compat
    -->

	<xsl:template match="processing-instruction('asciidoc-br')">
		<fo:block/>
	</xsl:template>

	<xsl:template match="processing-instruction('asciidoc-hr')">
		<fo:block space-after="1em">
			<fo:leader leader-pattern="rule" rule-thickness="0.5pt" rule-style="solid" leader-length.minimum="100%"/>
		</fo:block>
	</xsl:template>

	<xsl:template match="processing-instruction('asciidoc-pagebreak')">
		<fo:block break-after='page'/>
	</xsl:template>

	<!--
      Font selectors
    -->

	<xsl:template name="pickfont-sans">
		<xsl:text>PT Sans,Calibri,DejaVu Sans</xsl:text>
	</xsl:template>

	<xsl:template name="pickfont-serif">
		<xsl:text>PT Serif,Cambria,DejaVu Serif</xsl:text>
	</xsl:template>

	<xsl:template name="pickfont-mono">
		<xsl:text>PT Serif,Courier New,Dejavu Mono</xsl:text>
	</xsl:template>

	<xsl:template name="pickfont-symbol">
		<xsl:text>Symbol</xsl:text>
	</xsl:template>

	<xsl:template name="pickfont-dingbat">
		<xsl:call-template name="pickfont-symbol"/>
	</xsl:template>


	<xsl:template name="pickfont-math">
		<xsl:text>PT Serif,Calibri,Dejavu Mono</xsl:text>
	</xsl:template>

	<!--
      Fonts
    -->

	<xsl:param name="math.font.family">
		<xsl:call-template name="pickfont-math"/>
	</xsl:param>

	<xsl:param name="body.font.family">
		<xsl:call-template name="pickfont-serif"/>
	</xsl:param>

	<xsl:param name="sans.font.family">
		<xsl:call-template name="pickfont-sans"/>
	</xsl:param>

	<xsl:param name="monospace.font.family">
		<xsl:call-template name="pickfont-mono"/>
	</xsl:param>

    <xsl:param name="dingbat.font.family">
      <xsl:call-template name="pickfont-dingbat"/>
    </xsl:param>

    <xsl:param name="symbol.font.family">
      <xsl:call-template name="pickfont-symbol"/>
    </xsl:param>

	<xsl:param name="title.font.family">
		<xsl:call-template name="pickfont-serif"/>
	</xsl:param>

	<!--
      Text properties
    -->

	<xsl:param name="hyphenate">false</xsl:param>
	<!--
    <xsl:param name="alignment">left</xsl:param>
    -->
	<xsl:param name="alignment">justify</xsl:param>
	<xsl:param name="line-height">1.2</xsl:param>
	<xsl:param name="body.font.master">12</xsl:param>
	<xsl:param name="body.font.size">
		<xsl:value-of select="$body.font.master"/>
		<xsl:text>pt</xsl:text>
	</xsl:param>

	<xsl:attribute-set name="root.properties">
		<xsl:attribute name="color">
			<xsl:value-of select="$text.color"/>
		</xsl:attribute>
	</xsl:attribute-set>

	<!-- normal.para.spacing is the only attribute set applied to all paragraphs -->
	<xsl:attribute-set name="normal.para.spacing">
		<xsl:attribute name="text-indent">0</xsl:attribute>
		<xsl:attribute name="space-before.optimum">0</xsl:attribute>
		<xsl:attribute name="space-before.minimum">0</xsl:attribute>
		<xsl:attribute name="space-before.maximum">0</xsl:attribute>
		<xsl:attribute name="space-after.optimum">0em</xsl:attribute>
		<xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
		<xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
		<!--
        <xsl:attribute name="color"><xsl:value-of select="$text.color"/></xsl:attribute>
        -->
	</xsl:attribute-set>




	<xsl:attribute-set name="monospace.properties">
		<xsl:attribute name="color">
			<xsl:value-of select="$code.color"/>
		</xsl:attribute>
		<xsl:attribute name="font-weight">
			<xsl:value-of select="$code.font-weight"/>
		</xsl:attribute>
		<!--
        <xsl:attribute name="font-size">
          <xsl:value-of select="$body.font.master * 0.9"/><xsl:text>pt</xsl:text>
        </xsl:attribute>
        -->
		<!--<xsl:attribute name="background-color">-->
		<!--<xsl:value-of select="$code.background-color"/>-->
		<!--</xsl:attribute>-->
		<!--<xsl:attribute name="padding">-->
		<!--<xsl:choose>-->
		<!--<xsl:when test="$code.background-color != 'transparent'">.3em .25em .1em .25em</xsl:when>-->
		<!--<xsl:otherwise>0</xsl:otherwise>-->
		<!--</xsl:choose>-->
		<!--</xsl:attribute>-->
		<!--<xsl:attribute name="keep-together.within-column">always</xsl:attribute>-->
		<xsl:attribute name="font-size">
			<xsl:value-of select = "$body.font.master * 0.8"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="verbatim.properties">
		<xsl:attribute name="color">
			<xsl:value-of select="$text.color"/>
		</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="border-top-style">solid</xsl:attribute>
		<xsl:attribute name="border-bottom-style">solid</xsl:attribute>
		<xsl:attribute name="border-left-style">solid</xsl:attribute>
		<xsl:attribute name="border-right-style">solid</xsl:attribute>
		<xsl:attribute name="border-width">0.5pt</xsl:attribute>
		<xsl:attribute name="border-color">#BFBFBF</xsl:attribute>
		<xsl:attribute name="background-color">#BFBFBF</xsl:attribute>
		<xsl:attribute name="space-before.minimum">0</xsl:attribute>
		<xsl:attribute name="space-before.optimum">.2em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">.4em</xsl:attribute>
		<xsl:attribute name="space-after.minimum">1em</xsl:attribute>
		<xsl:attribute name="space-after.optimum">1.2em</xsl:attribute>
		<xsl:attribute name="space-after.maximum">1.4em</xsl:attribute>
		<xsl:attribute name="hyphenate">false</xsl:attribute>
		<xsl:attribute name="wrap-option">wrap</xsl:attribute>
		<xsl:attribute name="white-space-collapse">false</xsl:attribute>
		<xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
		<xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
		<xsl:attribute name="text-align">start</xsl:attribute>
		<!--<xsl:attribute name="keep-together.within-column">always</xsl:attribute>-->
	</xsl:attribute-set>

	<xsl:attribute-set name="monospace.verbatim.properties"
                       use-attribute-sets="monospace.properties verbatim.properties">

		<!--<xsl:attribute name="keep-together.within-column">always</xsl:attribute>-->

		<xsl:attribute name="font-size">
			<xsl:value-of select = "$body.font.master * 0.7"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>

		<xsl:attribute name="text-align">start</xsl:attribute>
		<xsl:attribute name="wrap-option">wrap</xsl:attribute>
		<!--
        <xsl:attribute name="hyphenation-character">&#x25BA;</xsl:attribute>
        -->
	</xsl:attribute-set>

	<!-- shade.verbatim.style is added to listings when shade.verbatim is enabled -->
	<xsl:param name="shade.verbatim">1</xsl:param>

	<xsl:attribute-set name="shade.verbatim.style">
		<xsl:attribute name="background-color">#FBFBFB</xsl:attribute>
		<!--
        <xsl:attribute name="background-color">
          <xsl:choose>
            <xsl:when test="ancestor::db:note">
              <xsl:text>#D6DEE0</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::db:caution">
              <xsl:text>#FAF8ED</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::db:important">
              <xsl:text>#E1EEF4</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::db:warning">
              <xsl:text>#FAF8ED</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::db:tip">
              <xsl:text>#D5E1D5</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>#FFF</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        -->
		<xsl:attribute name="color">
			<xsl:value-of select="$text.color"/>
		</xsl:attribute>
		<!--
        <xsl:attribute name="color">
          <xsl:choose>
            <xsl:when test="ancestor::db:note">
              <xsl:text>#334558</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::db:caution">
              <xsl:text>#334558</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::db:important">
              <xsl:text>#334558</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::db:warning">
              <xsl:text>#334558</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::db:tip">
              <xsl:text>#334558</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>#222</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        -->
		<xsl:attribute name="padding">1em .5em .75em .5em</xsl:attribute>
		<!-- make sure block it aligns with block title -->
		<xsl:attribute name="margin-left">
			<xsl:value-of select="$title.margin.left"/>
		</xsl:attribute>
		<!--<xsl:attribute name="keep-together.within-column">always</xsl:attribute>-->
	</xsl:attribute-set>

	<!-- Text Decorations -->

	<!-- Underline and Strikethrough -->

	<xsl:template match="del">
		<fo:inline text-decoration="line-through">
			<xsl:call-template name="inline.charseq"/>
		</fo:inline>
	</xsl:template>

	<xsl:template match="u">
		<fo:inline text-decoration="underline">
			<xsl:call-template name="inline.charseq"/>
		</fo:inline>
	</xsl:template>

	<xsl:template match="phrase">
		<xsl:choose>
			<xsl:when test="@role='underline'">
				<fo:inline text-decoration="underline">
					<xsl:call-template name="inline.charseq"/>
				</fo:inline>
			</xsl:when>
			<xsl:when test="@role='line-through'">
				<fo:inline text-decoration="line-through">
					<xsl:call-template name="inline.charseq"/>
				</fo:inline>
			</xsl:when>
			<xsl:otherwise>
				<fo:inline color="{@role}">
					<xsl:apply-templates/>
				</fo:inline>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="emphasis">
		<xsl:variable name="depth">
			<xsl:call-template name="dot.count">
				<xsl:with-param name="string">
					<xsl:number level="multiple"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="@role='bold' or @role='strong'">
				<xsl:call-template name="inline.boldseq"/>
			</xsl:when>
			<xsl:when test="@role='marked'">
				<fo:inline background-color="#ff0" font-style="normal">
					<xsl:apply-templates/>
				</fo:inline>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$depth mod 2 = 1">
						<fo:inline font-style="normal">
							<xsl:apply-templates/>
						</fo:inline>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="inline.italicseq"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
      Page layout
    -->

	<xsl:param name="page.height.portrait">29.7cm</xsl:param>
	<xsl:param name="page.width.portrait">21cm</xsl:param>

	<xsl:param name="page.margin.top">1.25cm</xsl:param>
	<xsl:param name="body.margin.top">1.25cm</xsl:param>

	<xsl:param name="page.margin.bottom">1.25cm</xsl:param>
	<xsl:param name="body.margin.bottom">1cm</xsl:param>

	<xsl:param name="region.before.extent">0.5cm</xsl:param>
	<xsl:param name="region.after.extent">0.5cm</xsl:param>

	<xsl:param name="page.margin.inner">2.35cm</xsl:param>
	<xsl:param name="page.margin.outer">1.65cm</xsl:param>

	<xsl:param name="body.margin.inner">0cm</xsl:param>
	<xsl:param name="body.margin.outer">0cm</xsl:param>

	<xsl:param name="body.start.indent">0cm</xsl:param>
	<!-- text indentation -->
	<xsl:param name="body.end.indent">0cm</xsl:param>
	<xsl:param name="double.sided">0</xsl:param>

	<xsl:param name="generate.toc">
        appendix nop
        article/appendix nop
        article title
        book toc,title
        chapter nop
        part toc,title
        preface toc,title
        qandadiv toc
        qandaset toc
        reference toc,title
        sect1 toc
        sect2 toc
        sect3 toc
        sect4 toc
        sect5 toc
        section toc
        set toc,title
	</xsl:param>


	<!--
      Table of Contents
    -->
	<xsl:param name="autotoc.label.separator">.&#x2005;</xsl:param>
	<xsl:param name="bridgehead.in.toc">0</xsl:param>
	<xsl:param name="toc.section.depth">2</xsl:param>

	<xsl:template name="toc.line">
		<xsl:variable name="id">
			<xsl:call-template name="object.id"/>
		</xsl:variable>

		<xsl:variable name="label">
			<xsl:apply-templates select="." mode="label.markup"/>
		</xsl:variable>

		<fo:block text-align-last="justify" end-indent="{$toc.indent.width}pt"
                  last-line-end-indent="-{$toc.indent.width}pt">
			<fo:inline keep-with-next.within-line="always">
				<fo:basic-link internal-destination="{$id}" color="black">
					<!-- Chapter titles should be bold. -->

					<xsl:choose>
						<xsl:when test="local-name(.) = 'chapter'">
							<xsl:attribute name="font-weight">bold</xsl:attribute>
						</xsl:when>
					</xsl:choose>

					<xsl:if test="$label != ''">
						<!--
                        <xsl:value-of select="'Chapter '"/>
                        -->
						<xsl:copy-of select="$label"/>
						<xsl:value-of select="$autotoc.label.separator"/>
						<!-- <xsl:value-of select="..."/> -->

					</xsl:if>
					<xsl:apply-templates select="." mode="titleabbrev.markup"/>
				</fo:basic-link>
			</fo:inline>
			<fo:inline keep-together.within-line="always">
				<xsl:text/>
				<fo:leader leader-pattern="dots" leader-pattern-width="3pt"
                           leader-alignment="reference-area"
                           keep-with-next.within-line="always"/>
				<xsl:text/>
				<fo:basic-link internal-destination="{$id}" color="black">
					<fo:page-number-citation ref-id="{$id}"/>
				</fo:basic-link>
			</fo:inline>
		</fo:block>
	</xsl:template>

	<!--
      Blocks
     -->

	<xsl:attribute-set name="formal.object.properties">
		<xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
		<xsl:attribute name="space-before.optimum">1em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
		<xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
		<xsl:attribute name="space-after.optimum">1em</xsl:attribute>
		<xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
		<!-- Make examples, tables etc. break across pages -->
		<!--<xsl:attribute name="keep-together.within-column">always</xsl:attribute>-->
	</xsl:attribute-set>
	<!--
        <xsl:param name="formal.title.placement">
            figure after
            example before
            table before
        </xsl:param>
        -->

	<xsl:param name="formal.title.placement">
        figure after
        example before
        equation before
        table before
        procedure before
	</xsl:param>

	<xsl:attribute-set name="formal.title.properties">
		<xsl:attribute name="color">
			<xsl:value-of select="$caption.color"/>
		</xsl:attribute>
		<!--<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>-->
	</xsl:attribute-set>

	<xsl:template match="*" mode="admon.graphic.width">
		<xsl:text>36pt</xsl:text>
	</xsl:template>

	<xsl:attribute-set name="admonition.properties">
		<xsl:attribute name="color">#6F6F6F</xsl:attribute>
		<xsl:attribute name="padding-left">18pt</xsl:attribute>
		<xsl:attribute name="border-left-width">.75pt</xsl:attribute>
		<xsl:attribute name="border-left-style">solid</xsl:attribute>
		<xsl:attribute name="border-left-color">
			<xsl:value-of select="$border.color"/>
		</xsl:attribute>
		<xsl:attribute name="margin-left">0</xsl:attribute>
		<!--<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>-->
	</xsl:attribute-set>

	<xsl:attribute-set name="graphical.admonition.properties">
		<xsl:attribute name="margin-left">12pt</xsl:attribute>
		<xsl:attribute name="margin-right">12pt</xsl:attribute>
		<!--<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>-->
	</xsl:attribute-set>

	<xsl:attribute-set name="example.properties" use-attribute-sets="formal.object.properties">
		<xsl:attribute name="border-width">1pt</xsl:attribute>
		<xsl:attribute name="border-style">solid</xsl:attribute>
		<xsl:attribute name="border-color">#E6E6E6</xsl:attribute>
		<xsl:attribute name="padding-top">12pt</xsl:attribute>
		<xsl:attribute name="padding-right">12pt</xsl:attribute>
		<xsl:attribute name="padding-bottom">0</xsl:attribute>
		<xsl:attribute name="padding-left">12pt</xsl:attribute>
		<xsl:attribute name="margin-left">0</xsl:attribute>
		<xsl:attribute name="margin-right">0</xsl:attribute>
		<!--<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>-->
	</xsl:attribute-set>

	<xsl:attribute-set name="sidebar.properties" use-attribute-sets="formal.object.properties">
		<xsl:attribute name="border-style">solid</xsl:attribute>
		<xsl:attribute name="border-width">1pt</xsl:attribute>
		<xsl:attribute name="border-color">#D9D9D9</xsl:attribute>
		<xsl:attribute name="background-color">#F2F2F2</xsl:attribute>
		<xsl:attribute name="padding-start">16pt</xsl:attribute>
		<xsl:attribute name="padding-end">16pt</xsl:attribute>
		<xsl:attribute name="padding-top">18pt</xsl:attribute>
		<xsl:attribute name="padding-bottom">0</xsl:attribute>
		<!--<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>-->
	</xsl:attribute-set>

	<xsl:attribute-set name="sidebar.title.properties">
		<xsl:attribute name="font-family">
			<xsl:value-of select="$title.fontset"/>
		</xsl:attribute>
		<xsl:attribute name="font-weight">
			<xsl:value-of select="$header.font-weight"/>
		</xsl:attribute>
		<xsl:attribute name="color">
			<xsl:value-of select="$caption.color"/>
		</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 1.6"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="margin-bottom">
			<xsl:value-of select="$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<!--<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>-->
	</xsl:attribute-set>

	<!--
      Tables
    -->

	<xsl:template name="define.cell.padding">
		<xsl:choose>
			<xsl:when test="(ancestor::table[contains(concat(' ', @role , ' '), ' container ')] and descendant::informaltable) or (ancestor::db:table[contains(concat(' ', @role , ' '), ' container ')] and descendant::db:informaltable)">
					0pt
			</xsl:when>
			<xsl:otherwise>
					2pt
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:attribute-set name="table.cell.padding">
		<xsl:attribute name="padding-left">
			<xsl:call-template name="define.cell.padding"/>
		</xsl:attribute>
		<xsl:attribute name="padding-right">
			<xsl:call-template name="define.cell.padding"/>
		</xsl:attribute>
		<xsl:attribute name="padding-top">
			<xsl:call-template name="define.cell.padding"/>
		</xsl:attribute>
		<xsl:attribute name="padding-bottom">
			<xsl:call-template name="define.cell.padding"/>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:param name="table.frame.border.thickness">0.7pt</xsl:param>
	<xsl:param name="table.cell.border.thickness">0.7pt</xsl:param>
	<xsl:param name="table.cell.border.color">black</xsl:param>
	<xsl:param name="table.frame.border.color">black</xsl:param>
	<xsl:param name="table.cell.border.right.color">white</xsl:param>
	<xsl:param name="table.cell.border.left.color">white</xsl:param>
	<xsl:param name="table.frame.border.right.color">white</xsl:param>
	<xsl:param name="table.frame.border.left.color">white</xsl:param>

	<!-- My Table Mods -->
	<xsl:param name="met.table.font.size">0.7</xsl:param>
	<!--  -->
	<xsl:param name="met.table.head.font.size">0.7</xsl:param>
	<!-- Set table body font size and alignment -->
	<xsl:attribute-set name="table.properties">
		<xsl:attribute name="keep-together.within-column">auto</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * $met.table.font.size"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="table.table.properties">
		<xsl:attribute name="font-family">PT Sans,Calibri,DejaVu Sans</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * $met.table.font.size"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>

	<!-- Set table header font size -->
	<xsl:template name="table.row.properties">
		<xsl:if test="ancestor::thead">
			<xsl:attribute name="font-weight">bold</xsl:attribute>
			<!--xsl:attribute name="color">#FFFFFF</xsl:attribute-->
			<!-- White -->
			<!--xsl:attribute name="background-color">#000000</xsl:attribute-->
			<!-- Black -->
			<xsl:attribute name="font-size">
				<xsl:value-of
		select="$body.font.master * $met.table.head.font.size" />
				<xsl:text>pt</xsl:text>
			</xsl:attribute>
		</xsl:if>

		<xsl:if test="ancestor::tbody and descendant-or-self::*[contains(concat(' ', @role , ' '), ' thcontents ')]">
			<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
      <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
		</xsl:if>


	</xsl:template>


	<!--Index recto-->

	<!--<xsl:param name="column.count.index">2</xsl:param>-->



	<!--<xsl:template name="index.titlepage.recto">-->
	<!--<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="index.titlepage.recto.style" margin-left="0pt" font-size="24.8832pt" font-family="{$title.fontset}" font-weight="bold">-->
	<!--<xsl:call-template name="division.title">-->
	<!--<xsl:with-param name="node" select="ancestor-or-self::index[1]"/>-->
	<!--</xsl:call-template>-->
	<!--</fo:block>-->

	<!--<xsl:choose>-->
	<!--<xsl:when test="indexinfo/subtitle">-->
	<!--<xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="indexinfo/subtitle"/>-->
	<!--</xsl:when>-->
	<!--<xsl:when test="docinfo/subtitle">-->
	<!--<xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="docinfo/subtitle"/>-->
	<!--</xsl:when>-->
	<!--<xsl:when test="info/subtitle">-->
	<!--<xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="info/subtitle"/>-->
	<!--</xsl:when>-->
	<!--<xsl:when test="subtitle">-->
	<!--<xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="subtitle"/>-->
	<!--</xsl:when>-->
	<!--</xsl:choose>-->

	<!--<xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="indexinfo/itermset"/>-->
	<!--<xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="docinfo/itermset"/>-->
	<!--<xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="info/itermset"/>-->
	<!--</xsl:template>-->

	<!--
      Graphics
    -->

	<!-- graphicsize.extension only relevant for html output -->
	<!--
    <xsl:param name="graphicsize.extension">1</xsl:param>
    -->
	<xsl:param name="default.image.width">4in</xsl:param>
	<xsl:param name="default.inline.image.height">1em</xsl:param>

	<xsl:template name="process.image">
		<!-- if image is wider than the page, shrink it down to default.image.width -->
		<xsl:variable name="scalefit">
			<xsl:choose>
				<xsl:when test="$ignore.image.scaling != 0">0</xsl:when>
				<xsl:when test="@contentwidth">0</xsl:when>
				<xsl:when test="@contentdepth and @contentdepth != '100%'">0</xsl:when>
				<xsl:when test="@scale">0</xsl:when>
				<xsl:when test="@scalefit">
					<xsl:value-of select="@scalefit"/>
				</xsl:when>
				<xsl:when test="@width or @depth">1</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="scale">
			<xsl:choose>
				<xsl:when test="$ignore.image.scaling != 0">0</xsl:when>
				<xsl:when test="@contentwidth or @contentdepth">1.0</xsl:when>
				<xsl:when test="@scale">
					<xsl:value-of select="@scale div 100.0"/>
				</xsl:when>
				<xsl:otherwise>1.0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="filename">
			<xsl:choose>
				<xsl:when test="local-name(.) = 'graphic' or local-name(.) = 'inlinegraphic'">
					<xsl:call-template name="mediaobject.filename">
						<xsl:with-param name="object" select="."/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="mediaobject.filename">
						<xsl:with-param name="object" select=".."/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="content-type">
			<xsl:if test="@format">
				<xsl:call-template name="graphic.format.content-type">
					<xsl:with-param name="format" select="@format"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="bgcolor">
			<xsl:call-template name="pi.dbfo_background-color">
				<xsl:with-param name="node" select=".."/>
			</xsl:call-template>
		</xsl:variable>

		<fo:external-graphic>
			<xsl:attribute name="src">
				<xsl:call-template name="fo-external-image">
					<xsl:with-param name="filename">
						<xsl:if test="$img.src.path != '' and not(starts-with($filename, '/')) and not(contains($filename, '://'))">
							<xsl:value-of select="$img.src.path"/>
						</xsl:if>
						<xsl:value-of select="$filename"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>

			<xsl:attribute name="width">
				<xsl:choose>
					<xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
					<xsl:when test="contains(@width,'%')">
						<xsl:value-of select="@width"/>
					</xsl:when>
					<xsl:when test="@width and not(@width = '')">
						<xsl:call-template name="length-spec">
							<xsl:with-param name="length" select="@width"/>
							<xsl:with-param name="default.units" select="'px'"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="not(@depth) and name(../..) != 'inlinemediaobject' and $default.image.width != ''">
						<xsl:call-template name="length-spec">
							<xsl:with-param name="length" select="$default.image.width"/>
							<xsl:with-param name="default.units" select="'px'"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>auto</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<xsl:attribute name="height">
				<xsl:choose>
					<xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
					<xsl:when test="contains(@depth,'%')">
						<xsl:value-of select="@depth"/>
					</xsl:when>
					<xsl:when test="@depth">
						<xsl:call-template name="length-spec">
							<xsl:with-param name="length" select="@depth"/>
							<xsl:with-param name="default.units" select="'px'"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="name(../..) = 'inlinemediaobject' and $default.inline.image.height != ''">
						<xsl:call-template name="length-spec">
							<xsl:with-param name="length" select="$default.inline.image.height"/>
							<xsl:with-param name="default.units" select="'px'"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>auto</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<xsl:attribute name="content-width">
				<xsl:choose>
					<xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
					<xsl:when test="contains(@contentwidth,'%')">
						<xsl:value-of select="@contentwidth"/>
					</xsl:when>
					<xsl:when test="@contentwidth">
						<xsl:call-template name="length-spec">
							<xsl:with-param name="length" select="@contentwidth"/>
							<xsl:with-param name="default.units" select="'px'"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="number($scale) != 1.0">
						<xsl:value-of select="$scale * 100"/>
						<xsl:text>%</xsl:text>
					</xsl:when>
					<xsl:when test="$scalefit = 1">scale-to-fit</xsl:when>
					<xsl:otherwise>scale-down-to-fit</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<xsl:attribute name="content-height">
				<xsl:choose>
					<xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
					<xsl:when test="contains(@contentdepth,'%')">
						<xsl:value-of select="@contentdepth"/>
					</xsl:when>
					<xsl:when test="@contentdepth">
						<xsl:call-template name="length-spec">
							<xsl:with-param name="length" select="@contentdepth"/>
							<xsl:with-param name="default.units" select="'px'"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="number($scale) != 1.0">
						<xsl:value-of select="$scale * 100"/>
						<xsl:text>%</xsl:text>
					</xsl:when>
					<xsl:when test="$scalefit = 1">scale-to-fit</xsl:when>
					<xsl:otherwise>scale-down-to-fit</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<xsl:if test="$content-type != ''">
				<xsl:attribute name="content-type">
					<xsl:value-of select="concat('content-type:',$content-type)"/>
				</xsl:attribute>
			</xsl:if>

			<xsl:if test="$bgcolor != ''">
				<xsl:attribute name="background-color">
					<xsl:value-of select="$bgcolor"/>
				</xsl:attribute>
			</xsl:if>

			<xsl:if test="@align">
				<xsl:attribute name="text-align">
					<xsl:value-of select="@align"/>
				</xsl:attribute>
			</xsl:if>

			<xsl:if test="@valign">
				<xsl:attribute name="display-align">
					<xsl:choose>
						<xsl:when test="@valign = 'top'">before</xsl:when>
						<xsl:when test="@valign = 'middle'">center</xsl:when>
						<xsl:when test="@valign = 'bottom'">after</xsl:when>
						<xsl:otherwise>auto</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
			</xsl:if>
		</fo:external-graphic>
	</xsl:template>

	<!--
        Math
      -->

	<xsl:template match="mml:math" xmlns:mml="http://www.w3.org/1998/Math/MathML">
		<fo:instream-foreign-object>
			<xsl:attribute name="font-family">
				<xsl:value-of select="$math.font.family"/>
			</xsl:attribute>
			<xsl:copy>
				<xsl:copy-of select="@*"/>
				<xsl:apply-templates/>
			</xsl:copy>
		</fo:instream-foreign-object>
	</xsl:template>

	<!--
      Titles
    -->
  <!--<xsl:param name="appendix.autolabel" select="0"/>-->
  <xsl:param name="appendix.autolabel">A</xsl:param>
	<xsl:attribute-set name="section.title.properties">
		<xsl:attribute name="font-family">
			<xsl:value-of select="$title.fontset"/>
		</xsl:attribute>
		<xsl:attribute name="font-weight">
			<xsl:value-of select="$header.font-weight"/>
		</xsl:attribute>
		<xsl:attribute name="color">
			<xsl:value-of select="$title.color"/>
		</xsl:attribute>
		<!-- font size is calculated dynamically by section.heading template -->
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
		<xsl:attribute name="space-before.minimum">1em</xsl:attribute>
		<xsl:attribute name="space-before.optimum">1.2em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
		<xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
		<xsl:attribute name="space-after.optimum">1.0em</xsl:attribute>
		<xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<!-- make sure block it aligns with block title -->
		<xsl:attribute name="start-indent">
			<xsl:value-of select="$title.margin.left"/>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:param name="met.section.header.font.size">1.2</xsl:param>
	<xsl:attribute-set name="section.title.level1.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select = "$body.font.master * $met.section.header.font.size"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="section.title.level2.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select = "$body.font.master * $met.section.header.font.size"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="section.title.level3.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select = "$body.font.master * $met.section.header.font.size"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="section.title.level4.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select = "$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="section.title.level5.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select = "$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="section.title.level6.properties">
		<xsl:attribute name="font-size">$body.font.master<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="component.title.properties">
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
		<xsl:attribute name="space-before.optimum">
			<xsl:value-of select="concat($body.font.master, 'pt')"/>
		</xsl:attribute>
		<xsl:attribute name="space-before.minimum">
			<xsl:value-of select="concat($body.font.master, 'pt')"/>
		</xsl:attribute>
		<xsl:attribute name="space-before.maximum">
			<xsl:value-of select="concat($body.font.master, 'pt')"/>
		</xsl:attribute>
		<xsl:attribute name="space-after.optimum">
			<xsl:value-of select="concat($body.font.master, 'pt')"/>
		</xsl:attribute>
		<xsl:attribute name="space-after.minimum">
			<xsl:value-of select="concat($body.font.master, 'pt')"/>
		</xsl:attribute>
		<xsl:attribute name="space-after.maximum">
			<xsl:value-of select="concat($body.font.master, 'pt')"/>
		</xsl:attribute>
		<xsl:attribute name="hyphenate">false</xsl:attribute>
		<xsl:attribute name="font-weight">
			<xsl:value-of select="$header.font-weight"/>
		</xsl:attribute>
		<!-- color support on fo:block, to which this gets applied, added in DocBook XSL 1.78.1 -->
		<xsl:attribute name="color">
			<xsl:value-of select="$title.color"/>
		</xsl:attribute>
		<!--
        <xsl:attribute name="color">
          <xsl:choose>
            <xsl:when test="not(parent::db:chapter | parent::db:article | parent::db:appendix)">
              <xsl:value-of select="$title.color"/>
            </xsl:when>
            <xsl:otherwise>inherit</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        -->
		<xsl:attribute name="text-align">
			<xsl:choose>
				<xsl:when
                        test="((parent::db:article | parent::db:articleinfo) and not(ancestor::db:book) and not(self::db:bibliography)) or (parent::db:slides | parent::db:slidesinfo)">
                    center
				</xsl:when>
				<xsl:otherwise>left</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="start-indent">
			<xsl:value-of select="$title.margin.left"/>
		</xsl:attribute>
	</xsl:attribute-set>

	<!-- override to set color and move to separate line -->
	<xsl:template match="db:formalpara/db:title | formalpara/title">
		<xsl:variable name="titleStr">
			<xsl:apply-templates/>
		</xsl:variable>
		<xsl:variable name="lastChar">
			<xsl:if test="$titleStr != ''">
				<xsl:value-of select="substring($titleStr,string-length($titleStr),1)"/>
			</xsl:if>
		</xsl:variable>

		<!--        <fo:inline font-weight="bold"
                   color="{$caption.color}"
                   keep-with-next.within-line="always">
            <xsl:copy-of select="$titleStr"/>
            <xsl:if test="$lastChar != ''
                    and not(contains($runinhead.title.end.punct, $lastChar))">
                <xsl:value-of select="$runinhead.default.title.end.punct"/>
            </xsl:if>
        </fo:inline>-->

		<xsl:if test="$runinhead.default.title.break.after = '1'">
			<fo:block font-weight="bold" color="{$caption.color}">
				<xsl:copy-of select="$titleStr"/>
				<xsl:if test="$lastChar != '' and not(contains($runinhead.title.end.punct, $lastChar))">
					<xsl:value-of select="$runinhead.default.title.end.punct"/>
				</xsl:if>
			</fo:block>
		</xsl:if>
		<xsl:if test="not($runinhead.default.title.break.after = '1')">
			<fo:inline font-weight="bold"
                       color="{$caption.color}"
                       keep-with-next.within-line="always"
                       padding-end="1em">
				<xsl:copy-of select="$titleStr"/>
				<xsl:if test="$lastChar != '' and not(contains($runinhead.title.end.punct, $lastChar))">
					<xsl:value-of select="$runinhead.default.title.end.punct"/>
				</xsl:if>
			</fo:inline>
			<xsl:text>&#160;</xsl:text>
		</xsl:if>
	</xsl:template>

	<!--
      Anchors & Links
    -->

	<xsl:attribute-set name="xref.properties">
		<xsl:attribute name="color">
			<xsl:value-of select="$link.color"/>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="simple.xlink.properties">
		<xsl:attribute name="color">
			<xsl:value-of select="$link.color"/>
		</xsl:attribute>
	</xsl:attribute-set>

	<!--
      Lists
    -->

	<!-- no extra br between list levels -->

	<xsl:template match="listitem/*[1][local-name()='para' or
                                   local-name()='simpara' or
                                   local-name()='formalpara']
                     |glossdef/*[1][local-name()='para' or
                                   local-name()='simpara' or
                                   local-name()='formalpara']
                     |step/*[1][local-name()='para' or
                                   local-name()='simpara' or
                                   local-name()='formalpara']
                     |callout/*[1][local-name()='para' or
                                   local-name()='simpara' or
                                   local-name()='formalpara']"
              priority="2">
		<fo:block>
			<xsl:call-template name="anchor"/>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>



	<xsl:template name="next.itemsymbol">
		<xsl:param name="itemsymbol" select="'disc'"/>
		<xsl:choose>
			<!-- Change this list if you want to change the order of symbols -->
			<xsl:when test="$itemsymbol = 'disc'">disc</xsl:when>
			<xsl:when test="$itemsymbol = 'disc'">disc</xsl:when>
			<xsl:otherwise>disc</xsl:otherwise>
		</xsl:choose>
	</xsl:template>



	<xsl:param name="qandadiv.autolabel">0</xsl:param>
	<xsl:param name="variablelist.as.blocks">1</xsl:param>

	<!--xsl:attribute-set name="list.block.properties">
		<xsl:attribute name="margin-left">0.4cm</xsl:attribute>
	</xsl:attribute-set-->


	<xsl:param name="orderedlist.label.width">0.6cm</xsl:param>
	<!--xsl:param name="itemizedlist.label.width">0.6cm</xsl:param-->


	<xsl:attribute-set name="list.block.spacing">
		<xsl:attribute name="space-before.optimum">1em</xsl:attribute>
		<xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
		<xsl:attribute name="space-after.optimum">1em</xsl:attribute>
		<xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
		<xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="list.item.spacing">
		<xsl:attribute name="space-before.optimum">0.4em</xsl:attribute>
		<xsl:attribute name="space-before.minimum">0.4em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">0.4em</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="variablelist.term.properties">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:template name="itemizedlist.label.markup">
		<xsl:param name="itemsymbol" select="'disc'"/>

		<xsl:choose>
			<xsl:when test="$itemsymbol='none'"/>
			<xsl:when test="$itemsymbol='circle'">&#x25E6;</xsl:when>
			<xsl:when test="$itemsymbol='disc'">&#x2022;</xsl:when>
			<xsl:when test="$itemsymbol='square'">&#x25AA;</xsl:when>
			<xsl:when test="$itemsymbol='checked'">&#x25A0;</xsl:when>
			<xsl:when test="$itemsymbol='unchecked'">&#x25A1;</xsl:when>
			<xsl:otherwise>&#x2022;</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
      Title pages
    -->

	<xsl:param name="titlepage.color">#6F6F6F</xsl:param>
	<!--
    <xsl:param name="titlepage.color" select="$title.color"/>
    -->

	<xsl:attribute-set name="book.titlepage.recto.style">
		<xsl:attribute name="font-family">
			<xsl:value-of select="$title.fontset"/>
		</xsl:attribute>
		<xsl:attribute name="color">
			<xsl:value-of select="$titlepage.color"/>
		</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>

	<!--<xsl:attribute-set name="chapter.titlepage.recto.style">-->
	<!--<xsl:attribute name="color">-->
	<!--<xsl:value-of select="$chapter.title.color"/>-->
	<!--</xsl:attribute>-->
	<!--<xsl:attribute name="background-color">white</xsl:attribute>-->
	<!--<xsl:attribute name="font-size">24pt</xsl:attribute>-->
	<!--<xsl:attribute name="font-weight">normal</xsl:attribute>-->
	<!--<xsl:attribute name="text-align">left</xsl:attribute>-->
	<!--&lt;!&ndash;xsl:attribute name="wrap-option">no-wrap</xsl:attribute&ndash;&gt;-->
	<!--&lt;!&ndash;-->
	<!--<xsl:attribute name="padding-left">1em</xsl:attribute>-->
	<!--<xsl:attribute name="padding-right">1em</xsl:attribute>-->
	<!--&ndash;&gt;-->
	<!--</xsl:attribute-set>-->


	<xsl:attribute-set name="component.titlepage.properties">
		<xsl:attribute name="span">all</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="chapter.titlepage.recto.style">
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="font-family">
			<xsl:value-of select="$title.font.family"/>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="chapter.titlepage.label.properties">
		<xsl:attribute name="font-size">48pt</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="chapter.titlepage.title.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select = "$body.font.master * 2"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:template match="title | db:title" mode="chapter.titlepage.recto.auto.mode">
		<fo:block xsl:use-attribute-sets="chapter.titlepage.recto.style"  margin-bottom="1cm">
			<!--<fo:block xsl:use-attribute-sets="chapter.titlepage.label.properties">
                <xsl:apply-templates select=".." mode="label.markup"/>
            </fo:block>-->
			<fo:block xsl:use-attribute-sets="chapter.titlepage.title.properties" border-after-width = "1pt">
				<xsl:apply-templates select=".." mode="label.markup"/>
				<xsl:text>. </xsl:text>
				<xsl:apply-templates select=".." mode="title.markup"/>
			</fo:block>
			<!--<fo:block text-align-last="justify">
                <fo:leader
                    leader-pattern="rule"
                    leader-pattern-width="1pt" rule-thickness="1pt"  />
            </fo:block>-->
		</fo:block>
	</xsl:template>

	<xsl:attribute-set name="preface.titlepage.recto.style" use-attribute-sets="chapter.titlepage.recto.style">
		<xsl:attribute name="font-family">
			<xsl:value-of select="$title.fontset"/>
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="part.titlepage.recto.style">
		<xsl:attribute name="color">
			<xsl:value-of select="$title.color"/>
		</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>

	<!-- override to set different color for book title -->
	<xsl:template match="db:title | title" mode="book.titlepage.recto.auto.mode">
		<fo:block xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center" font-size="24.8832pt"
                  space-before="18.6624pt">
			<!-- FIXME don't use hardcoded value here -->
			<xsl:attribute name="color">black</xsl:attribute>
			<xsl:attribute name="font-weight">
				<xsl:value-of select="$header.font-weight"/>
			</xsl:attribute>
			<xsl:call-template name="division.title">
				<xsl:with-param name="node" select="ancestor-or-self::db:book[1] | ancestor-or-self::book[1]"/>
			</xsl:call-template>
		</fo:block>
	</xsl:template>

	<!-- add revision info on title page -->
	<xsl:template match="db:revision | revision" mode="book.titlepage.recto.auto.mode">
		<fo:block xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center" font-size="14.4pt"
                  space-before="1in" font-family="{$title.fontset}">
			<xsl:call-template name="gentext">
				<xsl:with-param name="key" select="'Revision'"/>
			</xsl:call-template>
			<xsl:call-template name="gentext.space"/>
			<xsl:apply-templates select="db:revnumber | revnumber" mode="titlepage.mode"/>
		</fo:block>
		<fo:block xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center" font-size="14.4pt"
                  font-family="{$title.fontset}">
			<xsl:apply-templates select="db:date | date" mode="titlepage.mode"/>
		</fo:block>
	</xsl:template>

	<!-- override to force use of title, author and one revision on titlepage -->
	<xsl:template name="book.titlepage.recto">
		<xsl:choose>
			<xsl:when test="db:bookinfo/db:title | bookinfo/title">
				<xsl:apply-templates mode="book.titlepage.recto.auto.mode"
                                     select="db:bookinfo/db:title | bookinfo/title"/>
			</xsl:when>
			<xsl:when test="db:info/db:title | info/title">
				<xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="db:info/db:title | info/title"/>
			</xsl:when>
			<xsl:when test="db:title | title">
				<xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="db:title | title"/>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="db:bookinfo/db:subtitle | bookinfo/subtitle">
				<xsl:apply-templates mode="book.titlepage.recto.auto.mode"
                                     select="db:bookinfo/db:subtitle | bookinfo/subtitle"/>
			</xsl:when>
			<xsl:when test="db:info/db:subtitle | info/subtitle">
				<xsl:apply-templates mode="book.titlepage.recto.auto.mode"
                                     select="db:info/db:subtitle | info/subtitle"/>
			</xsl:when>
			<xsl:when test="db:subtitle | subtitle">
				<xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="db:subtitle | subtitle"/>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="db:bookinfo//db:author | bookinfo//author">
				<xsl:apply-templates mode="book.titlepage.recto.auto.mode"
                                     select="db:bookinfo//db:author | bookinfo//author"/>
			</xsl:when>
			<xsl:when test="db:info//db:author | info//author">
				<xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="db:info//db:author | info//author"/>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="db:bookinfo/db:revhistory/db:revision[1] | bookinfo/revhistory/revision[1]">
				<xsl:apply-templates mode="book.titlepage.recto.auto.mode"
                                     select="db:bookinfo/db:revhistory/db:revision[1] | bookinfo/revhistory/revision[1]"/>
			</xsl:when>
			<xsl:when test="db:info/db:revhistory/db:revision[1] | info/revhistory/revision[1]">
				<xsl:apply-templates mode="book.titlepage.recto.auto.mode"
                                     select="db:info/db:revhistory/db:revision[1] | info/revhistory/revision[1]"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- cut out these pages -->
	<xsl:template name="book.titlepage.before.verso"/>
	<xsl:template name="book.titlepage.verso"/>



	<!-- appendix title-->
	
	<xsl:template match="title | db:title" mode="appendix.titlepage.recto.auto.mode">
		<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="appendix.titlepage.recto.style" 
			margin-left="{$title.margin.left}" font-family="{$title.fontset}" margin-bottom="1cm">
			<xsl:attribute name="font-size">
				<xsl:value-of select = "$body.font.master * 2"/>
				<xsl:text>pt</xsl:text>
			</xsl:attribute>
			<xsl:call-template name="component.title">
				
				<xsl:with-param name="node" select="ancestor-or-self::appendix[1] | ancestor-or-self::db:appendix[1]"/>
			</xsl:call-template>
		</fo:block>
	</xsl:template>	
	
	table.of.contents.titlepage.recto.auto.mode
	
	<!-- table of contents title-->
	
	<xsl:template name="table.of.contents.titlepage.recto">
		<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="table.of.contents.titlepage.recto.style" 
			space-before.minimum="1em" space-before.optimum="1.5em" 
			space-before.maximum="2em" space-after="1cm" start-indent="0pt" 
			font-weight="bold" font-family="{$title.fontset}">
			<xsl:attribute name="font-size">
				<xsl:value-of select = "$body.font.master * 2"/>
				<xsl:text>pt</xsl:text>
			</xsl:attribute>			
			<xsl:call-template name="gentext">
				<xsl:with-param name="key" select="'TableofContents'"/>
			</xsl:call-template>
		</fo:block>
	</xsl:template>
		

	<xsl:template match="title | db:title" mode="chapter.titlepage.recto.auto.mode">
		<fo:block xsl:use-attribute-sets="chapter.titlepage.recto.style"  margin-bottom="1cm">
			<!--<fo:block xsl:use-attribute-sets="chapter.titlepage.label.properties">
                <xsl:apply-templates select=".." mode="label.markup"/>
            </fo:block>-->
			<fo:block xsl:use-attribute-sets="chapter.titlepage.title.properties" border-after-width = "1pt">
				<xsl:apply-templates select=".." mode="label.markup"/>
				<xsl:text>. </xsl:text>
				<xsl:apply-templates select=".." mode="title.markup"/>
			</fo:block>
			<!--<fo:block text-align-last="justify">
                <fo:leader
                    leader-pattern="rule"
                    leader-pattern-width="1pt" rule-thickness="1pt"  />
            </fo:block>-->
		</fo:block>
	</xsl:template>


	<!--
      Footnotes
    -->

	<xsl:param name="footnote.number.format">1</xsl:param>
	<xsl:param name="footnote.number.symbols"/>

	<xsl:param name="footnote.font.size">
		<xsl:value-of select="$body.font.master * 0.8"/>
		<xsl:text>pt</xsl:text>
	</xsl:param>

	<xsl:attribute-set name="footnote.mark.properties">
		<!-- override font-family for mark since we don't need full font set -->
		<xsl:attribute name="font-family">
			<xsl:value-of select="$body.font.family"/>
		</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 0.8"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="color">
			<xsl:value-of select="$link.color"/>
		</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="padding">0 1pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="footnote.properties">
		<!-- force color since it will otherwise inherit from location of footnote text -->
		<xsl:attribute name="color">
			<xsl:value-of select="$text.color"/>
		</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="footnote.sep.leader.properties">
		<xsl:attribute name="color">
			<xsl:value-of select="$border.color"/>
		</xsl:attribute>
		<xsl:attribute name="leader-pattern">rule</xsl:attribute>
		<xsl:attribute name="leader-length">2in</xsl:attribute>
		<xsl:attribute name="rule-thickness">0.5pt</xsl:attribute>
	</xsl:attribute-set>

	<!-- Index does not use normal.para.spacing, so set text.color explicitly -->
	<!--
    <xsl:attribute-set name="index.div.title.properties">
      <xsl:attribute name="color"><xsl:value-of select="$text.color"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="index.entry.properties">
      <xsl:attribute name="color"><xsl:value-of select="$text.color"/></xsl:attribute>
    </xsl:attribute-set>
    -->

	<xsl:attribute-set name="index.entry.properties">
		<xsl:attribute name="font-size">10pt</xsl:attribute>
	</xsl:attribute-set>

	<!--Centering figure title-->
	<xsl:attribute-set name="formal.title.properties">
		<xsl:attribute name="text-align">
			<xsl:choose>
				<xsl:when test="self::figure | self::db:figure">center</xsl:when>
				<xsl:otherwise>left</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 0.85"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	</xsl:attribute-set>
  
  <!-- Убираем точку после всех заголовков -->
  
  <xsl:param name="runinhead.default.title.end.punct"/>
  
  <!-- Уменьшаем заголовок formalpara, содержащего обычно исходный код -->
  
  <xsl:template match="formalpara/title">
    <fo:block font-weight="bold">
      <xsl:attribute name="font-size">
        <xsl:value-of select="$body.font.master * 0.85"/>
        <xsl:text>pt</xsl:text>
      </xsl:attribute>
    
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

	<!-- Center all the images even if they do not have a title-->
	<xsl:attribute-set name="figure.properties">
		<xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="informalfigure.properties">
		<xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>

	<!-- page numbering -->

	<xsl:template name="page.number.format">
		<xsl:param name="element" select="local-name(.)"/>
		<xsl:param name="master-reference" select="''"/>

		<xsl:choose>
			<xsl:when test="$element = 'toc' and self::book">1</xsl:when>
			<xsl:when test="$element = 'set'">1</xsl:when>
			<xsl:when test="$element = 'book'">1</xsl:when>
			<xsl:when test="$element = 'preface'">1</xsl:when>
			<xsl:when test="$element = 'dedication'">1</xsl:when>
			<xsl:when test="$element = 'acknowledgements'">i</xsl:when>
			<xsl:otherwise>1</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="initial.page.number">
		<xsl:param name="element" select="local-name(.)"/>
		<xsl:param name="master-reference" select="''"/>

		<xsl:variable name="first">
			<xsl:choose>
				<xsl:when test="$force.blank.pages = 0">auto</xsl:when>
				<xsl:otherwise>auto-odd</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Select the first content that the stylesheet places
	   after the TOC -->
		<xsl:variable name="first.book.content"
				select="ancestor::book/*[
						  not(self::title or
							  self::subtitle or
							  self::titleabbrev or
							  self::bookinfo or
							  self::info or
							  self::dedication or
							  self::acknowledgements or
							  self::preface or
							  self::toc or
							  self::lot)][1]"/>
		<xsl:choose>
			<!-- double-sided output -->
			<xsl:when test="$double.sided != 0">
				<xsl:choose>
					<xsl:when test="$element = 'toc'">
						<xsl:value-of select="$first"/>
					</xsl:when>
					<xsl:when test="$element = 'book'">
						<xsl:value-of select="$first"/>
					</xsl:when>
					<!-- preface typically continues TOC roman numerals -->
					<!-- If changed to 1 here, then change page.number.format too -->
					<xsl:when test="$element = 'preface'">
						<xsl:value-of select="$first"/>
					</xsl:when>
					<xsl:when test="($element = 'dedication' or $element = 'article')
					and not(preceding::chapter
							or preceding::preface
							or preceding::appendix
							or preceding::article
							or preceding::dedication
							or parent::part
							or parent::reference)">1</xsl:when>
					<xsl:when test="generate-id($first.book.content) =
						generate-id(.)">auto</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$first"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>

			<!-- single-sided output -->
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$element = 'toc'">auto</xsl:when>
					<xsl:when test="$element = 'book'">auto</xsl:when>
					<xsl:when test="$element = 'preface'">auto</xsl:when>
					<xsl:when test="($element = 'dedication' or $element = 'article') and
						not(preceding::chapter
							or preceding::preface
							or preceding::appendix
							or preceding::article
							or preceding::dedication
							or parent::part
							or parent::reference)">1</xsl:when>
					<xsl:when test="generate-id($first.book.content) =
						generate-id(.)">auto</xsl:when>
					<xsl:otherwise>auto</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- абзацные отступы-->

	<!--xsl:template match="chapter/child::simpara | section/child::simpara">
		<xsl:variable name="keep.together">
			<xsl:call-template name="pi.dbfo_keep-together"/>
		</xsl:variable>
		<fo:block xsl:use-attribute-sets="normal.para.spacing" text-indent="10.0mm">
			<xsl:if test="$keep.together != ''">
				<xsl:attribute name="keep-together.within-column">
					<xsl:value-of
                      select="$keep.together"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="anchor"/>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template-->

	<!-- Без отступа для первого абзаца
	<xsl:template match="chapter/child::simpara[1] | section/child::simpara[1]">
		<xsl:variable name="keep.together">
			<xsl:call-template name="pi.dbfo_keep-together"/>
		</xsl:variable>
		<fo:block xsl:use-attribute-sets="normal.para.spacing">
			<xsl:if test="$keep.together != ''">
				<xsl:attribute name="keep-together.within-column">
					<xsl:value-of
                      select="$keep.together"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="anchor"/>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>-->

	<xsl:param name="xref.with.number.and.title" select="0"/>

	<xsl:attribute-set name="xref.properties">
		<xsl:attribute name="color">black
		</xsl:attribute>
	</xsl:attribute-set>

	<!--landscape-->

	<xsl:template name="user.pagemasters">
		<!-- body pages -->
		<fo:simple-page-master master-name="landscape-first"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}">
			<xsl:attribute name="margin-{$direction.align.start}">
				<xsl:value-of select="$page.margin.inner"/>
				<xsl:if test="$fop.extensions != 0">
					<xsl:value-of select="concat(' - (',$title.margin.left,')')"/>
				</xsl:if>
				<xsl:if test="$fop.extensions != 0">
					<xsl:value-of select="concat(' - (',$title.margin.left,')')"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="margin-{$direction.align.end}">
				<xsl:value-of select="$page.margin.outer"/>
			</xsl:attribute>
			<xsl:if test="$axf.extensions != 0">
				<xsl:call-template name="axf-page-master-properties">
					<xsl:with-param name="page.master">body-first</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<fo:region-body margin-bottom="{$body.margin.bottom}"
                      margin-top="{$body.margin.top}"
					  reference-orientation="90"
                      column-gap="{$column.gap.body}"
                      column-count="{$column.count.body}">
				<xsl:attribute name="margin-{$direction.align.start}">
					<xsl:value-of select="$body.margin.inner"/>
				</xsl:attribute>
				<xsl:attribute name="margin-{$direction.align.end}">
					<xsl:value-of select="$body.margin.outer"/>
				</xsl:attribute>
			</fo:region-body>
			<fo:region-before region-name="xsl-region-before-first"
                        extent="{$region.before.extent}"
                        precedence="{$region.before.precedence}"
                        display-align="before"/>
			<fo:region-after region-name="xsl-region-after-first"
                       extent="{$region.after.extent}"
                        precedence="{$region.after.precedence}"
                       display-align="after"/>
			<xsl:call-template name="region.inner">
				<xsl:with-param name="sequence">first</xsl:with-param>
				<xsl:with-param name="pageclass">body</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="region.outer">
				<xsl:with-param name="sequence">first</xsl:with-param>
				<xsl:with-param name="pageclass">body</xsl:with-param>
			</xsl:call-template>
		</fo:simple-page-master>

		<fo:simple-page-master master-name="landscape-odd"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}">
			<xsl:attribute name="margin-{$direction.align.start}">
				<xsl:value-of select="$page.margin.inner"/>
				<xsl:if test="$fop.extensions != 0">
					<xsl:value-of select="concat(' - (',$title.margin.left,')')"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="margin-{$direction.align.end}">
				<xsl:value-of select="$page.margin.outer"/>
			</xsl:attribute>
			<xsl:if test="$axf.extensions != 0">
				<xsl:call-template name="axf-page-master-properties">
					<xsl:with-param name="page.master">body-odd</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<fo:region-body margin-bottom="{$body.margin.bottom}"
                      margin-top="{$body.margin.top}"
					  reference-orientation="90"
                      column-gap="{$column.gap.body}"
                      column-count="{$column.count.body}">
				<xsl:attribute name="margin-{$direction.align.start}">
					<xsl:value-of select="$body.margin.inner"/>
				</xsl:attribute>
				<xsl:attribute name="margin-{$direction.align.end}">
					<xsl:value-of select="$body.margin.outer"/>
				</xsl:attribute>
			</fo:region-body>
			<fo:region-before region-name="xsl-region-before-odd"
                        extent="{$region.before.extent}"
                        precedence="{$region.before.precedence}"
                        display-align="before"/>
			<fo:region-after region-name="xsl-region-after-odd"
                       extent="{$region.after.extent}"
                       precedence="{$region.after.precedence}"
                       display-align="after"/>
			<xsl:call-template name="region.inner">
				<xsl:with-param name="pageclass">body</xsl:with-param>
				<xsl:with-param name="sequence">odd</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="region.outer">
				<xsl:with-param name="pageclass">body</xsl:with-param>
				<xsl:with-param name="sequence">odd</xsl:with-param>
			</xsl:call-template>
		</fo:simple-page-master>

		<fo:simple-page-master master-name="landscape-even"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin-top="{$page.margin.top}"
                           margin-bottom="{$page.margin.bottom}">
			<xsl:attribute name="margin-{$direction.align.start}">
				<xsl:value-of select="$page.margin.outer"/>
				<xsl:if test="$fop.extensions != 0">
					<xsl:value-of select="concat(' - (',$title.margin.left,')')"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="margin-{$direction.align.end}">
				<xsl:value-of select="$page.margin.inner"/>
			</xsl:attribute>
			<xsl:if test="$axf.extensions != 0">
				<xsl:call-template name="axf-page-master-properties">
					<xsl:with-param name="page.master">body-even</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<fo:region-body margin-bottom="{$body.margin.bottom}"
                      margin-top="{$body.margin.top}"
					  reference-orientation="90"
                      column-gap="{$column.gap.body}"
                      column-count="{$column.count.body}">
				<xsl:attribute name="margin-{$direction.align.start}">
					<xsl:value-of select="$body.margin.outer"/>
				</xsl:attribute>
				<xsl:attribute name="margin-{$direction.align.end}">
					<xsl:value-of select="$body.margin.inner"/>
				</xsl:attribute>
			</fo:region-body>
			<fo:region-before region-name="xsl-region-before-even"
                        extent="{$region.before.extent}"
                        precedence="{$region.before.precedence}"
                        display-align="before"/>
			<fo:region-after region-name="xsl-region-after-even"
                       extent="{$region.after.extent}"
                       precedence="{$region.after.precedence}"
                       display-align="after"/>
			<xsl:call-template name="region.outer">
				<xsl:with-param name="pageclass">body</xsl:with-param>
				<xsl:with-param name="sequence">even</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="region.inner">
				<xsl:with-param name="pageclass">body</xsl:with-param>
				<xsl:with-param name="sequence">even</xsl:with-param>
			</xsl:call-template>
		</fo:simple-page-master>

		<fo:page-sequence-master master-name="landscape">
			<fo:repeatable-page-master-alternatives>
				<fo:conditional-page-master-reference master-reference="blank"
                                              blank-or-not-blank="blank"/>
				<xsl:if test="$force.blank.pages != 0">
					<fo:conditional-page-master-reference master-reference="landscape-first"
                                                page-position="first"/>
				</xsl:if>
				<fo:conditional-page-master-reference master-reference="landscape-odd"
                                              odd-or-even="odd"/>
				<fo:conditional-page-master-reference
                                              odd-or-even="even">
					<xsl:attribute name="master-reference">
						<xsl:choose>
							<xsl:when test="$double.sided != 0">landscape-even</xsl:when>
							<xsl:otherwise>landscape-odd</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</fo:conditional-page-master-reference>
			</fo:repeatable-page-master-alternatives>
		</fo:page-sequence-master>
	</xsl:template>

	<xsl:template name="select.user.pagemaster">
		<xsl:param name="element"/>
		<xsl:param name="pageclass"/>
		<xsl:param name="default-pagemaster"/>

		<xsl:choose>
			<xsl:when test="contains(concat(' ', @role , ' '), ' landscape ')">landscape</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$default-pagemaster"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Поворот картинки -->
	<xsl:template match="db:figure[contains(concat(' ', @role , ' '), ' img-landscape ')] | figure[contains(concat(' ', @role , ' '), ' img-landscape ')]">
		<fo:block-container reference-orientation="90">
			<xsl:apply-imports/>
		</fo:block-container>
	</xsl:template>

	<!--Header Footer-->

	<xsl:param name="header.column.widths">1 17 1</xsl:param>
	<xsl:param name="footer.column.widths">16 1 2</xsl:param>

	<xsl:template name="header.content">
		<xsl:param name="pageclass" select="''"/>
		<xsl:param name="sequence" select="''"/>
		<xsl:param name="position" select="''"/>
		<xsl:param name="gentext-key" select="''"/>

		<!--
  <fo:block>
    <xsl:value-of select="$pageclass"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$sequence"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$position"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$gentext-key"/>
  </fo:block>
-->

		<fo:block>

			<!-- sequence can be odd, even, first, blank -->
			<!-- position can be left, center, right -->
			<xsl:choose>
				<xsl:when test="$sequence = 'blank'">
					<!-- nothing -->
				</xsl:when>

				<xsl:when test="$position='left'">
					<!-- Same for odd, even, empty, and blank sequences -->
					<xsl:call-template name="draft.text"/>
				</xsl:when>

				<xsl:when test="($sequence='odd' or $sequence='even') and $position='center' and $pageclass != 'lot'">
					<xsl:if test="$pageclass != 'titlepage'">
						<xsl:choose>
							<xsl:when test="ancestor::book and ($double.sided != 0)">
								<fo:retrieve-marker retrieve-class-name="section.head.marker"
                                  retrieve-position="first-including-carryover"
                                  retrieve-boundary="page-sequence"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="." mode="titleabbrev.markup"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:when>

				<xsl:when test="$position='center'">
					<!-- nothing for empty and blank sequences -->
				</xsl:when>

				<xsl:when test="$position='right'">
					<!-- Same for odd, even, empty, and blank sequences -->
					<xsl:call-template name="draft.text"/>
				</xsl:when>

				<xsl:when test="$sequence = 'first'">
					<!-- nothing for first pages -->
				</xsl:when>

				<xsl:when test="$sequence = 'blank'">
					<!-- nothing for blank pages -->
				</xsl:when>
			</xsl:choose>
		</fo:block>
	</xsl:template>


	<xsl:template name="footer.content">
		<xsl:param name="pageclass" select="''"/>
		<xsl:param name="sequence" select="''"/>
		<xsl:param name="position" select="''"/>
		<xsl:param name="gentext-key" select="''"/>

		<!--
  <fo:block>
    <xsl:value-of select="$pageclass"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$sequence"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$position"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$gentext-key"/>
  </fo:block>
-->

		<fo:block>
			<!-- pageclass can be front, body, back -->
			<!-- sequence can be odd, even, first, blank -->
			<!-- position can be left, center, right -->
			<xsl:choose>
				<xsl:when test="$pageclass = 'titlepage'">
					<!-- nop; no footer on title pages -->
				</xsl:when>

				<xsl:when test="$double.sided != 0 and $sequence = 'even'
                      and $position='left'">
					<fo:page-number/>
				</xsl:when>

				<xsl:when test="$double.sided != 0 and ($sequence = 'odd' or $sequence = 'first')
                      and $position='right'">
					<fo:page-number/>
				</xsl:when>

				<xsl:when test="$double.sided = 0 and $position='center'">

				</xsl:when>

				<xsl:when test="$double.sided = 0 and $position='right'">
					<fo:page-number/>
				</xsl:when>


				<xsl:when test="$double.sided = 0 and $position='left' and (ancestor-or-self::book | ancestor-or-self::db:book)">
					<xsl:value-of select = "//title[1] | //db:title[1]"/>
					<xsl:if test="//revnumber | //db:revnumber">
						<xsl:call-template name="gentext">
							<xsl:with-param name="key" select="'listcomma'"/>
						</xsl:call-template>
						<xsl:call-template name="gentext.space"/>
						<xsl:call-template name="gentext">
							<xsl:with-param name="key" select="'revision'"/>
						</xsl:call-template>
						<xsl:call-template name="gentext.space"/>
						<xsl:value-of select="//revnumber[1] | //db:revnumber[1]"/>
					</xsl:if>
				</xsl:when>

				<xsl:when test="$double.sided = 0 and $position='left' and (ancestor-or-self::article | ancestor-or-self::db:article)">
					<xsl:if test="//revnumber | //db:revnumber">
						<xsl:call-template name="gentext">
							<xsl:with-param name="key" select="'Revision'"/>
						</xsl:call-template>
						<xsl:call-template name="gentext.space"/>
						<xsl:value-of select="//revnumber[1] | //db:revnumber[1]"/>
					</xsl:if>
				</xsl:when>



				<xsl:when test="$sequence='blank'">
					<xsl:choose>
						<xsl:when test="$double.sided != 0 and $position = 'left'">
							<fo:page-number/>
						</xsl:when>
						<xsl:when test="$double.sided = 0 and $position = 'center'">
							<fo:page-number/>
						</xsl:when>
						<xsl:otherwise>
							<!-- nop -->
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>


				<xsl:otherwise>
					<!-- nop -->
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>
	</xsl:template>

	<!--gentext customization-->
	<xsl:param name="local.l10n.xml" select="document('')"/>
	<l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
		<l:l10n language="ru">
			<l:gentext key="revision" text="версия"/>
			<l:gentext key="Revision" text="Версия"/>
			<l:context name="title">
				<l:template name="figure" text="Рис. %n. %t"/>
			</l:context>
		</l:l10n>
	</l:i18n>

	<!--поворот таблицы-->
	<xsl:template name="table.container">
		<xsl:param name="table.block"/>
		<xsl:choose>
			<xsl:when test="(@orien='land' or contains(concat(' ', @role , ' '), ' landscape ')) and
                    $fop.extensions = 0" >
				<fo:block-container reference-orientation="90"
            padding="6pt"
            xsl:use-attribute-sets="list.block.spacing">
					<xsl:attribute name="width">
						<xsl:call-template name="table.width"/>
					</xsl:attribute>
					<fo:block start-indent="0pt" end-indent="0pt">
						<xsl:copy-of select="$table.block"/>
					</fo:block>
				</fo:block-container>
			</xsl:when>
			<xsl:when test="@pgwide = 1">
				<fo:block xsl:use-attribute-sets="pgwide.properties">
					<xsl:copy-of select="$table.block"/>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$table.block"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--	Article title-->
	<xsl:attribute-set name="article.titlepage.recto.style">
		<xsl:attribute name="text-align">left</xsl:attribute>
	</xsl:attribute-set>

	<xsl:template name="article.titlepage.recto">

		<xsl:choose>
			<xsl:when test="db:articleinfo/db:title | articleinfo/title">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:articleinfo/db:title | articleinfo/title"/>
			</xsl:when>
			<xsl:when test="db:artheader/db:title | artheader/title">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:artheader/db:title | artheader/title"/>
			</xsl:when>
			<xsl:when test="db:info/db:title">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:info/db:title"/>
			</xsl:when>
			<xsl:when test="db:title | title">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:title | title"/>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="db:articleinfo/db:subtitle | articleinfo/subtitle">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:articleinfo/db:subtitle | articleinfo/subtitle"/>
			</xsl:when>
			<xsl:when test="db:artheader/db:subtitle | artheader/subtitle">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:artheader/db:subtitle | artheader/subtitle"/>
			</xsl:when>
			<xsl:when test="db:info/db:subtitle | info/subtitle">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:info/db:subtitle | info/subtitle"/>
			</xsl:when>
			<xsl:when test="db:subtitle | subtitle">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:subtitle | subtitle"/>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="db:articleinfo/db:author | articleinfo/author">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:articleinfo/db:author | articleinfo/author"/>
			</xsl:when>
			<xsl:when test="db:info/db:author | info/author">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:info/db:author | info/author"/>
			</xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="db:articleinfo/db:authorgroup | articleinfo/authorgroup">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:articleinfo/db:authorgroup | articleinfo/authorgroup"/>
			</xsl:when>
			<xsl:when test="db:info/db:authorgroup | info/authorgroup">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:info/db:authorgroup | info/authorgroup"/>
			</xsl:when>
		</xsl:choose>



<!-- 		<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:articleinfo/db:author | articleinfo/author"/> -->
<!-- 		<xsl:apply-templates mode="article.titlepage.recto.auto.mode" select="db:articleinfo/db:authorgroup | articleinfo/authorgroup"/>		 -->

		<xsl:choose>
			<xsl:when test="db:artcleinfo/db:revhistory/db:revision[1] | articleinfo/revhistory/revision[1]">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode"
                                     select="db:articleinfo/db:revhistory/db:revision[1] | articleinfo/revhistory/revision[1]"/>
			</xsl:when>
			<xsl:when test="db:info/db:revhistory/db:revision[1] | info/revhistory/revision[1]">
				<xsl:apply-templates mode="article.titlepage.recto.auto.mode"
                                     select="db:info/db:revhistory/db:revision[1] | info/revhistory/revision[1]"/>
			</xsl:when>
		</xsl:choose>

		<fo:block-container height="2em">
			<fo:block>
				<xsl:text>&#160;</xsl:text>
			</fo:block>
		</fo:block-container>
	</xsl:template>



	<xsl:template match="db:title | title" mode="article.titlepage.recto.auto.mode">
		<fo:block xsl:use-attribute-sets="article.titlepage.recto.style" keep-with-next.within-column="always">
			<xsl:attribute name="font-size">
				<xsl:value-of select = "$body.font.master * 2"/>
				<xsl:text>pt</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="font-style">normal</xsl:attribute>
			<xsl:call-template name="component.title">
				<xsl:with-param name="node" select="ancestor-or-self::db:article[1] | ancestor-or-self::article[1]"/>
			</xsl:call-template>
		</fo:block>
	</xsl:template>

	<xsl:template match="db:subtitle | subtitle" mode="article.titlepage.recto.auto.mode">
		<fo:block xsl:use-attribute-sets="article.titlepage.recto.style">
			<xsl:attribute name="font-size">
				<xsl:value-of select = "$body.font.master * 1.5"/>
				<xsl:text>pt</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="font-style">italic</xsl:attribute>
			<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
		</fo:block>
	</xsl:template>

	<xsl:template match="db:author | author" mode="article.titlepage.recto.auto.mode">
		<fo:block xsl:use-attribute-sets="article.titlepage.recto.style" space-before="1em">
			<xsl:attribute name="font-size">
				<xsl:value-of select = "$body.font.master * 1"/>
				<xsl:text>pt</xsl:text>
			</xsl:attribute>
			<!--			<xsl:attribute name="font-style">italic</xsl:attribute>		-->
			<xsl:apply-templates select="." mode="article.titlepage.recto.mode"/>
		</fo:block>
	</xsl:template>

	<!-- add revision info on article title page -->
	<xsl:template match="db:revision | revision" mode="article.titlepage.recto.auto.mode">
		<fo:block xsl:use-attribute-sets="book.titlepage.recto.style" text-align="left"
                  space-before="1em" font-family="{$title.fontset}">
			<xsl:attribute name="font-size">
				<xsl:value-of select = "$body.font.master * 0.9"/>
				<xsl:text>pt</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="font-style">italic</xsl:attribute>
			<xsl:call-template name="gentext">
				<xsl:with-param name="key" select="'Revision'"/>
			</xsl:call-template>
			<xsl:call-template name="gentext.space"/>
			<xsl:apply-templates select="db:revnumber | revnumber" mode="titlepage.mode"/>
			<xsl:if test="db:date | date">
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="db:date | date" mode="titlepage.mode"/>
			</xsl:if>
		</fo:block>
	</xsl:template>
	

<!-- Делаем русскую нумерацию xsl-number -->

<xsl:variable name="alpha.labels.uppercase">
	<xsl:text>АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ</xsl:text>	
</xsl:variable>

<xsl:variable name="alpha.labels.lowercase">
		<xsl:text>абвгдежзийклмнопрстуфхцчшщъыьэюя</xsl:text>
</xsl:variable>
	


<!-- в приложениях -->
	
<xsl:template match="db:appendix | appendix" mode="label.markup">
	<xsl:choose>
		<xsl:when test="@label">
			<xsl:value-of select="@label"/>
		</xsl:when>
		<xsl:when test="string($appendix.autolabel) != 0">
			<xsl:if test="$component.label.includes.part.label != 0 and
				ancestor::db:part">
				<xsl:variable name="part.label">
					<xsl:apply-templates select="ancestor::db:part" 
						mode="label.markup"/>
				</xsl:variable>
				<xsl:if test="$part.label != ''">
					<xsl:value-of select="$part.label"/>
					<xsl:apply-templates select="ancestor::db:part" 
						mode="intralabel.punctuation"/>
				</xsl:if>
			</xsl:if>
			<xsl:variable name="format">
				<xsl:call-template name="autolabel.format">
					<xsl:with-param name="format" select="$appendix.autolabel"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="appendix.true.number">
				<xsl:choose>
					<xsl:when test="$label.from.part != 0 and (ancestor::db:part or ancestor::part)">
						<xsl:number from="db:part | part" count="db:appendix | appendix" format="1" level="any"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:number from="db:book | db:article"
							count="db:appendix | appendix" format="1" level="any"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$format='A'">
					<xsl:value-of select="substring($alpha.labels.uppercase,number($appendix.true.number), 1)"/>
				</xsl:when>		
				<xsl:when test="$format='a.'">
					<xsl:value-of select="substring($alpha.labels.lowercase,number($appendix.true.number), 1)"/>

				</xsl:when>
				<xsl:otherwise>
					<xsl:number value="$appendix.true.number" format="{$format}"/>
				</xsl:otherwise>	
			</xsl:choose>
			
		</xsl:when>
	</xsl:choose>
</xsl:template>

<!-- в списках -->

<xsl:template match="db:orderedlist/db:listitem | orderedlist/listitem" mode="item-number">
	<xsl:variable name="numeration">
	<xsl:call-template name="list.numeration">
	  <xsl:with-param name="node" select="parent::db:orderedlist|parent::orderedlist"/>
	</xsl:call-template>
	</xsl:variable>
	
	<xsl:variable name="type">
	<xsl:choose>
	  <xsl:when test="$numeration='arabic'">1.</xsl:when>
	  <xsl:when test="$numeration='loweralpha'">a.</xsl:when>
	  <xsl:when test="$numeration='lowerroman'">i.</xsl:when>
	  <xsl:when test="$numeration='upperalpha'">A.</xsl:when>
	  <xsl:when test="$numeration='upperroman'">I.</xsl:when>
	  <!-- What!? This should never happen -->
	  <xsl:otherwise>
	    <xsl:message>
	      <xsl:text>Unexpected numeration: </xsl:text>
	      <xsl:value-of select="$numeration"/>
	    </xsl:message>
	    <xsl:value-of select="1."/>
	  </xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="item-number">
	<xsl:call-template name="orderedlist-item-number"/>
	</xsl:variable>
	
	<xsl:if test="(parent::db:orderedlist/@inheritnum='inherit'
	            and ancestor::db:listitem[parent::db:orderedlist]) 
              or (parent::orderedlist/@inheritnum='inherit'
	            and ancestor::listitem[parent::orderedlist])
              ">
	<xsl:apply-templates select="ancestor::db:listitem[parent::db:orderedlist][1]|ancestor::listitem[parent::orderedlist][1]"
	                     mode="item-number"/>
	</xsl:if>
	

	
	<xsl:choose>
		<xsl:when test="$type='A.'">
		
			<xsl:value-of select="substring($alpha.labels.uppercase,number($item-number), 1)"/>
			<xsl:text>.</xsl:text>
		</xsl:when>		
		<xsl:when test="$type='a.'">
		
			<xsl:value-of select="substring($alpha.labels.lowercase,number($item-number), 1)"/>
			<xsl:text>.</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:number value="$item-number" format="{$type}"/>
		</xsl:otherwise>	
	</xsl:choose>
</xsl:template>		
		
	
	
</xsl:stylesheet>
