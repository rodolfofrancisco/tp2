<TABLE>
    <TR>
	    <TD align="left" nowrap><INPUT type="RADIO" <% if (params.getMimeType().equals(de.laures.cewolf.WebConstants.MIME_PNG))%>checked<%;%> name="mimeType" value="<%= de.laures.cewolf.WebConstants.MIME_PNG %>">PNG</TD>
	    <TD align="left" nowrap><INPUT type="RADIO" <% if (params.getMimeType().equals(de.laures.cewolf.WebConstants.MIME_SVG))%>checked<%;%> name="mimeType" value="<%= de.laures.cewolf.WebConstants.MIME_SVG %>">SVG</TD>
    </TR>
    <TR>
        <TH colspan="2">Background Paint</TH>
    </TR>
    <TR>
    <TD align="left" nowrap colspan="2"><INPUT type="RADIO" <% if (params.isSelectedPaint("color"))%>checked<%;%> name="paint" value="color">Color Paint</TD>
    </TR>
    <TR>
    <TD width="20">&nbsp;</TD>
    <TD>
        <TABLE>
        <TR>
        <TD>color</TD>
        <TD><INPUT type="TEXT" name="colorColor" value="${params.colorColor}"></TD>
        </TR>
        </TABLE>
    </TD>
    </TR>
    <TR>
    <TD align="left" nowrap colspan="2"><INPUT type="RADIO" <% if (params.isSelectedPaint("gradient"))%>checked<%;%> name="paint" value="gradient">Gradient&nbsp;Paint</TD>
    </TR>
    <TR>
    <TD>&nbsp;</TD>
    <TD>
        <TABLE>
            <TR>
                <TD>x1&nbsp;</TD><TD><INPUT type="TEXT" name="gradientX1" value="${params.gradientX1}" size="5"></TD>
                <TD>x2&nbsp;</TD><TD><INPUT type="TEXT" name="gradientX2" value="${params.gradientX2}" size="5"></TD>
            </TR>
            <TR>
                <TD>y1&nbsp;</TD><TD><INPUT type="TEXT" name="gradientY1" value="${params.gradientY1}" size="5"></TD>
                <TD>y2&nbsp;</TD><TD><INPUT type="TEXT" name="gradientY2" value="${params.gradientY2}" size="5"></TD>
            </TR>
            <TR>
                <TD>color1&nbsp;</TD><TD><INPUT type="TEXT" name="gradientColor1" value="${params.gradientColor1}" size="9"></TD>
                <TD>color2&nbsp;</TD><TD><INPUT type="TEXT" name="gradientColor2" value="${params.gradientColor2}" size="9"></TD>
            </TR>
            <TR>
                <TD>cyclic&nbsp;</TD>
                <TD>on&nbsp;<INPUT type="RADIO" name="cyclic" ${params.cyclic ? "checked" : ""} value="true">&nbsp;off&nbsp;<INPUT type="RADIO" name="cyclic" <% if(!params.getCyclic())%>checked<%;%> value="false"></TD>
            </TR>
        </TABLE>
    </TD>
    </TR>
    <TR>
    <TD align="left" nowrap colspan="2"><INPUT type="RADIO" <% if (params.isSelectedPaint("texture"))%>checked<%;%> name="paint" value="texture">Texture Paint</TD>
    </TR>
    <TR>
    <TD width="20">&nbsp;</TD>
    <TD>
        <TABLE>
        <TR>
        <TD>image</TD>
        <TD><INPUT type="TEXT" name="textureImage" value="${params.textureImage}"></TD>
        </TR>
        <TR>
        <TD>width&nbsp;</TD><TD><INPUT type="TEXT" name="textureWidth" value="${params.textureWidth}" size="5"></TD>
        <TD>height&nbsp;</TD><TD><INPUT type="TEXT" name="textureHeight" value="${params.textureHeight}" size="5"></TD>
        </TR>
        </TABLE>
    </TD>
    </TR>
</TABLE>
