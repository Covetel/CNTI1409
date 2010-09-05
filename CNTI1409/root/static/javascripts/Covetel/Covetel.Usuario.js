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

var usuario = new Covetel_usuario();
