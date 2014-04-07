<title><?= isset($this->title) ? $this->title: ''; ?></title>

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
	if(isset($this->js_lib) && is_array($this->js_lib)):
		foreach ($this->js_lib as $lbjs => $LIBJS){
			echo '<script type="text/javascript" src="'.JS_LIB.$LIBJS.'"></script>';
		}
	endif;
?>

