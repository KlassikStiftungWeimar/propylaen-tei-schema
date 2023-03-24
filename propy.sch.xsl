<?xml version="1.0" encoding="utf-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
   <title>ISO Schematron rules</title>
   <!-- This file generated 2023-03-24T12:54:44Z by 'extract-isosch.xsl'. -->
   <!-- ********************* -->
   <!-- namespaces, declared: -->
   <!-- ********************* -->
   <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
   <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
   <ns prefix="rng" uri="http://relaxng.org/ns/structure/1.0"/>
   <!-- ********************* -->
   <!-- namespaces, implicit: -->
   <!-- ********************* -->
   <!-- ************ -->
   <!-- constraints: -->
   <!-- ************ -->
   <pattern id="schematron-constraint-propy-att.datable.w3c-att-datable-w3c-when-1">
      <rule context="tei:*[@when]">
         <report test="@notBefore|@notAfter|@from|@to" role="nonfatal">The @when attribute cannot be used with any other att.datable.w3c attributes.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-att.datable.w3c-att-datable-w3c-from-2">
      <rule context="tei:*[@from]">
         <report test="@notBefore" role="nonfatal">The @from and @notBefore attributes cannot be used together.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-att.datable.w3c-att-datable-w3c-to-3">
      <rule context="tei:*[@to]">
         <report test="@notAfter" role="nonfatal">The @to and @notAfter attributes cannot be used together.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-att.datable-calendar-calendar-4">
      <rule context="tei:*[@calendar]">
         <assert test="string-length( normalize-space(.) ) gt 0"> @calendar indicates one or more
            systems or calendars to which the date represented by the content of this element belongs,
            but this <name/> element has no textual content.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-att.global.source-source-only_1_ODD_source-5">
      <rule context="tei:*[@source]">
         <let name="srcs" value="tokenize( normalize-space(@source),' ')"/>
         <report test="( self::tei:classRef               | self::tei:dataRef               | self::tei:elementRef               | self::tei:macroRef               | self::tei:moduleRef               | self::tei:schemaSpec )               and               $srcs[2]">
              When used on a schema description element (like
              <value-of select="name(.)"/>), the @source attribute
              should have only 1 value. (This one has <value-of select="count($srcs)"/>.)
            </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-att.measurement-att-measurement-unitRef-6">
      <rule context="tei:*[@unitRef]">
         <report test="@unit" role="info">The @unit attribute may be unnecessary when @unitRef is present.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-att.typed-subtypeTyped-7">
      <rule context="tei:*[@subtype]">
         <assert test="@type">The <name/> element should not be categorized in detail with @subtype unless also categorized in general with @type</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-att.pointing-targetLang-targetLang-8">
      <rule context="tei:*[not(self::tei:schemaSpec)][@targetLang]">
         <assert test="@target">@targetLang should only be used on <name/> if @target is specified.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-att.spanning-spanTo-spanTo-points-to-following-9">
      <rule context="tei:*[@spanTo]">
         <assert test="id(substring(@spanTo,2)) and following::*[@xml:id=substring(current()/@spanTo,2)]">
The element indicated by @spanTo (<value-of select="@spanTo"/>) must follow the current element <name/>
         </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-att.styleDef-schemeVersion-schemeVersionRequiresScheme-10">
      <rule context="tei:*[@schemeVersion]">
         <assert test="@scheme and not(@scheme = 'free')">
              @schemeVersion can only be used if @scheme is specified.
            </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-p-abstractModel-structure-p-in-ab-or-p-11">
      <rule context="tei:p">
         <report test="(ancestor::tei:ab or ancestor::tei:p) and not( ancestor::tei:floatingText |parent::tei:exemplum |parent::tei:item |parent::tei:note |parent::tei:q |parent::tei:quote |parent::tei:remarks |parent::tei:said |parent::tei:sp |parent::tei:stage |parent::tei:cell |parent::tei:figure )">
        Abstract model violation: Paragraphs may not occur inside other paragraphs or ab elements.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-p-abstractModel-structure-p-in-l-or-lg-12">
      <rule context="tei:p">
         <report test="(ancestor::tei:l or ancestor::tei:lg) and not( ancestor::tei:floatingText |parent::tei:figure |parent::tei:note )">
        Abstract model violation: Lines may not contain higher-level structural elements such as div, p, or ab, unless p is a child of figure or note, or is a descendant of floatingText.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-desc-deprecationInfo-only-in-deprecated-13">
      <rule context="tei:desc[ @type eq 'deprecationInfo']">
         <assert test="../@validUntil">Information about a
        deprecation should only be present in a specification element
        that is being deprecated: that is, only an element that has a
        @validUntil attribute should have a child &lt;desc
        type="deprecationInfo"&gt;.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-rt-target-rt-target-not-span-14">
      <rule context="tei:rt/@target">
         <report test="../@from | ../@to">When target= is
            present, neither from= nor to= should be.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-rt-from-rt-from-15">
      <rule context="tei:rt/@from">
         <assert test="../@to">When from= is present, the to=
            attribute of <name/> is required.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-rt-to-rt-to-16">
      <rule context="tei:rt/@to">
         <assert test="../@from">When to= is present, the from=
            attribute of <name/> is required.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-ptr-ptrAtts-17">
      <rule context="tei:ptr">
         <report test="@target and @cRef">Only one of the
