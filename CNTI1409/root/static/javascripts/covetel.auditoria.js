/* 
Archivo: 	covetel.auditoria.js
Autor: 		Walter Vargas <walter@covetel.com.ve>
Descripción: Esta libreria se encarga de controlar el monitor de Jobs y los elementos del control auditoria. 
*/

$("document").ready(function(){
	//Cambio el boton Iniciar Auditoria, por un boton jquery ui
	$("button#iniciar_auditoria").button({ icons: {primary:'ui-icon-gear'} });
	$("button#detalle_auditoria").button({ icons: {primary:'ui-icon-circle-zoomin'} });
	$("button#reporte").button({ icons: {primary:'ui-icon-note'} });
	$("#reporte").button({ disabled: true });
	$("button#iniciar_auditoria").click(function(){
		// Capturo el ID de la auditoria, que se encuentra en el atributo ID de la tabla. 
		var id = $("table.resumen").attr('id');
		var fields = id.split('_');
		id = fields[1];
		location.href = '/auditoria/monitor/'+id;
	});

	//Si el estado de la auditoría es 'Abierta' o 'Cerrada', deshabilito el boton iniciar auditoria. 
	var estado = $("#estado").html();
	if (estado == 'Abierta' || estado == 'Cerrada'){
		$("button#iniciar_auditoria").button({disabled: true});
	}
	if (estado == 'Pendiente'){
		$("button#detalle_auditoria").button({disabled: true});
	}

	// Click en el boton detalle_auditoria
	$("button#detalle_auditoria").click(function(){
		var id = $("table.resumen").attr('id');
		if (id){
			var fields = id.split('_');
			id = fields[1];
			location.href = '/auditoria/detalle/'+id;
		}
		
	});
	

	// Monitoreo 
	var intervalo;
	function getDatos (){
		var id = $("table.resumen").attr('id');
		if (id){
			var fields = id.split('_');
			id = fields[1];
		}
		$.getJSON('/ajax/monitor/auditoria/'+id,function(datos){
			$("#total_done").html(datos.total_done);
			$("#total_pendientes").html(datos.total_pendientes);
			total_url = datos.total_url;
			total_done = datos.total_done;
			var porcentaje = (total_done / total_url) * 100; 
			// Cargo las url
			var ul = '';
			var li = '';
			datos.url_done.forEach(function(url){
				li = '<li>' + url + '</li>';
				ul += li;
			});
			$("ul.urls").html(ul);
			$("#barra_progreso").progressbar({ value: porcentaje });
			if (porcentaje == 100){
				window.clearInterval(intervalo);
			}
		});
	}
	
	$("#total_url").ready(function(){
		var total_url = $("#total_url").html();
		var total_done = $("#total_done").html();
		var porcentaje = (total_done / total_url) * 100; 
		$("#barra_progreso").progressbar({ value: porcentaje });
		if (porcentaje < 100){
			intervalo = window.setInterval(getDatos,1000);
		}
	});
	
});
