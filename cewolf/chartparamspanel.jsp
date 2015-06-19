<TABLE>
    <TR>
        <TH colspan="2">Chart Params</TH>
    </TR>
    <TR>
    <TD>title</TD>
    <TD>
        <INPUT type="TEXT" name="title" size="25" value="${params.title}">
    </TD>
    </TR>
    <TR><TD colspan="2">
		<TABLE><TR><TD>
			<TD>width
				<INPUT type="TEXT" name="width" size="8" value="${params.width}">
			</TD>
			<TD style="width: 50px">&nbsp;</TD>
			<TD>height
				<INPUT type="TEXT" name="height" size="8" value="${params.height}">
			</TD>
		</TD></TR></TABLE>
    </TD></TR>
    <TR>
    <TD>antialias</TD>
    <TD>
        on&nbsp;<INPUT type="RADIO" name="antialias" ${params.antialias ? "checked" : ""} value="true">&nbsp;off&nbsp;<INPUT type="RADIO" name="antialias" ${params.antialias ? "" : "checked"} value="false">
    </TD>
    </TR>
    <TR>
    <TD>X axisinteger</TD>
    <TD>
        on&nbsp;<INPUT type="RADIO" name="xaxisinteger" ${params.xaxisinteger ? "checked" : ""} value="true">&nbsp;off&nbsp;<INPUT type="RADIO" name="xaxisinteger" ${params.xaxisinteger ? "" : "checked"} value="false">
    </TD>
	</TR>
	<TR>
    <TD>Y axisinteger</TD>
    <TD>
        on&nbsp;<INPUT type="RADIO" name="yaxisinteger" ${params.yaxisinteger ? "checked" : ""} value="true">&nbsp;off&nbsp;<INPUT type="RADIO" name="yaxisinteger" ${params.yaxisinteger ? "" : "checked"} value="false">
    </TD>
    </TR>
    <TR>
    <TD>X tickmarksvisible</TD>
    <TD>
        on&nbsp;<INPUT type="RADIO" name="xtickmarksvisible" ${params.xtickmarksvisible ? "checked" : ""} value="true">&nbsp;off&nbsp;<INPUT type="RADIO" name="xtickmarksvisible" ${params.xtickmarksvisible ? "" : "checked"} value="false">
    </TD>
	</TR>
	<TR>
    <TD>Y tickmarksvisible</TD>
    <TD>
        on&nbsp;<INPUT type="RADIO" name="ytickmarksvisible" ${params.ytickmarksvisible ? "checked" : ""} value="true">&nbsp;off&nbsp;<INPUT type="RADIO" name="ytickmarksvisible" ${params.ytickmarksvisible ? "" : "checked"} value="false">
    </TD>
    </TR>
	<TR>
    <TD>X ticklabelsvisible</TD>
    <TD>
        on&nbsp;<INPUT type="RADIO" name="xticklabelsvisible" ${params.xticklabelsvisible ? "checked" : ""} value="true">&nbsp;off&nbsp;<INPUT type="RADIO" name="xticklabelsvisible" ${params.xticklabelsvisible ? "" : "checked"} value="false">
    </TD>
	</TR>
	<TR>
    <TD>Y ticklabelsvisible</TD>
    <TD>
        on&nbsp;<INPUT type="RADIO" name="yticklabelsvisible" ${params.yticklabelsvisible ? "checked" : ""} value="true">&nbsp;off&nbsp;<INPUT type="RADIO" name="yticklabelsvisible" ${params.yticklabelsvisible ? "" : "checked"} value="false">
    </TD>
    </TR>

    <TR>
    <TD>legend</TD>
    <TD>
        on&nbsp;<INPUT type="RADIO" name="legend" ${params.legend ? "checked" : ""} value="true">&nbsp;off&nbsp;<INPUT type="RADIO" name="legend" ${params.legend ? "" : "checked"} value="false">
    </TD>
    </TR>
    <TR>
    <TD>legend anchor</TD>
    <TD>
        north&nbsp;<INPUT type="RADIO" name="legendAnchor" <% if (params.isLegendAnchorSelected("north"))%>checked<%;%> value="north">
        &nbsp;south&nbsp;<INPUT type="RADIO" name="legendAnchor" <% if (params.isLegendAnchorSelected("south"))%>checked<%;%> value="south">
        &nbsp;west&nbsp;<INPUT type="RADIO" name="legendAnchor" <% if (params.isLegendAnchorSelected("west"))%>checked<%;%> value="west">
        &nbsp;east&nbsp;<INPUT type="RADIO" name="legendAnchor" <% if (params.isLegendAnchorSelected("east"))%>checked<%;%> value="east">
    </TD>
    </TR>
</TABLE>