attributes @target and @cRef may be supplied on <name/>.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-ref-refAtts-18">
      <rule context="tei:ref">
         <report test="@target and @cRef">Only one of the
	attributes @target' and @cRef' may be supplied on <name/>
         </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-list-gloss-list-must-have-labels-19">
      <rule context="tei:list[@type='gloss']">
         <assert test="tei:label">The content of a "gloss" list should include a sequence of one or more pairs of a label element followed by an item element</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-relatedItem-targetorcontent1-20">
      <rule context="tei:relatedItem">
         <report test="@target and count( child::* ) &gt; 0">
If the @target attribute on <name/> is used, the
relatedItem element must be empty</report>
         <assert test="@target or child::*">A relatedItem element should have either a 'target' attribute
        or a child element to indicate the related bibliographic item</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-l-abstractModel-structure-l-in-l-21">
      <rule context="tei:l">
         <report test="ancestor::tei:l[not(.//tei:note//tei:l[. = current()])]">
        Abstract model violation: Lines may not contain lines or lg elements.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-lg-atleast1oflggapl-22">
      <rule context="tei:lg">
         <assert test="count(descendant::tei:lg|descendant::tei:l|descendant::tei:gap) &gt; 0">An lg element
        must contain at least one child l, lg, or gap element.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-lg-abstractModel-structure-lg-in-l-23">
      <rule context="tei:lg">
         <report test="ancestor::tei:l[not(.//tei:note//tei:lg[. = current()])]">
        Abstract model violation: Lines may not contain line groups.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-quotation-quotationContents-24">
      <rule context="tei:quotation">
         <report test="not(@marks) and not (tei:p)">
On <name/>, either the @marks attribute should be used, or a paragraph of description provided</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-citeStructure-match-citestructure-outer-match-25">
      <rule context="tei:citeStructure[not(parent::tei:citeStructure)]">
         <assert test="starts-with(@match,'/')">An XPath in @match on the outer <name/> must start with '/'.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-citeStructure-match-citestructure-inner-match-26">
      <rule context="tei:citeStructure[parent::tei:citeStructure]">
         <assert test="not(starts-with(@match,'/'))">An XPath in @match must not start with '/' except on the outer <name/>.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-relation-reforkeyorname-27">
      <rule context="tei:relation">
         <assert test="@ref or @key or @name">One of the attributes  'name', 'ref' or 'key' must be supplied</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-relation-activemutual-28">
      <rule context="tei:relation">
         <report test="@active and @mutual">Only one of the attributes @active and @mutual may be supplied</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-relation-activepassive-29">
      <rule context="tei:relation">
         <report test="@passive and not(@active)">the attribute 'passive' may be supplied only if the attribute 'active' is supplied</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-catchwords-catchword_in_msDesc-30">
      <rule context="tei:catchwords">
         <assert test="ancestor::tei:msDesc or ancestor::tei:egXML">The <name/> element should not be used outside of msDesc.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-dimensions-duplicateDim-31">
      <rule context="tei:dimensions">
         <report test="count(tei:width)&gt; 1">
The element <name/> may appear once only
      </report>
         <report test="count(tei:height)&gt; 1">
The element <name/> may appear once only
      </report>
         <report test="count(tei:depth)&gt; 1">
