(function($){
	var defaults, plugin, version = '1.0', author = 'jgianpiere@gmail.com';
	var DataSource, sliderProcess, $this; // [{},{}]
	var opt = {position:0,count:0};
	defaults = // defaults params 
	{
		init 					: 1,
		loop 					: true, 		// int to number rotate or true || false 
		stop 					: false, 		// stop position slider
		start					: true,
		addclass				: false,
		pause 					: true,
		next 					: true,
		back 					: true,
		points 					: true,
		betweentime				: 7000,			// 1s
		aleatories				: false,
		efects					: true,
		mousepause 				: true,
		animationslide			: 'onBoundOut',
		titlesanimation 		: true,
		keydirectionaluse 		: false,
		textpositionenfoque 	: true,
		DataSource 				: false
	};

	function slideView(i){
		$slide = DataSource[opt.position];

		$controls 	= $this.children('.controls');
		$items 		= $controls.children('.slideposition');
		$sltext 	= $controls.children('.sliderText');
		$imagen 	= $this.children('.picslider');

		$sltext.children('h2').html($slide.title);
		$sltext.children('span').html($slide.description);

		$slbuton 	= $controls.children('a.sld_act');
		$slbuton.attr('href',$slide.button[1]).children('button').text($slide.button[0]);

		$imagen.children('img').attr('src',$slide.img);

		itemfocus(i);
	}

	function itemfocus(i){
		$controls = $this.children('.controls');
		$items = $controls.children('.slideposition');

		$items.children('i.onfocus').addClass('nofocus').removeClass('onfocus');
		$($items.children('i').get(i)).addClass('onfocus').removeClass('nofocus');
	}

	jQuery.fn.webslider = function(options){ $this = $(this);
		var o = $.extend({},defaults,options);
		var $data = (o.DataSource || undefined); DataSource = $data;

		if($data != undefined){
			opt.count = $data.length -1;
			(o.init >= opt.count) ? opt.position = o.init -1 : opt.position = 0;

			$controls = $this.children('.controls');
			$items = $controls.children('.slideposition');

			for (var i = 0; i <= $data.length -1; i++) {
				var focus = (i == opt.position ? 'onfocus' : 'nofocus');
				var item = '<i class="'+focus+'" data-position="'+String(i+1)+'"></i>';
				$items.append(item);
			};

			sliderProcess = setInterval(function(){
				// cambiando cosas
				slideView(opt.position);

				// validar loop 
				if(opt.position == opt.count){
					if(o.loop){
						opt.position = 0;
					}else{
						clearInterval(sliderProcess);
					}
				}else{
					// avanzar slider
					opt.position +=1;
				}
			},o.betweentime);
		}
	}

})(jQuery);


/* #: Example :#			jQuery.slider.jG.js
----------------

<section class="sliderpanel panel">
	<div class="controls">
		<div data-slider="1" class="sliderText" text-position="right" style="display:block;">
			<h2 data-title-color="yellow">titulo</h2>
			<span data-text-color="white">este es un texto de prueba, <br/>solo de prueba y blanblablablal alsadasd sa s </span>
		</div>
		<a class="sld_act" href="#01"><button class="sld_action">entrar</button></a>
		
		<div class="slideposition">

		</div>
	</div>
	<div class="picslider"> <img onerror="javascript:$(this).imgdefault({height:'200px',width:'940px'});" src="<?=SLIDER;?>slider_1.png" width="100%" height="auto" class="img_responsive"> </div>
</section>




*/