<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes" method="html"/>
    <!--xsl:variable name="pref"
        select="if (name(xs:schema/namespace::*[.=/xs:schema/@targetNamespace])!='') 
        then concat(name(xs:schema/namespace::*[.=/xs:schema/@targetNamespace]), ':') else ''"/-->
    <xsl:variable name="pref"
        select="''"/>    
    <xsl:variable name="attrFormed"
        select="if (xs:schema/@attributeFormDefault='qualified') 
        then $pref else ''"/>
    
    <xsl:template match="xs:schema">
        [cols="7, 8a, ^7, ^2 ", options="header"]
        |===
        ^|Наименование элемента 
        ^|Описание 
        |Тип 
        |.. 
       
                    <xsl:for-each select="*[name() = 'xs:simpleType']">
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                    <xsl:for-each select="*[name() != 'xs:simpleType']">
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>

        |===            
        
    </xsl:template>    
    <xsl:template match="xs:element">
        |
                <xsl:for-each
                    select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' or name()='xs:choice']) +
                    count(ancestor::*[name() = 'xs:complexType' and @name])">
                    <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
                </xsl:for-each> 
                <xsl:if test="count(ancestor::*) = 1">
                    *<xsl:if test="@ref"><xsl:value-of select="@ref"/></xsl:if><xsl:if test="not(@ref)"><xsl:value-of select="concat($pref, @ref|@name)"/></xsl:if>*
                </xsl:if>
                <xsl:if test="not(count(ancestor::*) = 1)">
                    <xsl:if test="@ref"><xsl:value-of select="@ref"/></xsl:if>
                    <xsl:if test="not(@ref)"><xsl:value-of select="concat($pref, @ref|@name)"/></xsl:if>
                </xsl:if>
        
        <xsl:text>
        </xsl:text>
        <xsl:if test="xs:complexType">2+</xsl:if>|
        <xsl:value-of select="normalize-space(xs:annotation/xs:documentation/text())"/>
        <xsl:value-of select="'{nbsp}'"/>
        
        <xsl:if test="not(xs:complexType)">
        |
                 <xsl:value-of select="@type"/>
                    <xsl:if test="@ref">
                        <xsl:value-of select="concat('см.{nbsp}', @ref)"/>
                    </xsl:if>
                    <xsl:value-of select="'{nbsp}'"/>
                
            </xsl:if>
        |
                <xsl:value-of
                    select="concat(if (@minOccurs != '' or @maxOccurs != '') then '[' else '',@minOccurs, 
                    if (@minOccurs != '' or @maxOccurs != '') then '..' else '', 
                    if (@maxOccurs != '') then if(@maxOccurs = 'unbounded') then 'n' else @maxOccurs else '{nbsp}',
                    if (@minOccurs != '' or @maxOccurs != '') then ']' else '')"/>
                <xsl:if test="count(ancestor::*) = 1">

                    <xsl:value-of select="'[1..1]'"/>

                </xsl:if>

            
        
        <xsl:for-each select="*[name()='xs:unique']">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <xsl:for-each select="*[name()!='xs:unique']">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="xs:complexType">
        <xsl:if test="not(@name)">
            <xsl:for-each select="*[name()='xs:attributeGroup']">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
            <xsl:for-each select="*[name()='xs:attribute']">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
            <xsl:for-each select="*[not (name()='xs:attribute' or name()='xs:attributeGroup') ]">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </xsl:if>
        <xsl:if test="@name">

        |
            <xsl:for-each
                        select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' or name()='xs:choice']) +
                        count(ancestor::*[name() = 'xs:complexType' and @name])">
                        <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
                    </xsl:for-each>
                    *<xsl:value-of select="concat($pref, @name)"/>*
        |
            <xsl:value-of select="normalize-space(xs:annotation/xs:documentation/text())"/>
                    <xsl:value-of select="'{nbsp}'"/>
        |
            _<xsl:value-of select="'составной тип'"/>_
        |
            <xsl:value-of select="'{nbsp}X{nbsp}'"/>
            
            <xsl:for-each select="*[name()='xs:attributeGroup']">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
            <xsl:for-each select="*[name()='xs:attribute']">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
            <xsl:for-each select="*[not (name()='xs:attribute' or name()='xs:attributeGroup') ]">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="xs:complexContent">
        |
        _Комплексное содержание_
        3+| 
        <xsl:if test="xs:restriction">
            <xsl:value-of select="concat('Ограничение на ', xs:restriction/@base)"/>
        </xsl:if>
        <xsl:if test="xs:extension">
            <xsl:value-of select="concat('Расширение ', xs:extension/@base)"/>
        </xsl:if>
        <xsl:for-each select="*[name()='xs:restriction']/*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        <xsl:for-each select="*[name()='xs:extension']/*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>        

    </xsl:template>    
    
    <xsl:template match="xs:sequence">
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="xs:all">
        |        
                <xsl:for-each
                    select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' or name()='xs:choice']) +
                    count(ancestor::*[name() = 'xs:complexType' and @name])">
                    <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
                </xsl:for-each>
                _<xsl:value-of select="'(произвольно)'"/>_
                
                _Далее элементы могут идти в произвольном порядке_
        |
        <xsl:value-of select="'{nbsp}X{nbsp}'"/>
        
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="xs:annotation"/>
    <xsl:template match="xs:attribute">
        |
        <xsl:for-each
                    select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' 
                        or name()='xs:choice' or name()='xs:attributeGroup']) +
                        count(ancestor::*[name() = 'xs:complexType' and @name])">
                    <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
                </xsl:for-each>
               

                <xsl:value-of select="concat('@',$attrFormed, @name)"/>

        |
                <xsl:value-of select="normalize-space(xs:annotation/xs:documentation/text())"/>
                <xsl:value-of select="'{nbsp}'"/>

        |
                <xsl:value-of select="@type"/>
                <xsl:value-of select="'{nbsp}'"/>
        |
                <xsl:value-of select="if (@use = 'required') then '[1..1]' else '[0..1]'"/>
        
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="xs:group">
        <xsl:if test="@ref">
            
            |
            <xsl:for-each
                select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' or name()='xs:choice']) +
                count(ancestor::*[name() = 'xs:complexType' and @name])">
                <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
            </xsl:for-each>
            _<xsl:value-of select="'(группа)'"/>_
            |
            <xsl:value-of select="normalize-space(xs:annotation/xs:documentation/text())"/>
            <xsl:value-of select="'{nbsp}'"/>
            
            |            
            <xsl:value-of select="@type"/>
            <xsl:if test="@ref">
                <xsl:value-of select="concat('см.{nbsp}', @ref)"/>
            </xsl:if>
            <xsl:value-of select="'{nbsp}'"/>
            |
            <xsl:value-of
                select="concat(if (@minOccurs != '' or @maxOccurs != '') then '[' else '',@minOccurs, 
                if (@minOccurs != '' or @maxOccurs != '') then '..' else '', 
                if (@maxOccurs != '') then if(@maxOccurs = 'unbounded') then 'n' else @maxOccurs else '{nbsp}',
                if (@minOccurs != '' or @maxOccurs != '') then ']' else '')"/>
            
        </xsl:if>
        <xsl:if test="@name">
            
            |
            <xsl:for-each
                select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' or name()='xs:choice']) +
                count(ancestor::*[name() = 'xs:complexType' and @name])">
                <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
            </xsl:for-each>
            *<xsl:value-of select="concat($pref, @name)"/>*
            
            |
            <xsl:value-of select="normalize-space(xs:annotation/xs:documentation/text())"/>
            <xsl:value-of select="'{nbsp}'"/>
            
            |
            _<xsl:value-of select="'группа'"/>_
            
            |
            <xsl:value-of select="'{nbsp}X{nbsp}'"/>
            
            
        </xsl:if>
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>      
    <xsl:template match="xs:attributeGroup">
        <xsl:if test="@ref">

        |
                    <xsl:for-each
                        select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' or name()='xs:choice']) +
                        count(ancestor::*[name() = 'xs:complexType' and @name])">
                        <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
                    </xsl:for-each>
                    _<xsl:value-of select="'(группа{nbsp}атрибутов)'"/>_
        |
                    <xsl:value-of select="normalize-space(xs:annotation/xs:documentation/text())"/>
                    <xsl:value-of select="'{nbsp}'"/>

        |            
                    <xsl:value-of select="@type"/>
                    <xsl:if test="@ref">
                        <xsl:value-of select="concat('см.{nbsp}', @ref)"/>
                    </xsl:if>
                    <xsl:value-of select="'{nbsp}'"/>
        |
                    <xsl:value-of select="'{nbsp}X{nbsp}'"/>
            
        </xsl:if>
        <xsl:if test="@name">

        |
                    <xsl:for-each
                        select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' or name()='xs:choice']) +
                        count(ancestor::*[name() = 'xs:complexType' and @name])">
                        <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
                    </xsl:for-each>
                    *<xsl:value-of select="concat($pref, @name)"/>*
                
        |
                    <xsl:value-of select="normalize-space(xs:annotation/xs:documentation/text())"/>
                    <xsl:value-of select="'{nbsp}'"/>
                
        |
                    _<xsl:value-of select="'группа атрибутов'"/>_
                
        |
                    <xsl:value-of select="'{nbsp}X{nbsp}'"/>
                
            
        </xsl:if>
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="xs:extension">
        |
        <xsl:for-each
            select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' or name()='xs:choice']) +
            count(ancestor::*[name() = 'xs:complexType' and @name])">
            <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
        </xsl:for-each>
        _<xsl:value-of select="concat('', '(расширение)')"/>_
        
        
        |
        <xsl:value-of select="normalize-space(xs:annotation/xs:documentation/text())"/>
        <xsl:value-of select="'{nbsp}'"/>
        
        |
        <xsl:value-of select="@base"/>
        |
        <xsl:value-of select="'{nbsp}'"/>        
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>

        
        
    </xsl:template>    
    <xsl:template match="xs:any">
        |
                <xsl:for-each
                    select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' or name()='xs:choice']) +
                    count(ancestor::*[name() = 'xs:complexType' and @name])">
                    <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
                </xsl:for-each>
                _<xsl:value-of select="concat('', '(любой элемент)')"/>_
                
            
        |
                <xsl:value-of select="normalize-space(xs:annotation/xs:documentation/text())"/>
                <xsl:value-of select="'{nbsp}'"/>
            
        2+|
                <xsl:value-of
                    select="concat(if (@minOccurs != '' or @maxOccurs != '') then '[' else '',@minOccurs, 
                    if (@minOccurs != '' or @maxOccurs != '') then '..' else '', 
                    if (@maxOccurs != '') then if(@maxOccurs = 'unbounded') then 'n' else @maxOccurs else '{nbsp}',
                    if (@minOccurs != '' or @maxOccurs != '') then ']' else '')"
                />
            
        
    </xsl:template>
    <xsl:template match="xs:choice">

        |
                <xsl:for-each
                    select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' or name()='xs:choice']) +
                    count(ancestor::*[name() = 'xs:complexType' and @name])">
                    <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
                </xsl:for-each>
                _<xsl:value-of select="'(выбор)'"/>_
            
        2+|
                _Выбор одного из следующих элементов_
            
        ^.^|X
                
            
        
        <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="xs:simpleType">

        |
                <xsl:for-each
                    select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' or name()='xs:choice' or name()='xs:attribute']) +
                    count(ancestor::*[name() = 'xs:complexType' and @name])">
                    <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
                </xsl:for-each>

                        _<xsl:value-of select="concat('type:', '')"/>_

                    <xsl:value-of select="concat('', @name)"/>

            
        3+a|
                <xsl:if test="xs:annotation/xs:documentation">
                    <xsl:value-of select="normalize-space(xs:annotation/xs:documentation/text())"/>
                    <xsl:text>
                        
                    </xsl:text>

                </xsl:if>
                
                <xsl:if test="xs:union">
                  <xsl:value-of select="concat('Объединить с:{nbsp}', xs:union/@memberTypes)"/>
                  <xsl:text>
                
                  </xsl:text> 
                  <xsl:for-each select="*//*[name()='xs:restriction']">
                    <xsl:apply-templates select="."/>
                  </xsl:for-each>
                </xsl:if>

                <xsl:for-each select="xs:restriction">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            
        

    </xsl:template>
    <xsl:template match="xs:restriction">
        <xsl:if test="@base">
            
            <xsl:value-of select="concat('Базовый тип:{nbsp}', @base)"/>
            <xsl:text>
                
            </xsl:text>
        </xsl:if>
        <xsl:if test="xs:maxLength">
            
            <xsl:value-of select="concat('Максимальная длина:{nbsp}', xs:maxLength/@value)"/>
            <xsl:text>
                
            </xsl:text>
        </xsl:if>        
        <xsl:if test="xs:enumeration">
            <xsl:value-of>Список возможных значений:</xsl:value-of>
            
            <xsl:for-each select="xs:enumeration"><xsl:apply-templates select="."/></xsl:for-each>

        </xsl:if>
    </xsl:template>
    <xsl:template match="xs:enumeration">
        
        *  <xsl:value-of select="@value"/><xsl:if test="xs:annotation/xs:documentation"><xsl:value-of select="concat(' (', normalize-space(xs:annotation/xs:documentation/text())), ')'"/></xsl:if>
        
    </xsl:template>
    <xsl:template match="xs:unique">
        |
                <xsl:for-each
                    select="1 to count(ancestor::*[name() = 'xs:element' or name()='xs:all' or name()='xs:choice' or name()='xs:attribute']) +
                    count(ancestor::*[name() = 'xs:complexType' and @name])">
                    <xsl:value-of select="'{nbsp}{nbsp}{nbsp}'"/>
                </xsl:for-each>
                _<xsl:value-of select="concat('(уникальность)', '')"/>_
                    

            
        3+a|
                <xsl:value-of select="concat('Наименование: ', @name, '')"/>
                <xsl:text>&#xa;&#xa;</xsl:text>
                <xsl:value-of select="concat('Уникальные элементы: ', xs:selector/@xpath, '')"/>
                <xsl:text>&#xa;&#xa;</xsl:text>       
                <xsl:value-of select="concat('Признак уникальности: ', xs:field/@xpath, '')"/>
            
        

    </xsl:template>
</xsl:stylesheet>
