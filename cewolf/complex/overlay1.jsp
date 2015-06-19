<%@page contentType="text/html"%>
<%@taglib uri="http://cewolf.sourceforge.net/taglib/cewolf.tld" prefix="cewolf" %>
<%@page import="java.awt.Color" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="de.laures.cewolf.*"%>
<%@page import="de.laures.cewolf.example.*"%>
<%@page import="de.laures.cewolf.links.XYItemLinkGenerator" %>
<%@page import="de.laures.cewolf.tooltips.XYToolTipGenerator" %>
<%@page import="org.jfree.chart.JFreeChart" %>
<%@page import="org.jfree.chart.plot.Plot" %>
<%@page import="org.jfree.chart.plot.XYPlot" %>
<%@page import="org.jfree.chart.renderer.xy.XYItemRenderer" %>
<%@page import="org.jfree.data.*"%>
<%@page import="org.jfree.data.category.CategoryDataset" %>
<%@page import="org.jfree.data.time.*"%>
<%@page import="org.jfree.data.xy.XYDataset" %>
<%
	final DatasetProducer dp1 = new DemoDataSetProducer1(0,-50);

	DatasetProducer dp2 = new DatasetProducer() {

		public Object produceDataset(Map params) throws DatasetProduceException {
			TimeSeries data = ((TimeSeriesCollection) dp1.produceDataset(new HashMap())).getSeries(0);
			return new TimeSeriesCollection(MovingAverage.createMovingAverage((TimeSeries) data,
							"Six Month Moving Average", 6, 6));
		}

		public boolean hasExpired(Map params, Date since) {
			return false;
		}

		public String getProducerId() {
			return "European Index Trust Average";
		}
	};

	// example how to create a post processor for each charts in the overlaid
	ChartPostProcessor postprocessor = new OverlayPostProcessor();

	pageContext.setAttribute("xy1", dp1);
	pageContext.setAttribute("xy2", dp2);

	// create parallel data lines for these charts:
	pageContext.setAttribute("dp3", new DemoDataSetProducer1(3, 40));
	pageContext.setAttribute("dp4", new DemoDataSetProducer1(4, 50));
	pageContext.setAttribute("dp5", new DemoDataSetProducer1(5, 60));

	pageContext.setAttribute("postprocessor", postprocessor);


	// create example link generator for the overlaid chart
	final SimpleDateFormat dateformat = new SimpleDateFormat("yyyy/MM/dd");

	XYToolTipGenerator tooltipGenerator = new XYToolTipGenerator() {
		public String generateToolTip(XYDataset data, int series, int item) {
			Date d = new Date(((Long)data.getX(series,item)).longValue());
			return "tooltip x=" + dateformat.format(d) + ",y="+ data.getY(series,item);
		}
	};

	XYItemLinkGenerator linkGenerator = new XYItemLinkGenerator() {
		 public String generateLink(Object data, int series, int item) {
			XYDataset dataset = (XYDataset) data;
			Date d = new Date(((Long)dataset.getX(series,item)).longValue());
			return "link x=" + dateformat.format(d) + ",y="+ dataset.getY(series,item);
		 }
	};

	pageContext.setAttribute("tooltipGenerator", tooltipGenerator);
	pageContext.setAttribute("linkGenerator", linkGenerator);
%>
<html>
<head>
<link href="cewolf.css" rel="stylesheet" type="text/css"></head>
<BODY bgcolor="#DDE8F2">
<H1>Complex Chart Set</H1>
<p>
<table border=0>
<TR>
<TD>
<cewolf:overlaidchart 
	id="test2" 
	title="LG European Index Trust (with moving average)" 
	type="overlaidxy" 
	xaxistype="date"
	yaxistype="number"
	xaxislabel="x-values" 
	yaxislabel="y-values">
    <cewolf:colorpaint color="#AAAAFF"/>

		<cewolf:plot type="xyline">
			<cewolf:data>
      			<cewolf:producer id="xy2" />
	    	</cewolf:data>
		</cewolf:plot>

		<cewolf:plot type="xyverticalbar" >
			<cewolf:data>
      			<cewolf:producer id="xy1" />
    		</cewolf:data>
		</cewolf:plot>

		<cewolf:plot type="xyline">
			<cewolf:data>
      			<cewolf:producer id="dp3" />
	    	</cewolf:data>
		</cewolf:plot>

		<cewolf:plot type="scatter">
			<cewolf:data>
      			<cewolf:producer id="dp4" />
    		</cewolf:data>
		</cewolf:plot>

		<cewolf:plot type="scatter">
			<cewolf:data>
      			<cewolf:producer id="dp5" />
    		</cewolf:data>
		</cewolf:plot>

		<cewolf:chartpostprocessor id="postprocessor" />

</cewolf:overlaidchart>

<!-- this demonstrates that links work with overlaid chart too -->
<cewolf:img chartid="test2" renderer="/cewolf" removeAfterRender="true" width="600" height="400">
	<cewolf:map linkgeneratorid="linkGenerator"  tooltipgeneratorid="tooltipGenerator" />
</cewolf:img>

</TD>
</TR>
</TABLE>
</body>
</html>
