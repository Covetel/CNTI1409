/*

*/

// Variables globales
var oTable;
var oEntidades;
var oAuditoria;
var giRedraw = false;






// Función que elimina una columna en la tabla
function delTr (tr, tabla) { 
    if (tabla == "institucion" ) {
        oTable.fnDeleteRow(tr);
    } else if (tabla = "entidad" ) {
        oEntidades.fnDeleteRow(tr);
    }
    
}

function sugerencia (label, value){
	this.label = label;
	this.value = value;
}

$(document).ready(function(){

$("#area_aplicacion_login").accordion({ collapsible: false ,active: 0 });
$("#area_aplicacion_login form").css('margin-left','200px');
$("#area_aplicacion_login div.mensaje").css('margin-left','200px');


$("#loading").ajaxStart(function(){
   $(this).show();
});

$("#loading").ajaxStop(function(){
   $(this).hide();
});
	$(".input_reset").click(function(){
		$(".input_text").val('');
		$("textarea").val('');
	});

    // Mascaras de entrada
    $("#phone").mask("(999) 999-9999");

	// Autocomplete para el campo Institucion.
	$("#idinstitucion").autocomplete({
		source: '/ajax/autocompletar/instituciones',
		minLength: 3,
	})
	
	$("#idev").autocomplete({
		source: '/ajax/autocompletar/entidades',
		minLength: 3,
	})


	// Edit in Place, para las tablas. 
	// Elimina los mensajes de error de los formularios. 
	//$("span.error_message").remove();
	$("div.error").ready(function(){
		var mensaje = $(this).find('span.error_message').html();
		$(this).find('span.error_message').remove();
		//$('div.error_constraint_required > input.input_text').focus(function(){
		$('div.error > input.input_text').focus(function(){
			$(this).qtip({
				   	content: mensaje,
				   	show: { 'ready': true},
   					hide: 'mouseout',
					position: { adjust: { x: 0, y: -42}}

			});
		});
	});

    // Menú de la aplicación
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

    /* Función que envía el dato a editar en la tabla
     * instituciones a la controladora por AJAX
     */

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


    /* Función que envía el dato a editar en la tabla
     * entidades a la controladora por AJAX
     */
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

    // Maneja las propiedades de la tabla instituciones
	oTable = $("#tabla_instituciones").dataTable({
		"sAjaxSource": '/ajax/tabla/instituciones',
        "bAutoWidth": false,
		"bProcessing": false,
		"bJQueryUI": true,
		"aoColumns": [
						{"bSearchable": false, "bVisible": false},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"bSearchable": false, "bSortable": false, "sClass": "tEliminar"},
					], 
 		"oLanguage": {
            "sUrl": "/static/javascripts/dataTables.spanish.txt"
        },
		"fnDrawCallback": function () {
			$("#tabla_instituciones tbody td.tEdit").editable(submitEdit);
			$("div.borrar").html("<button class='borrar'> Eliminar </button>");
			$("button.borrar").click(function (){
 				var tr = oTable.fnGetPosition(this.parentNode.parentNode.parentNode); 
				var c = confirm("Esta seguro de eliminar este registro ?");
				if (c) {	
	 				var id 		= $(this).parent().attr('id');
	 				var codigo 	= id.split('_'); 
	 				codigo 		= ({ 'codigo': codigo[1]});
	 				var jsoon 	= $.JSON.encode(codigo);
	 				$.ajax({
	 					url: "/ajax/tabla/instituciones", 
	 					type: "DELETE",
	 					data: jsoon,
	 					processData: false,
	 					contentType: 'application/json',
	 					complete: function (data) {
	 							delTr(tr, "institucion");
	 					},
	 				}); // Fin de ajax
				} else {
					return false;	
				} 
			
			}); // Fin de click 
		},
	});

	// Maneja las propiedades de la tabla entidades
	oEntidades = $("#tabla_entidades").dataTable({
		"sAjaxSource": '/ajax/tabla/entidades',
        "bAutoWidth": false,
		"bProcessing": false,
		"bJQueryUI": true,
		"aoColumns": [
						{"bSearchable": false, "bVisible": false},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"bSearchable": false, "bSortable": false, "sClass": "tEliminar"},
                    ], 
 		"oLanguage": {
            "sUrl": "/static/javascripts/dataTables.spanish.txt"
        },
		"fnDrawCallback": function () {
			$("#tabla_entidades tbody td.tEdit").editable(submitEditEntidad);
            $("div.borrar").html("<button class='borrar'> Eliminar </button>");
            $("button.borrar").click(function(){
                    var tr = oEntidades.fnGetPosition(this.parentNode.parentNode.parentNode);
                    var c = confirm("Está seguro de eliminar este registro ?");
                    if (c) {
                        var id      = $(this).parent().attr('id');
                        var codigo  = id.split("_");
                        codigo      = ({ 'codigo': codigo[1]});
                        var jsoon   = $.JSON.encode(codigo);
                        $.ajax({
                            url: "/ajax/tabla/entidades",
                            type: "DELETE",
                            data: jsoon,
                            processData: false,
                            contentType: 'application/json',
                            complete: function (data) {
                                    delTr(tr, "entidad");
                            },
                        }); // Fin de ajax
                    } else {
                        return false;
                    }
                }); // Fin de click
		},
	});
	
    // Maneja las propiedades de la tabla auditorias
	oAuditorias = $("#tabla_auditorias").dataTable({
		"sAjaxSource": '/ajax/tabla/auditorias',
        "bAutoWidth": false,
		"bProcessing": false,
		"bJQueryUI": true,
		"aoColumns": [
						{"bSearchable": false, "bVisible": false},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
                    ], 
 		"oLanguage": {
            "sUrl": "/static/javascripts/dataTables.spanish.txt"
        },
		"fnDrawCallback": function () {
			$("#tabla_auditorias tbody tr").css('cursor','pointer');
			// En el click de la fila, el browser es dirigido al método /auditoria/resumen/id
            $("#tabla_auditorias tbody tr").click(function(event){
				var aPos 	= oAuditorias.fnGetPosition(this);
				var aData 	= oAuditorias.fnGetData(this);
				var id 		= aData[0];
				var u 		= "/auditoria/resumen/" + id;
				// Linea probada en Firefox, Chrome, Epiphany
				window.location.href = u;
            });
        },
	});

});
