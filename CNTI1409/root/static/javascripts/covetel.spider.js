var intervalo;

function getDatos (){
	var id = $("div.spider_id").attr('id');
	if (id){
		var fields = id.split('_');
		id = fields[2];
	}

	$.getJSON('/ajax/spider/monitor/'+id,function(datos){
		$("#spider_total_urls").html(datos.urls_total);
		// Cargo las url
		var ul = '<ul class="urls_spider">';
		var li = '';
		datos.urls.forEach(function(url){
			li = '<li>' + url + '</li>';
			ul += li;
		});
		ul += '</ul>';
		$(".spider_id").html(ul);
		$("#spider_estado").html("Trabajando")
		if (datos.estado == 2){
			$("#spider_estado").html("Terminado").addClass("important");
			$("button#spider_descargar_muestra").button("enable");
			window.clearInterval(intervalo);
			$("button#spider_descargar_muestra").click(function(){
				location.href = '/spider/muestra/'+id;
			});
		} 
	});
}
$(document).ready(function(){
	var id = $("div.spider_id").attr('id');
	if (id){
		var fields = id.split('_');
		id = fields[2];
		if (id > 0){
			$("button#spider_descargar_muestra").button({ icons: {primary:'ui-icon-note'} });
			//console.log("HOlaa");
			intervalo = window.setInterval(getDatos,1000);
		}
	}
});
