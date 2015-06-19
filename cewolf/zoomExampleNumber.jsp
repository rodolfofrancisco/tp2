<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://cewolf.sourceforge.net/taglib/cewolf.tld" prefix="cewolf" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cewolf Zoom Functionality Example (XY Plot)</title>

		<script language="JavaScript">
			function getDomainRange() {
				return Math.abs(document.test.upperDomainValN.value - document.test.lowerDomainValN.value);
			}

			function adjustLow (delta) {
				document.test.lowerDomainValN.value = Math.round(1000000.0 * (Number(document.test.lowerDomainValN.value) + delta)) / 1000000.0;
			}

			function adjustHigh (delta) {
				document.test.upperDomainValN.value = Math.round(1000000.0 * (Number(document.test.upperDomainValN.value) + delta)) / 1000000.0;
			}

			function panLeft() {
				domainRange = getDomainRange();
				adjustLow(- domainRange / 4.0);
				adjustHigh(- domainRange / 4.0);
			}

			function panRight() {
				domainRange = getDomainRange();
				adjustLow(+ domainRange / 4.0);
				adjustHigh(+ domainRange / 4.0);
			}

			function zoomIn() {
				domainRange = getDomainRange();
				adjustLow(+ domainRange / 4.0);
				adjustHigh(- domainRange / 4.0);
			}

			function zoomOut() {
				domainRange = getDomainRange();
				adjustLow(- domainRange / 4.0);
				adjustHigh(+ domainRange / 4.0);
			}
		</script>
    </head>

	<BODY bgcolor="#DDE8F2">
		<jsp:useBean id="visualEnhancer" class="de.laures.cewolf.cpp.VisualEnhancer"/>
		<jsp:useBean id="data" class="de.laures.cewolf.example.ProduceMathDataExample" />
		<jsp:useBean id="zoom" class="de.laures.cewolf.cpp.ZoomBothAxis"/>
		<jsp:useBean id="pparams" class="de.laures.cewolf.example.plotParams"/>

		<jsp:setProperty name="zoom" property="*"/>
		<jsp:setProperty name="pparams" property="*"/>

		<cewolf:chart id="chart" type="xy" title="Sine versus Cosine Graph" showlegend="true" legendanchor="east">
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
				<cewolf:param name="lowerDomainValN" value='${zoom.lowerDomainValN}'/>
				<cewolf:param name="upperDomainValN" value='${zoom.upperDomainValN}'/>
				<cewolf:param name="zoomFactor" value='${zoom.zoomFactor}'/>
				<cewolf:param name="anchorValueD" value='${zoom.anchorValueD}'/>
				<cewolf:param name="anchorValueR" value='${zoom.anchorValueR}'/>
			</cewolf:chartpostprocessor>
		</cewolf:chart>

		<cewolf:img chartid="chart" height='${pparams.height}' width='${pparams.width}' removeAfterRender="true" renderer="cewolf"></cewolf:img>

		<form name="test" method="GET">
			<table border="0" cellpadding="2">
				<tr>
					<td><b>Set X-Axis Domain</b></td>
					<td>Min <input type="text" name="lowerDomainValN" value='<jsp:getProperty name="zoom" property="lowerDomainValN"/>' size="12"/></td>
					<td>Max <input type="text" name="upperDomainValN" value='<jsp:getProperty name="zoom" property="upperDomainValN"/>' size="12"/></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td> <input type="button" value="Pan Left" onClick="panLeft();"/> </td>
					<td> <input type="button" value="Pan Right" onClick="panRight();"/> </td>
					<td> <input type="button" value="Zoom in" onClick="zoomIn();"/> </td>
					<td> <input type="button" value="Zoom out" onClick="zoomOut();"/> </td>
				</tr>
				<tr>
					<td><b>Set Y-Axis Range</b></td>
					<td>Min <input type="text" name="lowerRangeVal" value='<jsp:getProperty name="zoom" property="lowerRangeVal"/>' size="6" /></td>
					<td>Max <input type="text" name="upperRangeVal" value='<jsp:getProperty name="zoom" property="upperRangeVal"/>' size="6" /></td>
				</tr>
				<tr>
					<td><b>Change Plot Size</b></td>
					<td>Width <input type="text" name="width" value='<jsp:getProperty name="pparams" property="width"/>' size="4" /> </td>
					<td>Height <input type="text" name="height" value='<jsp:getProperty name="pparams" property="height"/>' size="4"/> </td>
				</tr>
				<tr>
					<td><b>Y Axis Zoom</b></td>
					<td>Factor <input type="text" name="zoomFactor" value='<jsp:getProperty name="zoom" property="zoomFactor"/>' size="4" /> </td>
				</tr>
				<tr>
					<td><b>Anchor Values</b></td>
					<td>Domain <input type="text" name="anchorValueD" value='<jsp:getProperty name="zoom" property="anchorValueD"/>' size="6" /> </td>
					<td>Range <input type="text" name="anchorValueR" value='<jsp:getProperty name="zoom" property="anchorValueR"/>' size="6" /> </td>
				</tr>
			</table>
		<input type="submit" value="Render"/>
	</form>
	<script>
		if (document.test.lowerDomainValN.value == document.test.upperDomainValN.value) {
			document.test.lowerDomainValN.value = Math.round(1000000.0 * <%= data.getMinX() %>) / 1000000.0;
			document.test.upperDomainValN.value = Math.round(1000000.0 * <%= data.getMaxX() %>) / 1000000.0;
		}
	</script>
</body>
</html>

