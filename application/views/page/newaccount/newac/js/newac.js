(function($){
	$Uri = window.location.hash;
	if($Uri){
		console.log($Uri.split('#')[1]);
		$('#token').val($Uri.split('#')[1]);
		$.ajax({
			type 		: 'POST',
			data 	 	: 'token='+$Uri.split('#')[1],
			url			: '',
			success		: function(data){
				window.location.href = '#';
			},
			error 		: function(){
				//  
			}	
		});
	}else{
		console.log('no hay uri hash');
	}
})(jQuery);