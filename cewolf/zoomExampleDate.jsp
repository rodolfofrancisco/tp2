<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://cewolf.sourceforge.net/taglib/cewolf.tld" prefix="cewolf" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CeWolf Zoom Functionality Example (Timeseries Plot)</title>
    </head>
<BODY bgcolor="#DDE8F2">
		<jsp:useBean id="visualEnhancer" class="de.laures.cewolf.cpp.VisualEnhancer"/>
		<jsp:useBean id="data" class="de.laures.cewolf.example.ProduceTimeSeriesDataExample" />
		<jsp:useBean id="zoom" class="de.laures.cewolf.cpp.ZoomBothAxis"/>
		<jsp:useBean id="pparams" class="de.laures.cewolf.example.plotParams"/>

		<jsp:setProperty name="zoom" property="*"/>
		<jsp:setProperty name="pparams" property="*"/>

		<cewolf:chart id="chart" type="timeseries" title="Data points for today" showlegend="true" legendanchor="east" yaxislabel="Count Number" xaxislabel="Time">
				<cewolf:data>
					<cewolf:producer id="data" />
				</cewolf:data>
				<cewolf:chartpostprocessor id="visualEnhancer">
					<cewolf:param name="border" value='false'/>
					<cewolf:param name="rangeIncludesZero" value='false'/>
				   </cewolf:chartpostprocessor>
				   <cewolf:chartpostprocessor id="zoom">
						<cewolf:param name="lowerRangeVal" value='${zoom.lowerRangeVal}'/>
						<cewolf:param name="upperRangeVal" value='${zoom.upperRangeVal}'/>
						<cewolf:param name="lowerDomainValD" value='${zoom.lowerDomainValD}'/>
						<cewolf:param name="upperDomainValD" value='${zoom.upperDomainValD}'/>
						<cewolf:param name="zoomFactor" value='${zoom.zoomFactor}'/>
				</cewolf:chartpostprocessor>
		</cewolf:chart>

		<cewolf:img chartid="chart" height='${pparams.height}' width='${pparams.width}' removeAfterRender="true" renderer="cewolf"></cewolf:img>

		<form name="test" method="GET">
			<table border="0" cellpadding="2">
				<tr>
					<td><b>Set Time Range</b><br>(enter in format HH:mm)</td>
					<td>Start time <input type="text" name="lowerDomainValD" value='<jsp:getProperty name="zoom" property="lowerDomainValD"/>' size="6"/></td>
					<td>End time <input type="text" name="upperDomainValD" value='<jsp:getProperty name="zoom" property="upperDomainValD"/>' size="6"/></td>
				</tr>
				<tr>
					<td><b>Set Y-Axis Range: </b></td>
					<td>Min <input type="text" name="lowerRangeVal" value='<jsp:getProperty name="zoom" property="lowerRangeVal"/>' size="6" /></td>
				<td>Max  <input type="text" name="upperRangeVal" value='<jsp:getProperty name="zoom" property="upperRangeVal"/>' size="6" /></td>
			</tr>
			<tr>
				<td><b>Change Plot Size: </b></td>
				<td>Width <input type="text" name="width" value='<jsp:getProperty name="pparams" property="width"/>' size="4" /> </td>
				<td>Height <input type="text" name="height" value='<jsp:getProperty name="pparams" property="height"/>' size="4"/> </td>
			</tr>
			<tr>
				<td><b>Y Axis Zoom</b></td>
				<td>Factor <input type="text" name="zoomFactor" value='<jsp:getProperty name="zoom" property="zoomFactor"/>' size="4" /> </td>
			</tr>
		</table>
		<input type="submit" value="Render"/>
	</form>

</body>
</html>
