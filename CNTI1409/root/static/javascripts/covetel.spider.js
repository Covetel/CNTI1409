var intervalo;

function getDatos (){
	var id = $("div.spider_id").attr('id');
	if (id){
		var fields = id.split('_');
		id = fields[2];
	}

	$.getJSON('/ajax/spider/monitor/'+id,function(datos){
        if (datos) {
			$("#spider_total_urls").html(datos.urls_total);
			// Cargo las url
			var ul = '<ul class="urls_spider">';
			var li = '';
			datos.urls.forEach(function(url){
				li = '<li>' + url + '</li>';
				ul += li;
			});
			ul += '</ul>';
			$(".spider_id").html(ul);
			$("#spider_estado").html("Trabajando");
			if (datos.estado == 2){
				$("#spider_estado").html("Terminado").addClass("important");
				$("button#spider_descargar_muestra").button("enable");
	            $("#spider_stop").button("disable");
				// Si la cantidad de urls obtenidas es igual a 0 entonces hay un problema. 
				var turls = $("#spider_total_urls").html();
				if (turls == 0){
					alert("Ocurrió un error obteniendo la muestra automáticamente, contacte al administrador.");
					$("#spider_estado").html("Error").addClass("important");
				}
				window.clearInterval(intervalo);
				$("button#spider_descargar_muestra").click(function(){
					location.href = '/spider/muestra/'+id;
				});
			} 
        }
	});
}

$(document).ready(function(){
	var id = $("div.spider_id").attr('id');
    if (id){
	    var fields = id.split('_');
	    var pid = fields[3];
	    id = fields[2];
    }
	$("button#spider_descargar_muestra").click(function(){
		location.href = '/spider/muestra/'+id;
	});
	$("#spider_stop").button();
    $("#spider_stop").button({ icons: {primary:'ui-icon-circle-close'} });
    $("#spider_stop").click(function(){
        if (confirm("¿Esta usted seguro?")){
            //Obtengo el PID del proceso. 
	        window.clearInterval(intervalo);
	        $("#spider_stop").button("disable");
		    $("#spider_descargar_muestra").button("enable");
		    $("#spider_estado").html("Detenido").addClass("important");
	        location.href = '/spider/kill/'+pid+'/'+id;
        } else {
            return false;
        }
    });
});


$(document).ready(function(){
	var id = $("div.spider_id").attr('id');
	if (id){
		var fields = id.split('_');
		id = fields[2];
		if (id > 0){
			$("button#spider_descargar_muestra").button({ icons: {primary:'ui-icon-note'} });
			intervalo = window.setInterval(getDatos,1000);
		}
	}
});
