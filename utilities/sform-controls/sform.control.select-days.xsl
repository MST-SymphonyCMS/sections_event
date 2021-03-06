<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:exsl="http://exslt.org/common"
		xmlns:sform="http://xanderadvertising.com/xslt"
		extension-element-prefixes="exsl sform">




	<!--
		Name: sform:select-days
		Description: Renders an HTML `select` element populated with numbers from 1 to 31
		Returns: HTML <select> element
		Parameters:

		***** Identification *****
		* `event` (optional, string): The Event powering the form.
		* `prefix` (optional, string): The prefix that will hold all form data.
		* `section` (optional, string): The section to where data should be sent.
		* `position` (optional, string): Index of this entry in a multiple entries situation. Leave empty if not needed.
		* `handle` (mandatory, string): Handle of the field.
		* `suffix` (optional, string): An xPath like string for more flexibility.

		***** Validation *****
		* `interpretation` (optional, XML node-set): An XML with the validation of the form
		* `interpretation-el` (optional, XML node-set): An XML with the validation for this field

		***** Element data *****
		* `value` (optional, string): The value sent when the form is submitted.
		* `attributes` (optional, node set): Other attributes for this element.
		* `label-enabled` (optional, string): Switch to enable / disable $label
		* `label` (optional, string): Label to appear as first option
		* `options` (optional, HTML): Actual options to be displayed
	-->
	<xsl:template name="sform:select-days">
		<!-- Identification -->
		<xsl:param name="event" select="$sform:event"/>
		<xsl:param name="prefix" select="$sform:prefix"/>
		<xsl:param name="section" select="$sform:section"/>
		<xsl:param name="position" select="$sform:position"/>
		<xsl:param name="handle"/>
		<xsl:param name="suffix" select="$sform:suffix"/>

		<!-- Validation -->
		<xsl:param name="interpretation">
			<xsl:call-template name="sform:validation-interpret">
				<xsl:with-param name="event" select="$event"/>
				<xsl:with-param name="prefix" select="$prefix"/>
				<xsl:with-param name="section" select="$section"/>
				<xsl:with-param name="position" select="$position"/>
				<xsl:with-param name="fields-sel">
					<xsl:call-template name="sform:validation-tpl-sel">
						<xsl:with-param name="handle" select="$handle"/>
						<xsl:with-param name="extMode" select="'update'"/>
						<xsl:with-param name="suffix" select="$suffix"/>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="interpretation-el" select="exsl:node-set($interpretation)/fields/item[ @handle = $handle ]"/>

		<!-- Element data -->
		<xsl:param name="value" select="''"/>
		<xsl:param name="attributes" select="''"/>
		<xsl:param name="label-enabled" select="false()"/>
		<xsl:param name="label" select="'Day'"/>
		<xsl:param name="options">
			<xsl:if test="$label-enabled = true()">
				<option value="">
					<xsl:value-of select="$label"/>
				</option>
			</xsl:if>
			<xsl:call-template name="sform:incrementor">
				<xsl:with-param name="start" select="'1'"/>
				<xsl:with-param name="iterations" select="31"/>
			</xsl:call-template>
		</xsl:param>

		<xsl:call-template name="sform:select-base">
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="prefix" select="$prefix"/>
			<xsl:with-param name="section" select="$section"/>
			<xsl:with-param name="position" select="$position"/>
			<xsl:with-param name="handle" select="$handle"/>
			<xsl:with-param name="suffix" select="$suffix"/>

			<xsl:with-param name="interpretation" select="$interpretation"/>
			<xsl:with-param name="interpretation-el" select="$interpretation-el"/>

			<xsl:with-param name="value" select="$value"/>
			<xsl:with-param name="options" select="$options"/>
			<xsl:with-param name="attributes" select="$attributes"/>
		</xsl:call-template>
	</xsl:template>




</xsl:stylesheet>
