<title><?= isset($this->title) ? $this->title: ''; ?></title>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="<?=CSS;?>ResetElements.css">
<link rel="stylesheet" type="text/css" href="<?=CSS;?>Thematica.css">
<link rel="stylesheet" type="text/css" href="<?=CSS;?>BackgroundsTheme.css">
<link rel="stylesheet" type="text/css" href="<?=CSS;?>theme.css">
<link rel="stylesheet" type="text/css" href="<?=CSS;?>icons/icons.css" />
<link rel="stylesheet" type="text/css" href="<?=CSS;?>Controls.css" />
<link rel="stylesheet" type="text/css" href="<?=CSS;?>normalstyle.css" />
<link rel="shortcut icon" href="/favicon.ico" />
<link rel="alternate" title="GRB RSS" type="application/rss+xml" href="/feed.rss" />

<!-- <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script> -->
<script type="text/javascript" src="<?=JS_LIB;?>/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<?=JS_LIB;?>easing/jquery.easing.1.3.js"></script>

<!-- All Scripts -->
<script type="text/javascript" src="<?=JS_LIB;?>fancyscript.js"></script>
<link rel="stylesheet" type="text/css" href="<?=CSS_LIB;?>fancystyle.css">

<?php // Cargar Imagenes del Diseño Web antes de mostrar la web.
	if(isset($this->images) && is_array($this->images)):
		foreach ($this->images as $images => $IMAGES) {
			echo '<img src="'.$IMAGES.'" hidden style="display:none;">';
		}
	endif;
?>

<?php // Cargar los estilos de la web.
	if(isset($this->css) && is_array($this->css)):
		foreach ($this->css as $css => $CSS){
			echo '<link rel="stylesheet" type="text/css" href="'.$pathmask.$CSS.'">';
		}
	endif;
?>

<?php // Cargar los estilos de la web.
	if(isset($this->js) && is_array($this->js)):
		foreach ($this->js as $js => $JS){
			echo '<script type="text/javascript" src="'.$pathmask.$JS.'"></script>';
		}
	endif;
?>


<?php // Cargar los estilos de la web.
	if(isset($this->css_lib) && is_array($this->css_lib)):
		foreach ($this->css_lib as $lbcss => $LIBCSS){
			echo '<link rel="stylesheet" type="text/css" href="'.CSS_LIB.$LIBCSS.'">';
		}
	endif;
?>

<?php // Cargar los estilos de la web.
	if(isset($this->libjs) && is_array($this->libjs)):
		foreach ($this->libjs as $lbjs => $LIBJS){
			echo '<script type="text/javascript" src="'.JS_LIB.$LIBJS.'"></script>';
		}
	endif;
?>


<!-- All Scripts -->
<script type="text/javascript" src="<?=JS_LIB;?>login.js"></script>
<link rel="stylesheet" type="text/css" href="<?=CSS_LIB;?>fancystyle.css">