/* 
Archivo: 	reportes.js
Autor: 		Walter Vargas <walter@covetel.com.ve>
Descripción: Esta libreria se encarga de controlar el aspecto de los reportes. 
*/


$("document").ready(function(){

	$("#tabla_reporte tr:odd").addClass('odd'); 
	$("#tabla_reporte tr:even").addClass('even'); 


    $("button#ver_urls").click(function(){
        var disp = $(this).attr('class');
        var id = $("#auditoria_id").html();
        $("div.urls_"+disp).load("/reportes/urls_report/"+id+"/"+disp);
    });

    $("button#cerrar_urls").click(function(){
        var disp = $(this).attr('class');
        $("div.urls_"+disp).empty();
    });

});
