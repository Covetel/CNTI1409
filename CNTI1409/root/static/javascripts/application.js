/*

*/
var oTable;
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
			$("#tabla_instituciones tbody td").editable('/ajax/instituciones', {
				"callback": function (sValue, y){
					var aPos = oTable.fnGetPosition( this );
					oTable.fnUpdate( sValue, aPos[0], aPos[1] );
				},
				// esta rutina costo sangre, no tocar!
				"submitdata": function (value,settings) {
						var aPos = oTable.fnGetPosition( this );
						var tr = this.parentNode;
						var datos = oTable.fnGetData(tr);
						return { "id": datos[0] };
				},
				});
		},
	});

});
