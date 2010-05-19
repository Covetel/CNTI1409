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
	$("button#reporte").button({ disabled: true });
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
	if (estado == 'Cerrada'){
		$("button#reporte").button({disabled: false});
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
			location.href = '/auditoria/detalle/'+id+'/Domain';
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
	
	// Detalle
	$("form#disposicion").attr("onsubmit","return false");
	
	$("div#progreso").css('text-align','left').height('85px');
	$("form#disposicion div#progreso").css('font-size','0.9em');
	//$("form#disposicion textarea").width('100%').val('');
	$("form#disposicion textarea").width('100%');
	$("form#disposicion").css('font-size','0.9em');
	$("form#disposicion").css('text-align','left');
	//$("form#disposicion div.multi").width('580px');

	// Botonera de disposiciones en la vista de detall
    $("div#nav button").click(function(){
        var id = $(this).attr("id");
		if (id){
			var fields = id.split('-');
			location.href = '/auditoria/detalle/'+fields[1]+'/'+fields[0];
		} 
	});


	$("div#nav button").button({icons: {primary:'ui-icon-circle-zoomin'} });
	$("div#nav button").css('font-size','0.7em').css('margin-top','5px');	
	$("button.activa").button({icons: {primary: 'ui-icon-folder-open'}, disabled: true}).css('font-size','1em');

	$("button#guardar").button({icons: {primary:'ui-icon-disk'}});
	$("button#cerrar").button({icons: {primary:'ui-icon-disk'}});
	

	var acciones_correctivas = $("#acciones_correctivas").val();
    if (acciones_correctivas != ''){
        $("button#guardar").button({disabled: true});
        $("textarea#acciones_correctivas").attr('disabled','disabled');
    }
    
    // click de las UL
    //$("ul.urls").children().each.click(function(){
    //   alert("hola"); 
    //});
        
    $("button#guardar").click(function(){
		//Obtengo el valor del textarea acciones_correctivas. 
		var acciones_correctivas = $("#acciones_correctivas").val();
		if (acciones_correctivas != ''){
			
			//Array para guardar las url.
			var urls = new Array();
			
			//Saco las urls de la lista ul.urls y lleno el array
			$("ul.urls").children().each(function() {
				urls.push($(this).html());	
			});
	
			
			//Obtengo el nombre de la disposición y el ID de la auditoría. 
			var x 				= $("button.activa").attr('id');
			var y 				= x.split('-');
			var disposicion 	= y[0];
			var id 				= y[1];
	
			//Obtengo el resultado de la disposición, que esta en el atributo title de la imagen 
	 		//en el span con ID icon
			var resultado 		= $("span#icon img").attr('title');
			
			//Creo un objeto llamado datos, para enviarlo al servidor.
	        var datos = ({'disposicion': disposicion, 'id': id, 'resultado': resultado, 'urls': urls, 'acciones': acciones_correctivas});
			$.post('/auditoria/detalle/',datos,function(respuesta){
				if (respuesta == 1){
					$("div.error_disposicion").hide("slow");
					$("div.mensaje_disposicion").show("slow");
					$("button#guardar").button({disabled: true});
					$("textarea").attr('disabled','disabled');
				} else {
					$("div.error_disposicion").show("slow");
				}		
			});
		} else {
			$("div.ui-state-error p").append("<div>Debe llenar el campo <strong> Acciones Correctivas </strong></div>");
			$("div.error_disposicion").show("slow");
		}	
	});
    
    $("button#cerrar").click(function(){
        var x = $("button.activa").attr('id');
        var y = x.split('-');
        var id = y[1];
        var datos = ({'id': id, 'cerrar': 1});
        if (confirm("Esta seguro de cerrar esta auditoría?")) {
            $.post('/auditoria/detalle/',datos, function(respuesta){
                    if (respuesta == 1) {
                        window.location = "/reportes/auditoria/"+id;
                    }
                });
        }
    });


	$("button#reporte").click(function(){
		// obtengo el ID del atributo id de la tabla con clase resumen 
		var attr_id = $("table.resumen").attr('id');
		var attr 	= attr_id.split('_');
		var id 		= attr[1];
		if (id > 0) {
			 window.location = "/reportes/auditoria/"+id;
		}		


	});
});
