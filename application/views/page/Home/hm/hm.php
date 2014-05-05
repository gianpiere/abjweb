<?php if(isset($this->imagenPortada) && !empty($this->imagenPortada)): ?>
<section class="panel bannerTop">
	<img src="<?=IMGPORTADA.$this->imagenPortada[1];?>" height="<?=$this->imagenPortada[2];?>" width="<?=$this->imagenPortada[3];?>" />
</section>
<?php endif; ?>

<div class="separacion_1"></div>

<?php if(isset($this->sliders) && !empty($this->sliders)): ?>

<section class="sliderpanel panel">
	<div class="controls">
		<div data-slider="1" class="sliderText" style="display:block;">
			<h2></h2><span></span>
		</div>
		<a class="sld_act" href="#01"><button class="sld_action"></button></a>
		<div class="slideposition"></div>
	</div>
	<div class="picslider"> <img onerror="javascript:$(this).imgdefault({height:'200px',width:'940px'});" src="<?=SLIDER;?>slider_1.png" width="100%" height="auto" class="img_responsive"> </div>
</section>
<script type="text/javascript">
	var $datasource = <?= $this->sliders ?>;

	$(document).on('ready',function(){
		$('.sliderpanel').webslider({
			init 		: 1,
			betweentime : 5000,
			DataSource 	: $datasource
		});
	});
</script>
<?php endif; ?>

<section class="optionfocushome colorfocuspanel">
	<!-- Cursos -->
	
	<!-- Cursos -->
</section>

<script type="text/javascript">
	
	
/*
[
	{
		title		: 'slider 1 (UNO)',
		description : 'Prueba 1(uno) <br/> ejemploto 1 description 1',
		img 		: "<?=SLIDER;?>slider_1.png",
		button		: ['ACCEDER','#uno1',true],
		options 	: {textdirection:'left',titlecolor:'green',textcolor:'orange'}
	},
	{
		title		: 'slider 2 (UNO)',
		description : 'Prueba 2(uno) <br/> ejemploto 1 description 2',
		img 		: "<?=SLIDER;?>slider_2.png",
		button		: ['ACCEDER','#uno2',true],
		options 	: {textdirection:'left',titlecolor:'green',textcolor:'orange'}
	},
	{
		title		: 'slider 3 (DOS)',
		description : 'Prueba 3(dos) <br/> ejemploto 3 description 3',
		img 		: "<?=SLIDER;?>slider_3.png",
		button		: ['ENTRAR','#dos3',true]
	},
	{
		title		: 'slider 4 (TRES)',
		description : 'Prueba 4(tres) <br/> ejemploto 4 description 4',
		img 		: "<?=SLIDER;?>slider_4.png"
	}
]
*/

</script>