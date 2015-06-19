<%@page contentType="text/html"%>
<%@taglib uri="http://cewolf.sourceforge.net/taglib/cewolf.tld" prefix="cewolf" %>
<html>
<head>
<link href="cewolf.css" rel="stylesheet" type="text/css">
</head>
<BODY bgcolor="#DDE8F2">
<H1>Cewolf test page</H1>
<p>
<jsp:useBean id="testXYData" class="de.laures.cewolf.example.RandomXYData" scope="page"  />
<jsp:useBean id="subtitler" class="de.laures.cewolf.cpp.TitleEnhancer" scope="page" />
<jsp:useBean id="visualPP" class="de.laures.cewolf.cpp.VisualEnhancer" scope="page" />
<jsp:useBean id="params" class="de.laures.cewolf.example.ParamBean" scope="request"/>
<jsp:setProperty name="params" property="*"/>
<form method="GET">
<!-- outermost table -->
<TABLE><TR><TD>

<!-- control panel table -->
<TABLE border=1 cellspacing=3> 
<TR>
    <TD><%@include file="chartparamspanel.jsp"%></TD>
</TR>
<TR>
    <TD><%@include file="paintparamspanel.jsp"%></TD>
</TR>
<TR>
    <TD><%@include file="dataparamspanel.jsp"%></TD>
</TR>
<TR>
    <TD><%@include file="enhancerparamspanel.jsp"%></TD>
</TR>
<TR>
    <TD colspan="3" align="center"><INPUT type="submit" value="Render"></TD>
</TR>
</TABLE>
<!-- end control panel table -->

</TD>
<TD valign="top">

<!-- image panel -->
<cewolf:chart 
    id="XYChart" 
    type="xy"
    title="${params.title}"
    antialias="${params.antialias}"
    xaxisinteger="${params.xaxisinteger}"
    yaxisinteger="${params.yaxisinteger}"
    xtickmarksvisible="${params.xtickmarksvisible}"
    ytickmarksvisible="${params.ytickmarksvisible}"
    xticklabelsvisible="${params.xticklabelsvisible}"
    yticklabelsvisible="${params.yticklabelsvisible}"
    showlegend="${params.legend}"
    legendanchor="${params.legendAnchor}">
    <% if(params.isSelectedPaint("color")) { %>
        <cewolf:colorpaint color="${params.colorColor}"/>
    <% } else if(params.isSelectedPaint("gradient")) { %>
        <cewolf:gradientpaint cyclic="${params.cyclic}">
            <cewolf:point 
                x="${params.gradientX1}" 
                y="${params.gradientY1}" 
                color="${params.gradientColor1}" />
            <cewolf:point 
                x="${params.gradientX2}" 
                y="${params.gradientY2}" 
                color="${params.gradientColor2}" />
        </cewolf:gradientpaint>
    <% } else { %>
        <cewolf:texturepaint 
            image="${params.textureImage}" 
            width="${params.textureWidth}" 
            height="${params.textureHeight}" />
    <% } %>
    <cewolf:data>
        <cewolf:producer id="testXYData">
            <cewolf:param name="maxVal" value="${params.maxVal}"/>
            <cewolf:param name="minVal" value="${params.minVal}"/>
        </cewolf:producer>
    </cewolf:data>
    <cewolf:chartpostprocessor id="subtitler">
        <cewolf:param name="type" value="subtitle"/>
        <cewolf:param name="title" value="${params.extraTitle}"/>
        <cewolf:param name="fontname" value="SansSerif"/>
        <cewolf:param name="fontsize" value="12"/>
        <cewolf:param name="bold" value="false"/>
        <cewolf:param name="italic" value="true"/>
    </cewolf:chartpostprocessor>
    <cewolf:chartpostprocessor id="visualPP">
        <cewolf:param name="border" value="false"/>
        <cewolf:param name="borderpaint" value="#FF0000"/>
        <cewolf:param name="top" value="20"/>
        <cewolf:param name="left" value="20"/>
        <cewolf:param name="right" value="20"/>
        <cewolf:param name="bottom" value="20"/>
		<%--
        <cewolf:param name="plotTop" value="0"/>
        <cewolf:param name="plotLeft" value="0"/>
        <cewolf:param name="plotRight" value="0"/>
        <cewolf:param name="plotBottom" value="0"/>
        <cewolf:param name="showDomainAxes" value="false"/>
        <cewolf:param name="showRangeAxes" value="false"/>
		--%>
    </cewolf:chartpostprocessor>
</cewolf:chart>
<cewolf:img 
    chartid="XYChart" 
    renderer="/cewolf"
	removeAfterRender="true"
    width="${params.width}" 
    height="${params.height}"
    mime="${params.mimeType}"/>
<!-- end image panel -->
<p>
<cewolf:imgurl 
	chartid="XYChart"    
	renderer="/cewolf"
    width="${params.width}" 
    height="${params.height}"
    mime="${params.mimeType}"
    var="imgURL"/>
image URL: ${imgURL}
</TD>

<!-- end outermost table -->
</TR>
</TABLE>

</FORM>
</body>
</html>
