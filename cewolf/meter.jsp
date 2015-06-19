<%@page contentType="text/html"%>
<%@taglib uri="http://cewolf.sourceforge.net/taglib/cewolf.tld" prefix="cewolf" %>
<%@page import="java.awt.*" %>
<%@page import="java.util.*"%>
<%@page import="de.laures.cewolf.*"%>
<%@page import="de.laures.cewolf.cpp.*"%>
<%@page import="de.laures.cewolf.example.MeterPostProcessor"%>
<%@page import="de.laures.cewolf.taglib.CewolfChartFactory" %>
<%@page import="de.laures.cewolf.tooltips.*"%>
<%@page import="org.jfree.chart.*"%>
<%@page import="org.jfree.chart.plot.*"%>
<%@page import="org.jfree.data.*"%>
<%@page import="org.jfree.data.category.*"%>
<%@page import="org.jfree.data.general.*"%>
<%
	DatasetProducer valueDatasetProducer = new DatasetProducer() {
		public Object produceDataset (Map params) throws DatasetProduceException {
			Integer val = new Integer(60);
			DefaultValueDataset data = new DefaultValueDataset(val);
			return data;
		}

		public boolean hasExpired (Map params, Date since) { return false; }

		public String getProducerId() { return "meterdata"; }
	};

	pageContext.setAttribute("meterData", valueDatasetProducer);

	DatasetProducer waferDatasetProducer = new DatasetProducer() {

		public Object produceDataset (Map params) throws DatasetProduceException {
			WaferMapDataset data = new WaferMapDataset(10, 10);
			data.addValue(1, 5, 4);
			data.addValue(1, 5, 3);
			data.addValue(1, 5, 2);
			data.addValue(1, 5, 1);
			data.addValue(22, 5, 0);
			data.addValue(22, 5, 9);
			data.addValue(22, 5, 8);
			data.addValue(22, 5, 7);
			data.addValue(22, 5, 6);
			data.addValue(1, 6, 0);
			data.addValue(1, 7, 0);
			data.addValue(1, 8, 0);
			data.addValue(1, 9, 0);
		/*
		*/

		/*
			WaferMapDataset data = new WaferMapDataset(30, 20);
			data.addValue(1, 5, 14);
			data.addValue(1, 5, 13);
			data.addValue(1, 5, 12);
			data.addValue(1, 5, 11);
			data.addValue(1, 5, 10);
			data.addValue(1, 5, 9);
			data.addValue(7, 5, 8);
			data.addValue(8, 5, 7);
			data.addValue(9, 5, 6);
			data.addValue(1, 6, 10);
			data.addValue(1, 7, 10);
			data.addValue(1, 8, 10);
			data.addValue(1, 9, 10);
			data.addValue(1, 10, 10);
			data.addValue(1, 11, 10);
			data.addValue(1, 11, 11);
			data.addValue(1, 11, 12);
			data.addValue(2, 11, 13);
			data.addValue(1, 11, 14);
			data.addValue(2, 11, 9);
			data.addValue(2, 11, 8);
			data.addValue(2, 11, 7);
			data.addValue(2, 11, 6);

			data.addValue(6, 16, 6);
			data.addValue(6, 17, 6);
			data.addValue(6, 18, 6);
			data.addValue(6, 19, 6);
			data.addValue(6, 20, 6);
			data.addValue(6, 21, 6);
			data.addValue(6, 22, 6);
			data.addValue(3, 19, 7);
			data.addValue(3, 19, 8);
			data.addValue(3, 19, 9);
			data.addValue(3, 19, 10);
			data.addValue(3, 19, 11);
			data.addValue(3, 19, 12);
			data.addValue(3, 19, 13);
			data.addValue(4, 19, 14);
			data.addValue(4, 18, 14);
			data.addValue(4, 17, 14);
			data.addValue(4, 16, 14);
			data.addValue(4, 20, 14);
			data.addValue(4, 21, 14);
			data.addValue(4, 22, 14);
		*/

			return data;
		}

		public boolean hasExpired (Map params, Date since) { return false; }

		public String getProducerId() { return "waferdata"; }
	};

	pageContext.setAttribute("waferData", waferDatasetProducer);

	DatasetProducer categoryData = new DatasetProducer() {
		public Object produceDataset(Map params) {
			final String[] categories = { "apples", "pies", "bananas", "oranges" };
			final String[] seriesNames = { "Peter", "Helga", "Franz", "Olga" };
			final Integer[][] startValues = new Integer[seriesNames.length][categories.length];
			final Integer[][] endValues = new Integer[seriesNames.length][categories.length];
			for (int series = 0; series < seriesNames.length; series++) {
				for (int i = 0; i < categories.length; i++) {
					int y = (int) (Math.random() * 10 + 1);
					startValues[series][i] = new Integer(y);
					endValues[series][i] = new Integer(y + (int) (Math.random() * 10));
				}
			}
			DefaultIntervalCategoryDataset ds = new DefaultIntervalCategoryDataset(seriesNames, categories, startValues, endValues);
			return ds;
		}

		public String getProducerId() {
			return "CategoryDataProducer";
		}

		public boolean hasExpired(Map params, Date since) {
			return false;
		}
	};
	pageContext.setAttribute("categoryData", categoryData);
