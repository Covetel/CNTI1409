/* 
Archivo: 	covetel.auditoria.js
Autor: 		Walter Vargas <walter@covetel.com.ve>
Descripción: Esta libreria se encarga de controlar el monitor de Jobs y los elementos del control auditoria. 
*/

$("document").ready(function(){
	//Cambio el boton Iniciar Auditoria, por un boton jquery ui
	$("button#iniciar_auditoria").button({ icons: {primary:'ui-icon-gear'} });
	$("button#reporte").button({ disabled: true });
	$("button#iniciar_auditoria").click(function(){
		// Capturo el ID de la auditoria, que se encuentra en el atributo ID de la tabla. 
		var id = $("table.resumen").attr('id');
		var fields = id.split('_');
		id = fields[2];
		alert(id);
		//location.href = '';
	});

});
