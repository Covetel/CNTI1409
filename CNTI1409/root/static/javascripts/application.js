/*

*/

// Variables globales
var oTable;
var oEntidades;
var oAuditoria;
var oMetas;
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

// Esta fución ejecuta las siguientes tareas: 
// * Agrega background rojo a la fila que esta desactivada. 
// * Remueve a los td hijos la posibilidad de ser editados. 
function fila_desactivar(tabla) {
	$("#"+tabla+" tbody tr td > div").each(function(){
		var estado = $(this).children().html();	// Obtengo el estado del boton Activar/Desactivar. 
		// Si esta en Activar entonces esa fila esta desactivada, no podra editarse, tendrá otro color.
		if (estado == 'Activar'){	
			$(this).parent().parent().removeClass('odd');
			$(this).parent().parent().removeClass('even');
			$(this).parent().parent().addClass('field_disabled');
			$(this).parent().parent().children().removeClass('tEdit');
		}
	});
}

// El boton desactivar de las tablas. 
function boton_desactivar_activar(){
	$("button.desactivar,button.activar").click(function(){
		var boton = $(this);
		var tr = $(this).parent().parent().parent();
		var id = $(this).attr('id');
		var datos = id.split('_');
		var tabla = datos[0];
		var accion = datos[1];
		var registro = datos[2];
		var codigo = ({ 'codigo': registro});
		var tr;
		var oDataTables;
		if (tabla == 'instituciones') {
			oDataTables = oTable;
		} else if (tabla == 'entidades'){
			oDataTables = oEntidades;
		}
		
		if (accion == 'activar'){
			var c = confirm("Esta usted seguro de lo que esta haciendo ?");
			if (c) {
				var jsoon = $.JSON.encode(codigo);
				$.ajax({
					url: "/ajax/tabla/"+tabla, 
					type: "PUT",
					data: jsoon,
					processData: false,
					contentType: 'application/json',
					complete: function (data) {
						var datos = $.parseJSON(data.responseText);
						if (datos.valor == 1){
							tr.removeClass('field_disabled');
							// Aplico el estilo dependiendo de la fila sea par o impar.
							var pos = oDataTables.fnGetPosition(tr.get(0));
							if (pos%2 == 0){
								tr.addClass('even');
							} else {
								tr.addClass('odd');
							}
							tr.children().addClass('tEdit');
							//tr.children(".tEdit").editable(submitEdit);
							boton.attr('id',tabla+'_'+'desactivar'+'_'+registro);
							boton.html('Desactivar');
						} else if (datos.valor == 403){
							alert("No es posible activar el registro, ocurrio un error grave !");
						}
					},
				}); // Fin de ajax

			}
		} else if (accion == 'desactivar'){
			var c = confirm("Esta usted seguro de lo que esta haciendo ?");
			if (c){
				var jsoon = $.JSON.encode(codigo);
				$.ajax({
					url: "/ajax/tabla/"+tabla, 
					type: "DELETE",
					data: jsoon,
					processData: false,
					contentType: 'application/json',
					complete: function (data) {
						var datos = $.parseJSON(data.responseText);
						//console.log(datos.valor);
						if (datos.valor == 1){
							tr.addClass('field_disabled');	
							tr.removeClass('odd');
							tr.removeClass('even');
							tr.addClass('field_disabled');
							tr.children().removeClass('tEdit');
							boton.attr('id',tabla+'_'+'activar'+'_'+registro);
							boton.html('Activar');
						} else if (datos.valor == 403){
							alert("No es posible desactivar, el registro esta siendo usado en la auditoría correspondiente al portal: "+datos.auditoria);
						}
					},
				}); // Fin de ajax
				
			}	
		}
	});
}

