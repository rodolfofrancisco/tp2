$(function () {
    $.ajax({
        url: "index?action=graph&type=bar",
        dataType:"json",
        contentType: "application/json",
        mimeType: "application/json",
        success: function(data) {
            $.each(data, function(j, aux) {
                var graph = $('<div id="chartBar'+j+'" class="chart">');
                $('.graph-bar').append(graph);
                var line = [], category = "";
                $.each(aux, function(i, json) {
                    line[i] = [json[0], parseInt(json[1])];
                    category = json[2];
                    category = category.charAt(0).toUpperCase() + category.slice(1);
                });
                $('#chartBar'+j+'').jqplot([line], {
                    title: category,
                    // Provide a custom seriesColors array to override the default colors.
                    seriesColors:['#85802b', '#00749F', '#73C774', '#C7754C', '#17BDB8'],
                    seriesDefaults:{
                        renderer:$.jqplot.BarRenderer,
                        rendererOptions: {
                            // Set varyBarColor to tru to use the custom colors on the bars.
                            varyBarColor: true
                        }
                    },
                    axesDefaults: {
                        tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
                        tickOptions: {
                            fontFamily: 'Georgia',
                            fontSize: '10pt',
                            angle: -30
                        }
                    },
                    axes:{
                        xaxis:{
                            renderer: $.jqplot.CategoryAxisRenderer
                        }
                    }
                });
            });
        }
    });
    
    
    $.ajax({
        url: "index?action=graph&type=line",
        dataType:"json",
        contentType: "application/json",
        mimeType: "application/json",
        success: function(data) {
            $.each(data, function(j, aux) {
                var graph = $('<div id="chartLine'+j+'" class="chart">');
                $('.graph-line').append(graph);
                var line = [], category = "", ticks = [];
                $.each(aux, function(i, dataloc) {
                    var aux = [];
                    $.each(dataloc, function(j, json) {
                        aux[j] = [json[3], parseInt(json[1])];
                        category = json[2];
                        category = category.charAt(0).toUpperCase() + category.slice(1);
                        ticks[i] = json[0];
                    });
                    line[i] = aux;
                });
                $('#chartLine'+j+'').jqplot('chart2', line, {
                    title: category,
                    gridPadding: {right: 35},
                    axes: {
                        xaxis: {
                            renderer: $.jqplot.DateAxisRenderer,
                            tickOptions: {formatString: '%d/%m/%Y'},
                            tickInterval:'2 days'
                        }
                    },
                    series: [{lineWidth: 4, markerOptions: {style: 'square'}}],
                    legend: { show: true, placement: 'outside', labels: ticks}
                });
            });
        }
    });

    
});