<!DOCTYPE html>
<html lang="es">
<head>
	<?= $this->load->view($header); ?>
</head>
<body>
	<div class="inicialheader">
	<div class="content socialplugins">
		<a href="#"><button class="lnkfacebook"></button></a>
		<div class="useraccess">
			<button id="ingresar" type="button"><?= lang('Global.ingreso'); ?></button>
		</div>
	</div>
</div>
<section id="wrap">
	<div class="rasgadoL"></div>
	<div class="responsive allcontent">
		<section class="msgtop">
			
		</section>
		
		<section class="panel access">
			<div class="left logohome">
				<a href="#Home"><img src="<?=IMG;?>logo/logosuperior.png" width="100%" height="auto" /></a>
			</div>
			<!-- aqui el devocional y el menu -->
			<div class="devocional left">
				<div class="msg_dev">
					<div class="cunha"></div>
					<div class="mensaje"><?=(isset($this->devocional) && !empty($this->devocional)) ? $this->devocional['textcontent'] : ''?></div>
				</div>
				<div class="rutabiblica" align="right"><span><?=(isset($this->devocional) && !empty($this->devocional)) ? $this->devocional['rutabiblica'] : ''?></span></div>
			</div>
			<nav class="menuhome">
				<a href="Home" class="<?= (isset($this->focus) && !empty($this->focus) && $this->focus == 'home') ? 'lnkfocus' : '';?>" ><?= lang('Global.Home'); ?></a>
				<a href="Nosotros" class="<?= (isset($this->focus) && !empty($this->focus) && $this->focus == 'nosotros') ? 'lnkfocus' : '';?>"><?= lang('Global.Us'); ?></a>
				<a href="Actividades" class="<?= (isset($this->focus) && !empty($this->focus) && $this->focus == 'actividades') ? 'lnkfocus' : '';?>"><?= lang('Global.Activities'); ?></a>
				<a href="Cursos" class="<?= (isset($this->focus) && !empty($this->focus) && $this->focus == 'cursos') ? 'lnkfocus' : '';?>"><?= lang('Global.Courses'); ?></a>
				<a href="Fotos" class="<?= (isset($this->focus) && !empty($this->focus) && $this->focus == 'fotos') ? 'lnkfocus' : '';?>"><?= lang('Global.Photos'); ?></a>
				<a href="Contactenos" class="<?= (isset($this->focus) && !empty($this->focus) && $this->focus == 'contactenos') ? 'lnkfocus' : '';?>"><?= lang('Global.Contact'); ?></a>
				<a href="Mas" class="icn_mas <?= (isset($this->focus) && !empty($this->focus) && $this->focus == 'mas') ? 'lnkfocus' : '';?>"><?= lang('Global.Mas'); ?></a>
			</nav>
		</section>

		<?= $this->load->view($view); ?>

	</div>
	<div class="rasgadoR"></div>
	<script type="text/javascript">
		
		function formularioRegistro(){
			console.info('registrarme!');
		}
		
		$(function(){
			$('#ingresar').on('click',formularioRegistro);
		})

	</script>
</section>

</body>
<div id="fb-root"></div>
<!-- script facebook -->
<footer>
	<?= $this->load->view($footer); ?>
	<!-- </span>
		<p style="padding-left: 30px;">
			<span style="color: #333399;"> Gianpiere Ramos Bernuy.</span>
		</p>
	<span style="color: #333399;"> -->
</footer>