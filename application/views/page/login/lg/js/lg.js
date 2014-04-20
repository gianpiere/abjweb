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
	$.ajax({
		type		: 'POST',
		data 		: $('#accountacess').serialize(),
		url 		: 'AccountAccess',
		success 	: function(data){
			try{
				$newUri = $.parseJSON(data);
				if($newUri[0] == 'OK'){
					window.location.href=$newUri[0];
				}else{
					alert('Error Usuario o Password incorrecto');
				}
			}catch(e){
				alert('ERROR INESPERADO');
			}
			
		},
		error 		: function(){
			alert('ERROR AL CONECTARSE');
		}	
	});
	return false;
});

$('#facebooklogin').on('click',function(){
	console.log('Login Facebook no implementado aun..');
	return false;
});