%>
<html>
<head>
	<link href="cewolf.css" rel="stylesheet" type="text/css">
</head>
<BODY bgcolor="#DDE8F2">
<TABLE>
<TR>
<TD>
<H1>Spider web chart</H1>
<P>
<jsp:useBean id="spiderWebEnhancer" class="de.laures.cewolf.cpp.SpiderWebEnhancer" />

<jsp:useBean id="legendEnhancer" class="de.laures.cewolf.cpp.LegendEnhancer" />

<jsp:useBean id="seriesPaint" class="de.laures.cewolf.cpp.SeriesPaintProcessor" />

<cewolf:chart id="spiderWebChart" title="SpiderWebChart" type="spiderweb" plotbackgroundcolor="#FFFFFF">
    <cewolf:data>
        <cewolf:producer id="categoryData" />
    </cewolf:data>
    <cewolf:chartpostprocessor id="spiderWebEnhancer">
        <cewolf:param name="interiorGap" value="0.25"/>
        <cewolf:param name="headPercent" value="0.02"/>
        <cewolf:param name="startAngle" value="0"/>
        <cewolf:param name="webFilled" value="true"/>
        <cewolf:param name="clockWise" value="true"/>
        <cewolf:param name="orderByRow" value="false"/>
        <cewolf:param name="labelPaint" value="#0000FF"/>
        <cewolf:param name="labelFontName" value="SansSerif"/>
        <cewolf:param name="labelFontSize" value="12"/>
        <cewolf:param name="labelBold" value="false"/>
        <cewolf:param name="labelItalic" value="false"/>
    </cewolf:chartpostprocessor>

	<cewolf:chartpostprocessor id="legendEnhancer">
		<cewolf:param name="fontname" value="Serif" />
		<cewolf:param name="fontsize" value="16" />
		<cewolf:param name="bold" value="false" />
		<cewolf:param name="italic" value="true" />
		<cewolf:param name="paint" value="#111111" />
		<cewolf:param name="backgroundpaint" value="#EEEEEE" />
		<cewolf:param name="top" value="10" />
		<cewolf:param name="left" value="5" />
		<cewolf:param name="right" value="5" />
		<cewolf:param name="bottom" value="10" />
	</cewolf:chartpostprocessor>

<%--
    <cewolf:chartpostprocessor id="seriesPaint">
        <cewolf:param name="0" value="#FFFFAA"/>
        <cewolf:param name="1" value="#AAFFAA"/>
        <cewolf:param name="2" value="#FFAAFF"/>
        <cewolf:param name="3" value="#FFAAAA"/>
    </cewolf:chartpostprocessor>
--%>
</cewolf:chart>
<cewolf:img chartid="spiderWebChart" renderer="/cewolf" removeAfterRender="true" width="300" height="300"/>
</TD>
<TD>
<H1>Wafer map chart</H1>
<P>

<jsp:useBean id="waferMapLegend" class="de.laures.cewolf.cpp.WaferMapLegendProcessor" />

<jsp:useBean id="subTitle" class="de.laures.cewolf.cpp.TitleEnhancer" />

<cewolf:chart id="waferMapChart" title="WaferMapChart" type="wafer" showlegend="true" legendanchor="east" plotbackgroundcolor="#FFFFFF">
    <cewolf:data>
        <cewolf:producer id="waferData" />
    </cewolf:data>
	<cewolf:chartpostprocessor id="waferMapLegend">
		<cewolf:param name="valign" value="bottom" />
		<cewolf:param name="showCellValues" value="true" />
		<cewolf:param name="#14ff1a" value="one" />
		<cewolf:param name="#ff0000" value="two" />
		<cewolf:param name="#ff00fe" value="three" /> 
		<cewolf:param name="#7640ff" value="four" /> 
		<cewolf:param name="#4896ff" value="five" /> 
		<cewolf:param name="#d29428" value="six" />
		<cewolf:param name="#ffd0d4" value="seven" />
		<cewolf:param name="#9c0c1e" value="eight" />
	</cewolf:chartpostprocessor> 

	<cewolf:chartpostprocessor id="subTitle">
		<cewolf:param name="type" value="title" />
		<%--
		<cewolf:param name="title" value="My,Important,Title" />
		<cewolf:param name="fontname" value="Serif" />
		<cewolf:param name="paint" value="#FF8800" />
		<cewolf:param name="backgroundpaint" value="#0088FF" />
		<cewolf:param name="bold" value="false" />
		<cewolf:param name="talign" value="center" />
		--%>
		<cewolf:param name="fontsize" value="24" />
		<cewolf:param name="italic" value="true" />
		<cewolf:param name="halign" value="left" />
		<cewolf:param name="position" value="top" />
	</cewolf:chartpostprocessor> 

	<cewolf:chartpostprocessor id="subTitle">
		<cewolf:param name="type" value="subtitle" />
		<cewolf:param name="fontsize" value="14" />
		<cewolf:param name="title" value="italic subtitle" />
		<cewolf:param name="italic" value="true" />
		<cewolf:param name="halign" value="center" />
	</cewolf:chartpostprocessor> 

	<cewolf:chartpostprocessor id="subTitle">
		<cewolf:param name="type" value="subtitle" />
		<cewolf:param name="fontsize" value="14" />
		<cewolf:param name="title" value="subtitle on the right" />
		<cewolf:param name="halign" value="right" />
	</cewolf:chartpostprocessor> 

