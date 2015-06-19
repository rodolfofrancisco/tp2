<%-- 
    Document   : index
    Created on : Jun 16, 2015, 9:43:57 PM
    Author     : luizhenrique
--%>

<%@page contentType="text/html"%>
<%@taglib uri='/WEB-INF/cewolf.tld' prefix='cewolf' %>
<HTML>
    <BODY>
        <H1>Criminalidade em Belo Horizonte</H1>
        <HR>
        <!--Gr�fico temporal-->
        <jsp:useBean id="temporal" class="graficos.GraficoTemporal"/>
        <cewolf:chart 
            id="line" 
            title="Gr�fico temporal" 
            type="line" 
            xaxislabel="Data" 
            yaxislabel="Quantidade de crimes">
            <cewolf:data>
                <cewolf:producer id="temporal"/>
            </cewolf:data>
        </cewolf:chart>
        <p>
        <cewolf:img chartid="line" renderer="cewolf" width="400" height="300"/>
        <P>
        
        <!--Gr�fico espacial-->
        <jsp:useBean id="espacial" class="graficos.GraficoEspacial"/>
        <cewolf:chart 
            id="verticalBar" 
            title="Gr�fico espacial" 
            type="verticalBar" 
            xaxislabel="Localidade" 
            yaxislabel="Quantidade de crimes">
            <cewolf:data>
                <cewolf:producer id="espacial"/>
            </cewolf:data>
        </cewolf:chart>
        <p>
        <cewolf:img chartid="verticalBar" renderer="cewolf" width="400" height="300"/>
        <P>
    </BODY>
</HTML>
