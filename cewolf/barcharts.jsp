<%@page contentType="text/html"%>
<%@taglib uri="http://cewolf.sourceforge.net/taglib/cewolf.tld" prefix="cewolf" %>
<%@page import="java.util.*"%>
<%@page import="de.laures.cewolf.*"%>
<%@page import="de.laures.cewolf.cpp.*"%>
<%@page import="de.laures.cewolf.links.*"%>
<%@page import="de.laures.cewolf.tooltips.*"%>
<%@page import="org.jfree.chart.*"%>
<%@page import="org.jfree.chart.plot.*"%>
<%@page import="org.jfree.data.*"%>
<%@page import="org.jfree.data.category.*"%>
<%@page import="org.jfree.data.general.*"%>
<%@page import="org.jfree.data.xy.*"%>
<%
if (pageContext.getAttribute("initFlag") == null) {

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

	DatasetProducer singleCategory = new DatasetProducer() {
    public Object produceDataset(Map params) {
      final String[] categories = { "apples", "pies", "bananas", "oranges" };
      final String[] seriesNames = { "Peter" };
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
  pageContext.setAttribute("singleCategory", singleCategory);

  DatasetProducer xyData = new DatasetProducer() {
    public Object produceDataset(Map params) {
      XYSeries xys = new XYSeries("Example XY Dataset");
      double last = 0.0;
      for (int i = -50; i <= 50; i++) {
        double y = last + ((Math.random() * 100) - 50.0);
        xys.add((double) i, y);
        last = y;
      }
      return new XYSeriesCollection(xys);
    }
    public String getProducerId() {
      return "XYDataProducer";
    }
    public boolean hasExpired(Map params, Date since) {
      return false;
    }
  };
  pageContext.setAttribute("xyData", xyData);

  CategoryToolTipGenerator catTG = new CategoryToolTipGenerator() {
    public String generateToolTip(CategoryDataset dataset, int series, int index) {
      return String.valueOf(dataset.getValue(series, index));
    }
  };
  pageContext.setAttribute("categoryToolTipGenerator", catTG);

  pageContext.setAttribute("initFlag", "init");
}
%>
<jsp:useBean id="seriesPaint" class="de.laures.cewolf.cpp.SeriesPaintProcessor" />

<jsp:useBean id="barRenderer" class="de.laures.cewolf.cpp.BarRendererProcessor" />

<html>
<head><title>Barchart examples</title></head>
<BODY bgcolor="#DDE8F2">
<table border=0>
<TR>
<TD>
<cewolf:chart id="horizontalBarChart" title="HorizontalBar" type="horizontalBar"
		showlegend="false" xaxislabel="Fruit" yaxislabel="favorite">
    <cewolf:data>
        <cewolf:producer id="categoryData" />
    </cewolf:data>
    <cewolf:chartpostprocessor id="barRenderer">
        <cewolf:param name="outline" value="true"/>
        <cewolf:param name="itemMargin" value="0.1"/>
        <cewolf:param name="categoryColors" value="true"/>
        <cewolf:param name="0" value="#FFFFAA"/>
        <cewolf:param name="1" value="#AAFFAA"/>
        <cewolf:param name="2" value="#FFAAFF"/>
        <cewolf:param name="3" value="#FFAAAA"/>
    </cewolf:chartpostprocessor>
	<%--
	--%>
</cewolf:chart>
<cewolf:img chartid="horizontalBarChart" renderer="/cewolf" width="400" height="300">
    <cewolf:map tooltipgeneratorid="categoryToolTipGenerator"/>
</cewolf:img>
</TD>
<TD>
<cewolf:chart id="horizontalBarChart3D" title="HorizontalBar3D" type="horizontalBar3D" xaxislabel="Fruit" yaxislabel="favorite">
    <cewolf:data>
        <cewolf:producer id="categoryData" />
    </cewolf:data>
</cewolf:chart>
<cewolf:img chartid="horizontalBarChart3D" renderer="/cewolf" width="400" height="300"/></TD>
</TR>

<TR>
<TD>
<cewolf:chart id="verticalBar" title="VerticalBar" type="verticalBar" xaxislabel="Fruit" yaxislabel="favorite">
    <cewolf:data>
        <cewolf:producer id="categoryData" />
    </cewolf:data>
</cewolf:chart>
<cewolf:img chartid="verticalBar" renderer="/cewolf" width="400" height="300"/>
</TD>
<TD>
<cewolf:chart id="verticalBar3D" title="VerticalBar3D" type="verticalBar3D" xaxislabel="Fruit" yaxislabel="favorite">
    <cewolf:data>
        <cewolf:producer id="categoryData" />
    </cewolf:data>
</cewolf:chart>
<cewolf:img chartid="verticalBar3D" renderer="/cewolf" width="400" height="300"/>
</TD>
</TR>

<TR>
<TD>
<cewolf:chart id="stackedHorizontalBar" title="StackedHorizontalBar" type="stackedHorizontalBar" xaxislabel="Fruit" yaxislabel="favorite">
    <cewolf:data>
        <cewolf:producer id="categoryData" />
    </cewolf:data>
    <cewolf:chartpostprocessor id="seriesPaint">
        <cewolf:param name="0" value="#FFFFAA"/>
        <cewolf:param name="1" value="#AAFFAA"/>
        <cewolf:param name="2" value="#FFAAFF"/>
        <cewolf:param name="3" value="#FFAAAA"/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="stackedHorizontalBar" renderer="/cewolf" width="400" height="300"/>
</TD>
<TD>
<cewolf:chart id="stackedHorizontalBar3D" title="StackedHorizontalBar3D" type="stackedHorizontalBar3D" xaxislabel="Fruit" yaxislabel="favorite">
    <cewolf:data>
        <cewolf:producer id="categoryData" />
    </cewolf:data>
</cewolf:chart>
<cewolf:img chartid="stackedHorizontalBar3D" renderer="/cewolf" width="400" height="300"/>
</TD>
</TR>

<TR>
<TD>
<cewolf:chart id="stackedVerticalBar" title="StackedVerticalBar" type="stackedVerticalBar" xaxislabel="Fruit" yaxislabel="favorite">
    <cewolf:data>
        <cewolf:producer id="categoryData" />
    </cewolf:data>
    <cewolf:chartpostprocessor id="barRenderer">
        <cewolf:param name="showItemLabels" value="true"/>
        <cewolf:param name="itemLabelColor" value="#606060"/>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="stackedVerticalBar" renderer="/cewolf" width="400" height="300"/>
</TD>
<TD>
<cewolf:chart id="stackedVerticalBar3D" title="StackedVerticalBar3D" type="stackedVerticalBar3D" xaxislabel="Fruit" yaxislabel="favorite">
    <cewolf:data>
        <cewolf:producer id="categoryData" />
    </cewolf:data>
</cewolf:chart>
<cewolf:img chartid="stackedVerticalBar3D" renderer="/cewolf" width="400" height="300"/>
</TD>
</TR>

<TR>
<TD>
<cewolf:chart id="scatterPlot" title="Vertical XY Bar" type="verticalxybar" showlegend="false">
    <cewolf:data>
        <cewolf:producer id="xyData" />
    </cewolf:data>
</cewolf:chart>
<cewolf:img chartid="scatterPlot" renderer="/cewolf" width="400" height="300" />
</TD>
<TD>
<cewolf:chart id="verticalBar" title="VerticalBar" type="verticalBar"
		showlegend="false" xaxislabel="Fruit" yaxislabel="favorite">
    <cewolf:data>
        <cewolf:producer id="singleCategory" />
    </cewolf:data>
   <cewolf:chartpostprocessor id="barRenderer">
		<cewolf:param name="showItemLabels" value="true"/>
		<cewolf:param name="itemLabelSize" value="14"/>
		<%--
		<cewolf:param name="bold" value="true"/>
		<cewolf:param name="italic" value="true"/>
		--%>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img chartid="verticalBar" renderer="/cewolf" width="400" height="300"/>
</TD>
</TR>

</TABLE>
</body>
</html>