</cewolf:chart>
<cewolf:img chartid="waferMapChart" renderer="/cewolf" removeAfterRender="true" width="300" height="300"/>
</TD>
</TR>
</TABLE>

<HR>

<H1>Various meter charts</H1>
<P>

<jsp:useBean id="meterPP" class="de.laures.cewolf.cpp.MeterEnhancer" scope="page" />
<jsp:useBean id="meterRanges" class="de.laures.cewolf.example.MeterPostProcessor" />

<cewolf:chart id="meterChart" title="Speed" type="meter" showlegend="false"
				bordervisible="true" bordercolor="#000000" backgroundcolor="#4488CC">
    <cewolf:data>
        <cewolf:producer id="meterData" />
    </cewolf:data>
	<cewolf:chartpostprocessor id="meterPP">
        <cewolf:param name="units" value="furlongs/fortnight"/>
        <cewolf:param name="backgroundColor" value="#000000"/>
        <cewolf:param name="valueColor" value="#888888"/>
        <cewolf:param name="meterColor" value="#FFFFFF"/>
	</cewolf:chartpostprocessor>
   <cewolf:chartpostprocessor id="meterRanges"/>
</cewolf:chart>
<cewolf:img chartid="meterChart" renderer="/cewolf" removeAfterRender="true" width="300" height="300" />

<jsp:useBean id="thermometerPP" class="de.laures.cewolf.cpp.ThermometerEnhancer" scope="page" />

<cewolf:chart id="thermometerChart" title="Temperature" type="thermometer">
    <cewolf:data>
        <cewolf:producer id="meterData" />
    </cewolf:data>
	<cewolf:chartpostprocessor id="thermometerPP">
        <cewolf:param name="units" value="fahrenheit"/>
        <cewolf:param name="mercuryColor" value="#00CCCC"/>
        <cewolf:param name="valueColor" value="#FFFFFF"/>
        <cewolf:param name="thermometerColor" value="#000000"/>
        <cewolf:param name="lowerBound" value="20"/>
        <cewolf:param name="warningPoint" value="50"/>
        <cewolf:param name="criticalPoint" value="90"/>
        <cewolf:param name="upperBound" value="100"/>
		<cewolf:param name="useSubrangePaint" value="true" />
		<cewolf:param name="subrangeIndicatorsVisible" value="true" />
		<%--
        <cewolf:param name="subrangeColorNormal" value="#00FF00"/>
        <cewolf:param name="subrangeColorWarning" value="#FFC800"/>
        <cewolf:param name="subrangeColorCritical" value="#FF0000"/>
		--%>
	</cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="thermometerChart" renderer="/cewolf" removeAfterRender="true" width="300" height="300" />

<P>

<jsp:useBean id="compassPP" class="de.laures.cewolf.cpp.CompassEnhancer" scope="page" />

<cewolf:chart id="compassChart" title="Wind" type="compass">
    <cewolf:data>
        <cewolf:producer id="meterData" />
    </cewolf:data>
	<cewolf:chartpostprocessor id="compassPP">
        <cewolf:param name="needleType" value="arrow"/>
        <cewolf:param name="needleFill" value="#FF0000"/>
        <cewolf:param name="needleOutline" value="#FFFFFF"/>
        <cewolf:param name="drawBorder" value="false"/>
	</cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="compassChart" renderer="/cewolf" removeAfterRender="true" width="300" height="300" />


<jsp:useBean id="dialPP" class="de.laures.cewolf.cpp.DialEnhancer" scope="page" />

<cewolf:chart id="dialChart" title="Speed" type="dial">
    <cewolf:data>
        <cewolf:producer id="meterData" />
    </cewolf:data>
   <cewolf:chartpostprocessor id="dialPP">
        <cewolf:param name="pointerType" value="pin"/>
        <cewolf:param name="dialText" value="some text"/>
		<%--
        <cewolf:param name="capRadius" value="0.1"/>
        <cewolf:param name="capFill" value="#336699"/>
        <cewolf:param name="capOutline" value="#99BBDD"/>
		--%>
        <cewolf:param name="lowerBound" value="0"/>
        <cewolf:param name="upperBound" value="100"/>
        <cewolf:param name="majorTickIncrement" value="10"/>
        <cewolf:param name="minorTickCount" value="4"/>
	</cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="dialChart" renderer="/cewolf" removeAfterRender="true" width="300" height="300" />
</body>
</html>
