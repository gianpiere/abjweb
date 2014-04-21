$(document).on('ready',function(){
	// posicionar rasgados laterales
	$('.rasgadoL').css({height:$('#wrap').innerHeight()+'px'});
	$('.rasgadoR').css({height:$('#wrap').innerHeight()+'px'});
});

$.fn.imgdefault = function(params){ $this = $(this);
	var defaults = {height:'0px',width:'0px'}
	$this.attr('src','http://localhost/abjweb/statics/galerias/slider/slider_1.png');
};