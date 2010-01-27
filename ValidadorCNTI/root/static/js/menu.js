$(document).ready(function(){
		var url = document.location.href; 
		var lista = url.split('/');
		$("ul#menu li").children().each(function(){
			var path 	= $(this).attr('href');
			var str 	= path.split('/')
			if (str[2] == lista[4]) {
				$(this).parent().addClass('select');
			}
		});

		// Ajax Send 
});

