<%@page contentType="text/html"%>
<%@taglib uri='http://cewolf.sourceforge.net/taglib/cewolf.tld' prefix='cewolf' %>
<html>
<body>
<H1>Producer Param Test Page</H1>
<p>
<jsp:useBean id="xyData" class="de.laures.cewolf.example.RandomXYData" />
<cewolf:chart id="XYChart" title="XYChart" renderer="servlet/chart" width="300" height="300" type="xy" xaxislabel="x-values" yaxislabel="y-values">
    <cewolf:data>
        <cewolf:producer id="xyData">
            <cewolf:param name="maxVal" value="1000"/>
            <cewolf:param name="minVal" value="650"/>
        </cewolf:producer>
    </cewolf:data>
</cewolf:chart>
</body>
</html>
