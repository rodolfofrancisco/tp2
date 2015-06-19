<%@page contentType="text/html"%>
<%@taglib uri="http://cewolf.sourceforge.net/taglib/cewolf.tld" prefix="cewolf" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.*"%>
<%@page import="de.laures.cewolf.DatasetProducer"%>
<%@page import="org.jfree.data.category.DefaultIntervalCategoryDataset"%>
<%@page import="org.jfree.data.xy.XYSeries, org.jfree.data.xy.XYSeriesCollection"%>
<%
	DatasetProducer categoryData = new DatasetProducer() {
		final String[] categories = { "apples", "pies", "bananas", "oranges" };
		final String[] seriesNames = { "Peter", "Helga", "Franz", "Olga" };
		final Integer[][] startValues = new Integer[seriesNames.length][categories.length];
		final Integer[][] endValues = new Integer[seriesNames.length][categories.length];

		public Object produceDataset(Map params) {
		  for (int series = 0; series < seriesNames.length; series++) {
			for (int i = 0; i < categories.length; i++) {
			  int y = (int) (Math.random() * 5 + 5);
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

	DatasetProducer xyData = new DatasetProducer() {
		public Object produceDataset(Map params) {
			final double[] yValues = { 2.0, 1.0, -0.5, 0.5, -1.0, 0.0, 1.0 };

			XYSeries xys1 = new XYSeries("Example XY Dataset 1");
			XYSeries xys2 = new XYSeries("Example XY Dataset 2");
			double x = -3.0;
			for (int i = 0; i < yValues.length; i++) {
				xys1.add(x+i, yValues[i]);
				xys2.add(x+i, 1.5 * yValues[i]);
			}

		  XYSeriesCollection data =  new XYSeriesCollection();
		  data.addSeries(xys1);
		  //data.addSeries(xys2);

		  return data;
		}
		public String getProducerId() {
		  return "XYDataProducer";
		}
		public boolean hasExpired(Map params, Date since) {
		  return false;
		}
	};
	pageContext.setAttribute("xyData", xyData);
	// In proper code, x and y would be put into the context by the servlet
	// This just demonstrates that the attribute values can be dynamic.
	pageContext.setAttribute("x", "0");
	pageContext.setAttribute("y", "0.5");
%>

<jsp:useBean id="annotation" class="de.laures.cewolf.cpp.AnnotationProcessor" />

<jsp:useBean id="lineRenderer" class="de.laures.cewolf.cpp.LineRendererProcessor" />

<jsp:useBean id="labelRotation" class="de.laures.cewolf.cpp.RotatedAxisLabels" />

<html>
<head>
	<link href="cewolf.css" rel="stylesheet" type="text/css">
</head>
<BODY bgcolor="#DDE8F2">
<cewolf:chart id="horizontalBarChart" type="horizontalBar" title="Category plot">
    <cewolf:data>
        <cewolf:producer id="categoryData" />
    </cewolf:data>

	<cewolf:chartpostprocessor id="annotation">
        <cewolf:param name="text" value="Apples are good"/>
        <cewolf:param name="category" value="apples"/>
        <cewolf:param name="value" value="15"/>
        <cewolf:param name="textAnchor" value="CENTER_RIGHT"/>
    </cewolf:chartpostprocessor>
	<cewolf:chartpostprocessor id="annotation">
        <cewolf:param name="text" value="Pies as well"/>
        <cewolf:param name="category" value="pies"/>
        <cewolf:param name="value" value="15"/>
        <cewolf:param name="textAnchor" value="CENTER_RIGHT"/>
    </cewolf:chartpostprocessor>
	<cewolf:chartpostprocessor id="annotation">
        <cewolf:param name="text" value="Bananas are so-so"/>
        <cewolf:param name="category" value="bananas"/>
        <cewolf:param name="value" value="15"/>
        <cewolf:param name="textAnchor" value="CENTER_RIGHT"/>
    </cewolf:chartpostprocessor>
	<cewolf:chartpostprocessor id="annotation">
        <cewolf:param name="text" value="Oranges somewhat less so"/>
        <cewolf:param name="category" value="oranges"/>
        <cewolf:param name="value" value="15"/>
        <cewolf:param name="textAnchor" value="CENTER_RIGHT"/>
    </cewolf:chartpostprocessor>

	<cewolf:chartpostprocessor id="labelRotation">
		<cewolf:param name="rotate_at" value="1"/>
		<cewolf:param name="remove_at" value="50"/>
	</cewolf:chartpostprocessor> 
</cewolf:chart>
<cewolf:img chartid="horizontalBarChart" renderer="/cewolf" removeAfterRender="true" width="400" height="400"/>
<HR>
Demonstrates annotations, and the use of conditions for showing point shapes (outlined or not)
<P>
<cewolf:chart id="XYChart" title="X/Y plot with spline interpolation" type="spline" xaxisinteger="true" yaxisinteger="true">
    <cewolf:data>
        <cewolf:producer id="xyData" />
    </cewolf:data>

    <cewolf:chartpostprocessor id="lineRenderer">
        <cewolf:param name="shapes" value="true"/>
        <cewolf:param name="outline" value="false"/>

		<%--
        <cewolf:param name="useFillPaint" value="true"/>
        <cewolf:param name="fillPaint" value="#112233"/>
		--%>

		<%--
        <cewolf:param name="useOutlinePaint" value="true"/>
        <cewolf:param name="outlinePaint" value="#FFFFFF"/>
		--%>

		<%--
        <cewolf:param name="shapeVisibleCondition" value="and(x>=0, y>=0)"/>
        <cewolf:param name="shapeFilledCondition" value="and(x>0, y>0)"/>
		--%>
    </cewolf:chartpostprocessor>

    <cewolf:chartpostprocessor id="annotation">
        <cewolf:param name="text" value="It starts here OK"/>
        <cewolf:param name="x" value="-2.8"/>
        <cewolf:param name="y" value="2.0"/>
        <cewolf:param name="textAnchor" value="CENTER_LEFT"/>
    </cewolf:chartpostprocessor>

    <cewolf:chartpostprocessor id="annotation">
        <cewolf:param name="text" value="But look at this!"/>
		<%-- get x and y from page context --%>
        <cewolf:param name="x" value="${x}"/>
        <cewolf:param name="y" value="${y}"/>
        <cewolf:param name="textPaint" value="#0000FF"/>
        <cewolf:param name="textAnchor" value="CENTER_LEFT"/>

		<cewolf:param name="fontname" value="Serif"/>
		<cewolf:param name="fontsize" value="18"/>
		<cewolf:param name="bold" value="true"/>
		<cewolf:param name="italic" value="true"/>

        <cewolf:param name="arrowPaint" value="#0000FF"/>
        <cewolf:param name="arrowAngle" value="-0.7"/>
    </cewolf:chartpostprocessor>

	<cewolf:chartpostprocessor id="labelRotation">
		<cewolf:param name="rotate_at" value="10"/>
		<cewolf:param name="remove_at" value="50"/>
	</cewolf:chartpostprocessor> 
</cewolf:chart>
<cewolf:img chartid="XYChart" renderer="/cewolf" removeAfterRender="true" width="600" height="400"> </cewolf:img>
</body>
</html>
