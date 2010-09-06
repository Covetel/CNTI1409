/* 
Archivo: 	Covetel.Usuario.js
Autor: 		Walter Vargas <walter@covetel.com.ve>
Descripción: Esta libreria se encarga de manejar los datos del usuario y sus respectivos roles.
*/

function Covetel_usuario (){
	// Busco los datos del usuario via AJAX al Servidor.
	this.datos = eval('('+$.ajax({
		async: false,
		url: '/ajax/usuario/datos/',
		dataType: "json",
		complete: this.set,
	}).responseText+')');
	
	// Declaro los atributos del usuario.
	this.cn = this.datos.cn;
	this.roles = new Array();
	this.roles = this.datos.roles;
	this.uid = this.datos.uid;

	// Este método busca el rol, en la lista de roles. 
	this.check_any_user_roles = function (r){
		for (key in this.roles){
			if (r == this.roles[key]) {return true;};
		}
	}

}

var usersTable = null;

if (!usuario){
	var usuario = new Covetel_usuario();
}

$(document).ready(function(){
	
	// Creo el fieldset Entidad Verificadora si el rol es Auditor o AuditorJefe	
	$("#rol").change(function(){
		var rol = $("#rol :selected").val();
		if (rol == 'auditor' || rol == 'auditorJefe') {
			$("#fielset_entidad_verificadora").show("fast");	
		} else if (rol == 'administrador'){
			$("#fielset_entidad_verificadora").hide("fast");	
		}
	});

	// Autocreate del uid.
	$("#uid").focus(function(){
		//Busco el nombre 
		var nombre = $("#nombre").val();
		//Busco el apellido
		var apellido = $("#apellido").val();
		//Llevo todo a minusculas.
		nombre = nombre.toLowerCase();
		apellido = apellido.toLowerCase();	
		//Saco la primera letra del nombre para el uid
		var uid = nombre.charAt(0);
		uid += apellido;
		
		//Asigo al valor de uid. 
		$("#uid").val(uid);
	});


	//Valido que las contraseñas sean iguales.
	$("#passwd2").blur(function(){
		//Leo el valor del passwd1 y lo comparo con el valor de passwd2
		var p1 = $("#passwd").val();
		var p2 = $("#passwd2").val();
		if (p1 != p2) {

			$("#passwd").val('');
			$("#passwd2").val('');
			$("#passwd").focus();
			$("#passwd").parent().addClass("error error_constraint_required");
			$("#passwd2").parent().addClass("error error_constraint_required");
		
			$("#passwd").qtip({
				content: 'Las contraseñas no coinciden',
				show: { ready: true },
				position: { adjust: {x: 0, y: -20} }
			});

		} else {
			$("#passwd").parent().removeClass("error error_constraint_required");
			$("#passwd2").parent().removeClass("error error_constraint_required");
		}
	});

	//Valido que el uid no este ya registrado en el LDAP. 
	$("#uid").blur(function(){
		var uid = $("#uid").val();
		this.datos = eval('('+$.ajax({
			async: false,
			url: '/ajax/usuario/datos/',
			dataType: "json",
			complete: this.set,
		}).responseText+')');
		
	});


	// Population to table users.
	usersTable = $("#tabla_usuarios").dataTable({
		"sAjaxSource": '/ajax/tabla/usuarios',
        "bAutoWidth": false,
		"bProcessing": false,
		"bJQueryUI": true,
		//"aaSorting": [[ 8, "desc" ]],
 		"oLanguage": {
            "sUrl": "/static/javascripts/dataTables.spanish.txt"
        },
	});


	//Información del usuario. 
	$("div#usuario_tabs").tabs();	

});
