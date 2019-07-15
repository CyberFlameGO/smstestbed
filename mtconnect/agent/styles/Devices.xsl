<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:m="urn:mtconnect.org:MTConnectDevices:1.3" >
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<head>
			<title>NIST SMS Test Bed: Volatile Data Stream</title>
			<meta name="Description" id="Description" content="Test Web Page"/>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
			<meta name="Keywords" id="Keywords" content="manufacturing, data, MTConnect, QIF, design"/>
			<link rel="stylesheet" href="https://pages.nist.gov/nist-header-footer/css/nist-combined.css"/>
			<xsl:text disable-output-escaping="yes">
				<![CDATA[
					<script src="https://pages.nist.gov/nist-header-footer/js/jquery-1.9.0.min.js" type="text/javascript" defer="defer"></script> 
					<script src="https://pages.nist.gov/nist-header-footer/js/nist-header-footer.js" type="text/javascript" defer="defer"></script> 
					<!-- DAP Analytics --> 
					<script type="text/javascript" id="_fed_an_ua_tag" src="https://dap.digitalgov.gov/Universal-Federated-Analytics-Min.js?agency=DOC&subagency=NIST&pua=UA-102226507-7&yt=true&exts=ppsx,pps,f90,sch,rtf,wrl,txz,m1v,xlsm,msi,xsd,f,tif,eps,mpg,xml,pl,xlt,c"></script>
				]]>
			</xsl:text>
		</head>

		<body>
		<div id="main" class="nist-main">
			<div id="mtconnect content" style="padding: 0px 30px 30px 30px;">
				<p>
				<!-- <img src="/SMS-Testbed_logo.png" width="600" height="129"></img> -->
				<h1>Smart Manufacturing Systems Test Bed</h1>

				<h2>Volatile Data Stream: Devices</h2>
				</p>
				<p>
					You are viewing the Volatile Data Stream (VDS) component of the NIST Smart Manufacturing Systems (SMS) Test Bed located in Gaithersburg MD USA. Please visit the <a href="http://smstestbed.nist.gov" target="_blank">SMS Test Bed Information Page</a> for more information.
				</p>
				<p>
					<xsl:apply-templates select="/m:MTConnectDevices/m:Header" />
				</p>
				<hr/>
				<xsl:apply-templates select="/m:MTConnectDevices/m:Devices/m:Device" />
				<p>	Date created: March 17, 2016 | Last updated: November 21, 2018 | Contact: <a href="mailto:smstestbed@nist.gov" class="bold">SMS Test Bed Coordinators</a></p>
			</div>
		</div>
		</body>
	</xsl:template>
	
	<xsl:template match="m:Device">
		<h2>Device: <xsl:value-of select="@name"/>
		<xsl:text>; UUID: </xsl:text><xsl:value-of select="@uuid"/>
		</h2>
		<xsl:apply-templates select="m:Description"/>
		<xsl:apply-templates select="m:DataItems"/>
		<xsl:apply-templates select="m:Components">
			<xsl:with-param name="depth" select="1" />
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="m:Header">
		<ul>
			<xsl:for-each select="@*">
				<li>
					<xsl:value-of select="name()"/>
					<xsl:text>: </xsl:text>
					<xsl:value-of select="." />
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template match="m:Description">
		<ul>
			<xsl:for-each select="@*">
				<li>
					<xsl:value-of select="name()"/>
					<xsl:text>: </xsl:text>
					<xsl:value-of select="." />
				</li>
			</xsl:for-each>
			<li><xsl:value-of select="text()"/></li>
		</ul>		
	</xsl:template>
	
	<xsl:template match="m:DataItems">
		<table class="data-item">
			<thead>
				<tr><th>Category</th><th>Type</th><th>Sub Type</th><th>Id</th><th>Name</th>
					 <th>Units</th><th>Native Units</th><th>Representation</th><th>Sample Rate</th><th>Native Scale</th><th>Statistic</th></tr>
			</thead>
			<tbody>				
				<xsl:for-each select="./m:DataItem">
					<tr>
						<td><xsl:value-of select="@category" /></td>
						<td><xsl:value-of select="@type" /></td>
						<td><xsl:value-of select="@subType" /></td>
						<td><xsl:value-of select="@id" /></td>
						<td><xsl:value-of select="@name" /></td>
						<td><xsl:value-of select="@units" /></td>
						<td><xsl:value-of select="@nativeUnits" /></td>
						<td><xsl:value-of select="@representation" /></td>
						<td><xsl:value-of select="@sampleRate" /></td>
						<td><xsl:value-of select="@nativeScale" /></td>
						<td><xsl:value-of select="@statistic" /></td>
					</tr>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
	
	<xsl:template match="m:Components">
		<xsl:param name="depth"/>
		<ul>
			<xsl:for-each select="./*">
				<li>
					<h3><xsl:value-of select="name()"/><xsl:text>: </xsl:text><xsl:value-of select="@name" /><xsl:text> (</xsl:text><xsl:value-of select="@nativeName"/><xsl:text>)</xsl:text></h3>
					<xsl:apply-templates select="m:Description"/>
					<xsl:apply-templates select="m:DataItems"/>
					<xsl:apply-templates select="m:Components">
						<xsl:with-param name="depth" select="$depth+1" />
					</xsl:apply-templates>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
</xsl:stylesheet>
