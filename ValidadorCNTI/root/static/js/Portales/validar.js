$("document").ready(function () {
	// Cuando el usuario hace click en el boton validar seleccionados
	// debo crear una lista con los elementos seleccionados. 
	$("#validar_solo").click(function () {
		var portales = new Array(); 
		$('input').each(function(){
			// Si es un checkbox
			if ($(this).attr('type') == 'checkbox'){
				var id = $(this).attr('value'); 
				var checked = $(this).attr('checked'); 
				if (checked == true) {
					portales.push(id);
				}
			}
		});	
		$.ajax({
		   beforeSend: function(){
				$("div.mensaje, div#validar_form label, div#validar_form input, div#validar_form button").hide().remove();
				$("#ajax").show();
		   },
		   complete: function(){
			 // Handle the complete event
			}
		});
		// Envio de los portales al servidor via post 
		$("div#validar_form").load("/portales/validar",{portales: portales}, function(){ 
			// Le aplico curvy corners a la tabla del reporte. 
			$("div#reporte").corner();

		});

	}); 	
});
