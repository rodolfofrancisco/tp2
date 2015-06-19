<%@page contentType="text/html"%>
<%@taglib uri="http://cewolf.sourceforge.net/taglib/cewolf.tld" prefix="cewolf" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="de.laures.cewolf.*"%>
<%@page import="org.jfree.data.*"%>
<%@page import="org.jfree.data.time.*"%>
<HTML>
<HEAD>
<TITLE>Cewolf Tutorial</TITLE>
</HEAD>
<BODY>
<%
final DatasetProducer dp = new DatasetProducer(){
    
	public Object produceDataset (Map params) throws DatasetProduceException {
		TimeSeries s1 = new TimeSeries("European Index Trust", Month.class);
        s1.add(new Month(2, 2001), 181.8);
        s1.add(new Month(3, 2001), 167.3);
        s1.add(new Month(4, 2001), 153.8);
        s1.add(new Month(5, 2001), 167.6);
        s1.add(new Month(6, 2001), 158.8);
        s1.add(new Month(7, 2001), 148.3);
        s1.add(new Month(8, 2001), 153.9);
        s1.add(new Month(9, 2001), 142.7);
        s1.add(new Month(10, 2001), 123.2);
        s1.add(new Month(11, 2001), 131.8);
        s1.add(new Month(12, 2001), 139.6);
        s1.add(new Month(1, 2002), 142.9);
        s1.add(new Month(2, 2002), 138.7);
        s1.add(new Month(3, 2002), 137.3);
        s1.add(new Month(4, 2002), 143.9);
		return new TimeSeriesCollection(s1);
	}

	public boolean hasExpired (Map params, Date since) { return false; }

	public String getProducerId() { return "European Index Trust"; }
};

pageContext.setAttribute("xy", dp);
%>
<cewolf:chart id="test" type="verticalxybar">
	<cewolf:data>
		<cewolf:producer id="xy" />
	</cewolf:data>
</cewolf:chart>

<cewolf:img chartid="test" renderer="/cewolf" width="500" height="300"/>
</BODY>
</HTML>
