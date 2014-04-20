(function($){
	$Uri = window.location.hash;
	if($Uri){
		$.ajax({
			type 		: 'POST',
			data 	 	: 'token='+$Uri.split('#')[1],
			url			: '',
			success		: function(data){
				window.location.hash = '#'; 
			},
			error 		: function(){
				//  
			}	
		});
	}else{
		console.log('no hay uri hash');
	}
})(jQuery);