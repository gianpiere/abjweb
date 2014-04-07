$('#btn_registrar').on('click',function(){
	// Registro de Usuarios
	$.ajax({
		type		: 'POST',
		data 		: $('#registrar').serialize(),
		url 		: 'registrar',
		success 	: function(data){
			try{
				$data = $.parseJSON(data);
					if($data[0] == 'OK'){
						window.location.href="Account/#"+$data[1]
					}else{
						console.log('ups... ERROR');
					}
			}catch(e){}
		},
		error 		: function(){

		}
	})
	return false;
});

$('#btn_iniciarsession').on('click',function(){
	console.log('mensajito2');
	return false;
});

$('#facebooklogin').on('click',function(){
	console.log('mensajito3');
	return false;
});