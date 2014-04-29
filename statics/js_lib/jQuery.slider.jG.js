(function($){
	var o, defaults, plugin, version = '1.0', author = 'jgianpiere@gmail.com';
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
		clickedpoint			: true,
		betweentime				: 7000,			// 1s
		aleatories				: false,
		efects					: true,
		mousepause 				: true,
		animationslide			: 'easeInOutBack',
		titlesanimation 		: true,
		keydirectionaluse 		: false,
		textpositionenfoque 	: true,
		DataSource 				: false,
		defaultoptions 			: {textdirection:'right',titlecolor:'yellow',textcolor:'white'},
		defaultbutton 			: ['ENTRAR','#']
	};

	function slideView(i){
		// validar loop 
		if(i>opt.count){opt.position = 0;}

		$slide = DataSource[opt.position];

		var defaultslide = {
			title 			: null,
			description 	: null,
			img 			: null,
			button			: ['','#',false],
			options 		: {textdirection:'right',titlecolor:'yellow',textcolor:'white'}
		}

		$slider = $.extend({},defaultslide,$slide);

		$controls 	= $this.children('.controls');
		$items 		= $controls.children('.slideposition');
		$sltext 	= $controls.children('.sliderText');
		$imagen 	= $this.children('.picslider');

		// animacion de escape
		$sltext.animate({ bottom: '-=100px',opacity:'0' }, "slow", 'easeOutQuad', function () { 
			$sltext
				.css({float:$slider.options.textdirection,'text-align':$slider.options.textdirection})
			;
			
			$sltext.children('h2')
				.css({color:$slider.options.titlecolor}).html($slider.title)
			;
			
			$sltext.children('span')
				.css({color:$slider.options.textcolor}).html($slider.description)
			;
			
			$sltext	
				.animate({ bottom: '+=100px',opacity:'100' }, 600, 'easeInOutBack', function () { })
			;
		});

		$slbuton 	= $controls.children('a.sld_act');
		if(!$slider.button[2]){$slbuton.css({display:'none'});}else{$slbuton.show(0);}
		$slbuton.attr('href',$slider.button[1]).children('button').text($slider.button[0]);

		$imagen.children('img').attr('src',$slider.img);

		itemfocus(i);
	}

	function itemfocus(i){
		$controls = $this.children('.controls');
		$items = $controls.children('.slideposition');

		$items.children('i.onfocus').addClass('nofocus').removeClass('onfocus');
		$($items.children('i').get(i)).addClass('onfocus').removeClass('nofocus');
	}

	function ReiniciarSlider(options){
		$.when(detenerSlider('')).then(function(){
			SliderInit('');
		});
	}

	function detenerSlider(options){
		clearInterval(sliderProcess);
		return true;
	}

	function pausarSlider(options){
		clearInterval(sliderProcess);
	}

	function SliderInit(options){
		// Iniciar Intervalo
			sliderProcess = setInterval(function(){

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

				// cambiando cosas
				slideView(opt.position);

			},o.betweentime);
	}

	jQuery.fn.webslider = function(options){ $this = $(this);
		o = $.extend({},defaults,options);
		var $data = (o.DataSource || undefined); DataSource = $data;

		if($data != undefined){
			opt.count = $data.length -1;
			(o.init >= opt.count) ? opt.position = o.init -1 : opt.position = 0;

			$controls = $this.children('.controls');
			$items = $controls.children('.slideposition');

			for (var i = 0; i <= $data.length -1; i++){
				var focus = (i == opt.position ? 'onfocus' : 'nofocus');
				var item = '<i class="'+focus+'" data-position="'+String(i+1)+'"></i>';
				$items.append(item);
			};

			if(o.clickedpoint){
				$items.children('i').on('click',function(e){ $this = $(this);
					opt.position = $this.attr('data-position') - 1;
					console.log(opt.position);
				});

				// iniciar
				slideView(opt.position);
			}

			// iniciamos
			slideView(opt.position);

			// continuamos con el intervalo
			SliderInit('');
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