<%@page contentType="text/html"%>
<%@taglib uri="http://cewolf.sourceforge.net/taglib/cewolf.tld" prefix="cewolf" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.*"%>
<%@page import="de.laures.cewolf.DatasetProducer" %>
<%@page import="org.jfree.data.xy.XYZDataset, org.jfree.data.DomainOrder, org.jfree.data.general.*" %>
<%
	DatasetProducer heatmapProducer1 = new DatasetProducer() {
		public Object produceDataset(Map params) {
			return new XYZDataset() {
				public int getSeriesCount() { return 1; }
				
				public int getItemCount(int series) { return 10000; }
				
				public Number getX(int series, int item) { return new Double(getXValue(series, item)); }
				
				public double getXValue(int series, int item) { return (double) (item / 100 - 50); }
				
				public Number getY(int series, int item) { return new Double(getYValue(series, item)); }
				
				public double getYValue(int series, int item) { return (double) (item - item / 100 * 100 - 50); }
				
				public Number getZ(int series, int item) {
					return new Double(getZValue(series, item));
				}

				public double getZValue(int series, int item) {
					double x = getXValue(series, item);
					double y = getYValue(series, item);
					return Math.sin(Math.sqrt(x * x + y * y) / 5.0);
				}

				public void addChangeListener (DatasetChangeListener datasetchangelistener) { }
				
				public void removeChangeListener (DatasetChangeListener datasetchangelistener) { }
				
				public DatasetGroup getGroup() { return null; }
				
				public void setGroup(DatasetGroup datasetgroup) { }

				public Comparable getSeriesKey(int series) { return "sin(sqrt(x + y))"; }

				public int indexOf(Comparable comparable) { return 0; }

				public DomainOrder getDomainOrder() { return DomainOrder.ASCENDING; }
			};
		}

		public String getProducerId() {
		  return "HeatmapDataProducer";
		}

		public boolean hasExpired(Map params, Date since) {
		  return true;
		}
	};

	pageContext.setAttribute("heatmapData1", heatmapProducer1);

	DatasetProducer heatmapProducer2 = new DatasetProducer() {
		public Object produceDataset(Map params) {
			return new XYZDataset() {
				public int getSeriesCount() { return 1; }
				
				public int getItemCount(int series) { return 100; }
				
				public Number getX(int series, int item) { return new Double(getXValue(series, item)); }
				
				public double getXValue(int series, int item) { return Math.floor(item / 10); }
				
				public Number getY(int series, int item) { return new Double(getYValue(series, item)); }
				
				public double getYValue(int series, int item) { return (double) item % 10; }
				
				public Number getZ(int series, int item) {
					return new Double(getZValue(series, item));
				}

				public double getZValue(int series, int item) {
					double x = getXValue(series, item);
					double y = getYValue(series, item);
					return x + y;
				}

				public void addChangeListener (DatasetChangeListener datasetchangelistener) { }
				
				public void removeChangeListener (DatasetChangeListener datasetchangelistener) { }
				
				public DatasetGroup getGroup() { return null; }
				
				public void setGroup(DatasetGroup datasetgroup) { }

				public Comparable getSeriesKey(int series) { return "sin(sqrt(x + y))"; }

				public int indexOf(Comparable comparable) { return 0; }

				public DomainOrder getDomainOrder() { return DomainOrder.ASCENDING; }
			};
		}

		public String getProducerId() {
		  return "HeatmapDataProducer";
		}

		public boolean hasExpired(Map params, Date since) {
		  return true;
		}
	};

	pageContext.setAttribute("heatmapData2", heatmapProducer2);

%>
<jsp:useBean id="heatmapPP" class="de.laures.cewolf.cpp.HeatmapEnhancer" />
<html>
<head>
	<link href="cewolf.css" rel="stylesheet" type="text/css">
</head>
<BODY bgcolor="#DDE8F2">
<cewolf:chart id="heatmapChart1" type="heatmap" title="Heatmap 1 - gray colors" showlegend="false" plotbackgroundcolor="#F4F4F4">
    <cewolf:data>
        <cewolf:producer id="heatmapData1" />
    </cewolf:data>

    <cewolf:chartpostprocessor id="heatmapPP">
        <cewolf:param name="xLabel" value="X"/>
        <cewolf:param name="yLabel" value="Y"/>
        <cewolf:param name="scaleLabel" value="Scale"/>
        <cewolf:param name="scalePos" value="bottom"/>
        <cewolf:param name="scaleTextPos" value="topleft"/>
        <cewolf:param name="subdivisions" value="40"/>
        <cewolf:param name="stripWidth" value="10"/>
        <cewolf:param name="lowerBound" value="-1.0"/>
        <cewolf:param name="upperBound" value="1.0"/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="heatmapChart1" renderer="/cewolf" removeAfterRender="true" width="800" height="600"/>
<HR>
<cewolf:chart id="heatmapChart2" type="heatmap" title="Heatmap 2 - particularly selected colors" showlegend="false" plotbackgroundcolor="#DDFFFF">
    <cewolf:data>
        <cewolf:producer id="heatmapData2" />
    </cewolf:data>

    <cewolf:chartpostprocessor id="heatmapPP">
        <cewolf:param name="xLabel" value="X"/>
        <cewolf:param name="yLabel" value="Y"/>
        <cewolf:param name="scaleLabel" value="Elaborate description of what this value means goes here"/>
        <cewolf:param name="scalePos" value="right"/>
        <cewolf:param name="scaleTextPos" value="topleft"/>
        <cewolf:param name="scaleBorder" value="#00E000"/>
        <cewolf:param name="stripWidth" value="20"/>
        <cewolf:param name="lowerBound" value="0.0"/>
        <cewolf:param name="upperBound" value="20.0"/>
        <cewolf:param name="showItemLabels" value="true"/>
        <cewolf:param name="color#1" value="0.0%:#FF0000"/>
        <cewolf:param name="color#2" value="20.0%:#00FF00"/>
        <cewolf:param name="color#3" value="50.0%:#0000FF"/>
        <cewolf:param name="color#4" value="85.0%:#808080"/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="heatmapChart2" renderer="/cewolf" removeAfterRender="true" width="800" height="600"/>
<HR>
<cewolf:chart id="heatmapChart3" type="heatmap" title="Heatmap 3 - interpolating between start and end colors" showlegend="false" plotbackgroundcolor="#F4F4F4">
    <cewolf:data>
        <cewolf:producer id="heatmapData2" />
    </cewolf:data>

    <cewolf:chartpostprocessor id="heatmapPP">
        <cewolf:param name="xLabel" value="X"/>
        <cewolf:param name="yLabel" value="Y"/>
        <cewolf:param name="scaleLabel" value="Scale"/>
        <cewolf:param name="scalePos" value="bottom"/>
        <cewolf:param name="scaleTextPos" value="topleft"/>
        <cewolf:param name="subdivisions" value="40"/>
        <cewolf:param name="stripWidth" value="10"/>
        <cewolf:param name="lowerBound" value="0.0"/>
        <cewolf:param name="upperBound" value="20.0"/>
        <cewolf:param name="lowerColor" value="#FF0000"/>
        <cewolf:param name="upperColor" value="#0000FF"/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="heatmapChart3" renderer="/cewolf" removeAfterRender="true" width="800" height="600"/>
</body>
</html>

