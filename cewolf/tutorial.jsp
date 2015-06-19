<%@page contentType="text/html"%>
<%@page import="de.laures.cewolf.ChartPostProcessor"%>
<%@taglib uri="http://cewolf.sourceforge.net/taglib/cewolf.tld" prefix="cewolf" %>
<HTML>
<HEAD>
<TITLE>Cewolf Tutorial - Step 1</TITLE>
<link href="cewolf.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY bgcolor="#DDE8F2">
<H1>Cewolf Tutorial</H1>
<H2>A Simple Page View Statistics Chart</H2>
<HR>
This page shows the resulting chart when finishing the Cewolf tutorial on the <a href="http://cewolf.sourceforge.net">Cewolf homepage</a>.<p>

<jsp:useBean id="pageViews" class="de.laures.cewolf.example.PageViewCountData"/>

<jsp:useBean id="lineRenderer" class="de.laures.cewolf.cpp.LineRendererProcessor" />

<jsp:useBean id="visualEnhancer" class="de.laures.cewolf.cpp.VisualEnhancer" />

<jsp:useBean id="legendItems" class="de.laures.cewolf.example.LegendItemPostProcessor" />

<cewolf:chart 
    id="line" 
    title="Page View Statistics" 
    type="line" 
    xaxislabel="Page" 
    yaxislabel="Views">
    <cewolf:data>
        <cewolf:producer id="pageViews"/>
    </cewolf:data>
	<cewolf:chartpostprocessor id="lineRenderer">
		<cewolf:param name="shapes" value="true" />
		<cewolf:param name="outline" value="true" />
		<cewolf:param name="useFillPaint" value="true" />
		<cewolf:param name="fillPaint" value="#FFFFFF" />
		<cewolf:param name="useOutlinePaint" value="true" />
		<cewolf:param name="outlinePaint" value="#000000" />
	</cewolf:chartpostprocessor>
	<%--
    <cewolf:chartpostprocessor id="visualEnhancer">
        <cewolf:param name="border" value="false"/>
        <cewolf:param name="rangeIncludesZero" value="false"/>
    </cewolf:chartpostprocessor>
	--%>
    <cewolf:chartpostprocessor id="legendItems">
        <cewolf:param name="0" value="#FF0000"/>
        <cewolf:param name="1" value="#FF0000"/>
        <cewolf:param name="2" value="#FF0000"/>
        <cewolf:param name="3" value="#FF0000"/>
    </cewolf:chartpostprocessor>
	<%--
	--%>
</cewolf:chart>
<p>
<cewolf:img chartid="line" renderer="/cewolf" removeAfterRender="true" width="500" height="400">
    <cewolf:map linkgeneratorid="pageViews" tooltipgeneratorid="pageViews"/>
</cewolf:img>
</BODY>
</HTML>

