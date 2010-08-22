/* 
Archivo: 	covetel.wizard.js
Autor: 		Walter Vargas <walter@covetel.com.ve>
Descripción: Esta libreria se encarga de controlar el comportamiento del Wizard para generar los reportes.
*/


function autocomplete_filtro(filtro){
	var tabla;
	if ( filtro == 'idev' ) { tabla = 'entidades'; }
	if ( filtro == 'idinstitucion' ) { tabla = 'instituciones'; }

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
	

});
