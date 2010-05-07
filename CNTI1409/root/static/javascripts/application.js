/*

*/
var oTable;
var oEntidades;
var giRedraw = false;

$(document).ready(function(){
	// Edit in Place, para las tablas. 

	$("#menu_vertical").accordion({ collapsible: true ,active: 20 });
	$("#area_aplicacion").accordion({ collapsible: false ,active: 0 });

	// Calendario 
	$("#calendario").datepicker();
	
	// Pestañas
	$("#tabs").tabs();

	// Formularios. 
	// Borde de color en el foco al input
	$("input.input_text").focus(
		function(){
			$(this).addClass("input_text_focus");
		}).blur(
		function(){
			$(this).removeClass("input_text_focus");
		}
	);
	// Borde de color en el foco al textarea
	$("textarea").focus(
		function(){
			$(this).addClass("textarea_focus");
		}).blur(
		function(){
			$(this).removeClass("textarea_focus");
		}
	);
	
	// Foco al primer input de los formularios
	$(".input_text:first").focus();

	//
	$(".input_submit").button();

function submitEdit(value, settings)
{ 
	var n = $(this).index();
	var o = $("th").get(n);
	var campo = $(o).attr('id');
	var aPos = oTable.fnGetPosition( this );
	var tr = this.parentNode;
	var d = oTable.fnGetData(tr);
   	var datos = ({'valor': value, 'id': d[0], 'campo': campo});
   	var jsoon = $.JSON.encode(datos);
   	$.ajax({
		url: "/ajax/tabla/instituciones", 
		type: "POST",
		data: jsoon,
		processData: false,
		contentType: 'application/json',
   	});
 return value;
}


function submitEditEntidad(value, settings)
{ 
	var n = $(this).index();
	var o = $("th").get(n);
	var campo = $(o).attr('id');
	var aPos = oEntidades.fnGetPosition( this );
	var tr = this.parentNode;
	var d = oEntidades.fnGetData(tr);
   	var datos = ({'valor': value, 'id': d[0], 'campo': campo});
   	var jsoon = $.JSON.encode(datos);
   	$.ajax({
		url: "/ajax/tabla/entidades", 
		type: "POST",
		data: jsoon,
		processData: false,
		contentType: 'application/json',
   	});
 return value;
}
	
	oTable = $("#tabla_instituciones").dataTable({
		"sAjaxSource": '/ajax/tabla/instituciones',
		"bProcessing": false,
		"bJQueryUI": true,
		"aoColumns": [
						{"bSearchable": false, "bVisible": false},
						null,
						null,
						null,
						null,
						null,
						null,
						null,
					], 
 		"oLanguage": {
            "sUrl": "/static/javascripts/dataTables.spanish.txt"
        },
		"fnDrawCallback": function () {
			$("#tabla_instituciones tbody td").editable(submitEdit);
		},
	});

	
	oEntidades = $("#tabla_entidades").dataTable({
		"sAjaxSource": '/ajax/tabla/entidades',
		"bProcessing": false,
		"bJQueryUI": true,
		"aoColumns": [
						{"bSearchable": false, "bVisible": false},
						null,
						null,
						null,
						null,
						null,
						null,
						null,
					], 
 		"oLanguage": {
            "sUrl": "/static/javascripts/dataTables.spanish.txt"
        },
		"fnDrawCallback": function () {
			$("#tabla_entidades tbody td").editable(submitEditEntidad);
		},
	});

});