The element <name/> may appear once only
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-secFol-secFol_in_msDesc-32">
      <rule context="tei:secFol">
         <assert test="ancestor::tei:msDesc or ancestor::tei:egXML">The <name/> element should not be used outside of msDesc.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-signatures-signatures_in_msDesc-33">
      <rule context="tei:signatures">
         <assert test="ancestor::tei:msDesc or ancestor::tei:egXML">The <name/> element should not be used outside of msDesc.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-msIdentifier-msId_minimal-34">
      <rule context="tei:msIdentifier">
         <report test="not(parent::tei:msPart) and (local-name(*[1])='idno' or local-name(*[1])='altIdentifier' or normalize-space(.)='')">An msIdentifier must contain either a repository or location.</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-facsimile-no_facsimile_text_nodes-35">
      <rule context="tei:facsimile//tei:line | tei:facsimile//tei:zone">
         <report test="child::text()[ normalize-space(.) ne '']">
  	  A facsimile element represents a text with images, thus
	  transcribed text should not be present within it.
	</report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-path-pathmustnotbeclosed-36">
      <rule context="tei:path[@points]">
         <let name="firstPair" value="tokenize( normalize-space( @points ), ' ')[1]"/>
         <let name="lastPair"
              value="tokenize( normalize-space( @points ), ' ')[last()]"/>
         <let name="firstX" value="xs:float( substring-before( $firstPair, ',') )"/>
         <let name="firstY" value="xs:float( substring-after( $firstPair, ',') )"/>
         <let name="lastX" value="xs:float( substring-before( $lastPair, ',') )"/>
         <let name="lastY" value="xs:float( substring-after( $lastPair, ',') )"/>
         <report test="$firstX eq $lastX and $firstY eq $lastY">The first and
          last elements of this path are the same. To specify a closed polygon, use
          the zone element rather than the path element. </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-addSpan-addSpan-requires-spanTo-37">
      <rule context="tei:addSpan">
         <assert test="@spanTo">The @spanTo attribute of <name/> is required.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-damageSpan-damageSpan-requires-spanTo-39">
      <rule context="tei:damageSpan">
         <assert test="@spanTo">The @spanTo attribute of <name/> is required.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-delSpan-delSpan-requires-spanTo-41">
      <rule context="tei:delSpan">
         <assert test="@spanTo">The @spanTo attribute of <name/> is required.</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-subst-substContents1-43">
      <rule context="tei:subst">
         <assert test="child::tei:add and (child::tei:del or child::tei:surplus)">
            <name/> must have at least one child add and at least one child del or surplus</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-div-abstractModel-structure-div-in-l-or-lg-46">
      <rule context="tei:div">
         <report test="(ancestor::tei:l or ancestor::tei:lg) and not(ancestor::tei:floatingText)">
        Abstract model violation: Lines may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-div-abstractModel-structure-div-in-ab-or-p-47">
      <rule context="tei:div">
         <report test="(ancestor::tei:p or ancestor::tei:ab) and not(ancestor::tei:floatingText)">
        Abstract model violation: p and ab may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-link-linkTargets3-48">
      <rule context="tei:link">
         <assert test="contains(normalize-space(@target),' ')">You must supply at least two values for @target or  on <name/>
         </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-ab-abstractModel-structure-ab-in-l-or-lg-49">
      <rule context="tei:ab">
         <report test="(ancestor::tei:l or ancestor::tei:lg) and not( ancestor::tei:floatingText |parent::tei:figure |parent::tei:note )">
        Abstract model violation: Lines may not contain higher-level divisions such as p or ab, unless ab is a child of figure or note, or is a descendant of floatingText.
      </report>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-join-joinTargets3-50">
      <rule context="tei:join">
         <assert test="contains(@target,' ')">
You must supply at least two values for @target on <name/>
         </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-standOff-nested_standOff_should_be_typed-51">
      <rule context="tei:standOff">
         <assert test="@type or not(ancestor::tei:standOff)">This
      <name/> element must have a @type attribute, since it is
      nested inside a <name/>
         </assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-rdgGrp-only1lem-52">
      <rule context="tei:rdgGrp">
         <assert test="count(tei:lem) &lt; 2">Only one &lt;lem&gt; element may appear within a &lt;rdgGrp&gt;</assert>
      </rule>
   </pattern>
   <pattern id="schematron-constraint-propy-variantEncoding-location-variantEncodingLocation-53">
      <rule context="tei:variantEncoding">
         <report test="@location eq 'external' and @method eq 'parallel-segmentation'">
              The @location value "external" is inconsistent with the
              parallel-segmentation method of apparatus markup.</report>
      </rule>
   </pattern>
</schema>