$(document).ready(function(){

// Utilizado por la ventana de login. 
$("#area_aplicacion_login").accordion({ collapsible: false ,active: 0 });
$("#area_aplicacion_login form").css('margin-left','200px');
$("#area_aplicacion_login div.mensaje").css('margin-left','200px');


// Configuro el comportamiento del icono para ajax.
$("#loading").hide();
$("#loading").ajaxStart(function(){
   $(this).fadeIn();
});

$("#loading").ajaxStop(function(){
   $(this).fadeOut();
});


	$(".input_reset").click(function(){
		$(".input_text").val('');
		$("textarea").val('');
	});

    // Mascaras de entrada
    $("#phone").mask("(9999) 999-9999");

	// Autocomplete para el campo Institucion.
	$("#idinstitucion").autocomplete({
		source: '/ajax/autocompletar/instituciones',
		minLength: 3,
	})
	
	// Autocomplete para el campo Entidades.
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
	$("#area_aplicacion div.ui-accordion-content").height('600px');

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

    /* Función que envía el dato a editar en la tabla
     * parametros a la controladora por AJAX
     */
    function submitEditMetas(value, settings)
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
            url: "/ajax/tabla/metaetiquetas", 
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
		"aaSorting": [[ 8, "desc" ]],
		"aoColumns": [
						{"bSearchable": false, "bVisible": false},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						//{"bSearchable": false, "bSortable": false, "sClass": "tDesactivar"},
						{"bSearchable": false, "bSortable": true},
					], 
 		"oLanguage": {
            "sUrl": "/static/javascripts/dataTables.spanish.txt"
        },
		"fnDrawCallback": function () {
			//Aplicar aspecto a las filas inhabilitadas.	
			fila_desactivar('tabla_instituciones');
			$("#tabla_instituciones tbody td.tEdit").editable(submitEdit);
			//$("div.borrar").html("<button class='borrar'> Desactivar </button>");
			boton_desactivar_activar();
			$("button.borrar").click(function (){
 				var tr = oTable.fnGetPosition(this.parentNode.parentNode.parentNode); 
				var c = confirm("¿ Esta seguro de lo que esta haciendo ?");
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
	}); // Fin de DataTables.

	// Maneja las propiedades de la tabla entidades
	oEntidades = $("#tabla_entidades").dataTable({
		"sAjaxSource": '/ajax/tabla/entidades',
        "bAutoWidth": false,
		"bProcessing": false,
		"bJQueryUI": true,
		"aaSorting": [[ 9, "desc" ]],
		"aoColumns": [
						{"bSearchable": false, "bVisible": false},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
						{"bSearchable": false, "sClass": "tDesactivar"},
                    ], 
 		"oLanguage": {
            "sUrl": "/static/javascripts/dataTables.spanish.txt"
        },
		"fnDrawCallback": function () {
			fila_desactivar('tabla_entidades');
			$("#tabla_entidades tbody td.tEdit").editable(submitEditEntidad);
            $("div.borrar").html("<button class='borrar'> Desactivar </button>");
			boton_desactivar_activar();
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

    // Maneja las propiedades de la tabla metas
	oMetas = $("#tabla_metas").dataTable({
		"sAjaxSource": '/ajax/tabla/metaetiquetas',
        "bAutoWidth": false,
		"bProcessing": false,
		"bJQueryUI": true,
		"aaSorting": [[ 9, "desc" ]],
		"aoColumns": [
						{"bSearchable": false, "bVisible": false},
						{"sClass": "tEdit"},
						{"sClass": "tEdit"},
                    ], 
 		"oLanguage": {
            "sUrl": "/static/javascripts/dataTables.spanish.txt"
        },
		"fnDrawCallback": function () {
			fila_desactivar('tabla_metas');
			$("#tabla_metas tbody td.tEdit").editable(submitEditMetas);
            $("div.borrar").html("<button class='borrar'> Eliminar </button>");
			boton_desactivar_activar();
            $("button.borrar").click(function(){
                    var tr = oEntidades.fnGetPosition(this.parentNode.parentNode.parentNode);
                    var c = confirm("Está seguro de eliminar este registro ?");
                    if (c) {
                        var id      = $(this).parent().attr('id');
                        var codigo  = id.split("_");
                        codigo      = ({ 'codigo': codigo[1]});
                        var jsoon   = $.JSON.encode(codigo);
                        $.ajax({
                            url: "/ajax/tabla/metaetiquetas",
                            type: "DELETE",
                            data: jsoon,
                            processData: false,
                            contentType: 'application/json',
                            complete: function (data) {
                                    delTr(tr, "metas");
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
						{"sClass": "estado"},
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

                       


	// Cambio dinámicamente los nombres de los campos en los mensajes de error. 
	// campo idinstitucion
	var error = $("div.ui-state-error p").html();
	var re 	= /idinstitucion/gi;
	var re2 = /idev/gi;
	var re3 = /portal/gi;
	var re4 = /Examinar/gi;
	var re5 = /nombre/gi;

	if (re.test(error)){
		var error_new = error.replace(re,'<span class="strong">Nombre Instituci&oacute;n</span>');
		$("div.ui-state-error p").html(error_new);
	} 
	
	if (re2.test(error)){
		var error_new = error.replace(re2,'<span class="strong">Nombre Entidad Verificadora</strong>');
		$("div.ui-state-error p").html(error_new);
	}
	
	if (re3.test(error)){
		var error_new = error.replace(re3,'<span class="strong">Nombre del Portal</strong>');
		$("div.ui-state-error p").html(error_new);
	}
	
	if (re4.test(error)){
		var error_new = error.replace(re4,'<span class="strong">Muestra</strong>');
		$("div.ui-state-error p").html(error_new);
	}
	
	if (re5.test(error)){
		var error_new = error.replace(re4,'<span class="strong">Muestra</strong>');
		$("div.ui-state-error p").html(error_new);
	}

	// Tabs en los reportes
	$("div#reporte_tabs").tabs({selected: 0});

}); // Cierra 
