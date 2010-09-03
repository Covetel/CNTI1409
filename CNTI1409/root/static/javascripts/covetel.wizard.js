/* 
Archivo: 	covetel.wizard.js
Autor: 		Walter Vargas <walter@covetel.com.ve>
Descripción: Esta libreria se encarga de controlar el comportamiento del Wizard para generar los reportes.
*/


function autocomplete_filtro(filtro){
	var tabla;
    if ( filtro == 'idev' ) { 
		tabla = 'entidades'; 
		$("div.label > label").each(function(){
			if ($(this).attr('for') == 'patron'){
				$(this).html('Nombre de la Entidad');
			}
		});
	}
	if ( filtro == 'idinstitucion' ) { 
		tabla = 'instituciones';
		$("div.label > label").each(function(){
			if ($(this).attr('for') == 'patron'){
				$(this).html('Nombre de la Institución');
			}
		});
	}

	$("#patron").autocomplete({
		source: '/ajax/autocompletar/'+tabla,
		minLength: 3,
	})
	
}

$("document").ready(function(){

	$("#desde").focus().datepicker({ dateFormat: 'dd-mm-yy' });
	$("#hasta").focus().datepicker({ dateFormat: 'dd-mm-yy' });
	
	// Obtengo el filtro seleccionado.
	$("#filtro").change(function(){
		$("#patron").val('');
		var filtro = $("#filtro :selected").val();
		autocomplete_filtro(filtro);	
	});
	
	$("#reporte_auditorias tr:odd").addClass('odd'); 
	$("#reporte_auditorias tr:even").addClass('even'); 
	
	$("#print").click(function(){
		$("#cintillo_institucional, #informacion_sesion, #menu_vertical").hide("slow"); 
		$("div#area_aplicacion").css('margin-left','2px').width("100%");
		$("#printOut").css('display','block');
		$("#print").hide();
	});
	
	$("#printOut").click(function(){
		$("#cintillo_institucional, #informacion_sesion, #menu_vertical").show("slow"); 
		$("div#area_aplicacion").css('margin-left','146px').width("85%");
		$("#print").show();
		$("#printOut").hide();
	});
	

});
