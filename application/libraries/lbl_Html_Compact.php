<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/** 
**************************************************************************
* @todo     : Libreria que contiene bloques html para el controller  
* @author   : Gianpiere Ramo Bernuy. 
* @return   : html compactado con la data. 
* @see      : Academia Biblica Juvenil
* @link     : http:// ...
* @copyright: Grupo Silvestre.
**************************************************************************
*/ # comentario..
class lbl_Html_Compact{
    /*public function __construct(){
        parent::__construct();
    }*/

    /**
    * 
    */
    public function HTML_Email_ConfirmaciondeCuenta($Params){

    	$HTML = '<div style="width:530px; height:335px; background:#820000;" >';
    	$HTML .= '	<table colspan="0" cellspacing="0">';
    	$HTML .= '		<td width="330px">';
    	$HTML .= '			<div align="left">';
    	$HTML .= '				<p style="text-align:justify;width:260px;padding-left:10px;">';
    	$HTML .= '					<font color="#FFF">';
    	$HTML .= '						'.$Params['NombreUsuario'].',';
    	$HTML .= '						</br>';
    	$HTML .= '						Bienvenido!, Academia Bíblica Juvenil';
    	$HTML .= '						</br>';
    	$HTML .= '						Confirmara tu Cuenta de Correo para ello Tu Codigo de Activación es: ';
    	$HTML .= '						<strong>';
    	$HTML .= '							<h1 style="padding-left:20px;">'.$Params['EmailMensaje'].'</h1>';
    	$HTML .= '						</strong>';
    	$HTML .= '					</font>';
    	$HTML .= '				</p>';
    	$HTML .= '			</div>';
    	$HTML .= '		</td>';
    	$HTML .= '		<td>';
    	$HTML .= 			$Params['CodigoActivacion'];
    	$HTML .= 			$Params['EnlaceAlterno'];
    	$HTML .= '		</td>';
    	$HTML .= '	</table>';
    	$HTML .= '	<div>';
    	$HTML .= '		<span style="font-size:12px;color:#CCC;">';
    	$HTML .= '			Tambien puedes hacer click en el siguiente enlace para validar tu cuenta de correo.';
    	$HTML .= '		</span>';
    	$HTML .= '	</div>';
    	$HTML .= '</div>';

    	return $HTML;
    }

    public function HTML_Compact_ZonasProyectadas($Params){
    	$HTML = '';
    	$HTML.='<a href="'.$Params['proyecciongeneralid'].'/'.$Params['zonaid'].'">';
		$HTML.='	<li class="zona" data-id="'.$Params['zonaid'].'" data-name="'.$Params['proyeccionname'].'" data-monto="'.$Params['proyeccionmonto'].'" data-estado="pendiente">';
		$HTML.='		<span class="zonaname">ZONA '.$Params['zonaname'].'</span>';
		$HTML.='		<h2>$ <span class="cash">'.$Params['zonacash'].'</span></h2>';
		$HTML.='	</li>';
		$HTML.='</a>';
    	return $HTML;
    }

    public function HTML_Compact_zonaProyectadaconMonto($Params){
    	$HTML = '';
    	$HTML .= '<li class="proyeccion" data-id="'.$Params['id'].'">'.$Params['titulo'].'<div>'.$Params['generalproyeccionnombre'].'</div><div>'.$Params['fechacreacion'].'</div></li>';
    	return $HTML;
    }

    public function HTML_Compact_ProyeccionesAnuales($Params){
    	$HTML = '';
    	$HTML.= '<a class="linkcombo" href="Corporativo/AnualProyection/'.$Params['id'].'">';
		$HTML.= '<li class="proyeccion" data-id="'.$Params['id'].'" data-year="'.$Params['year'].'">';
		$HTML.= '	<div class="cabecera">';
		$HTML.= '		<p>'.$Params['titulo'].'</p>';
		$HTML.= '		<i class="icn" icn="mecha"></i>';
		$HTML.= '		<h2>'.$Params['year'].'</h2>';
		$HTML.= '	</div>';
		$HTML.= '	<div class="filameses">';
		$HTML.= '		<ul>';
		$HTML.= '			<li data-id="1">ENE</li>';
		$HTML.= '			<li data-id="2">FEB</li>';
		$HTML.= '			<li data-id="3">MAR</li>';
		$HTML.= '			<li data-id="4">ABR</li>';
		$HTML.= '			<li data-id="5">MAY</li>';
		$HTML.= '			<li data-id="6">JUN</li>';
		$HTML.= '			<li data-id="7">JUL</li>';
		$HTML.= '			<li data-id="8">AGO</li>';
		$HTML.= '			<li data-id="9">SEP</li>';
		$HTML.= '			<li data-id="10">OCT</li>';
		$HTML.= '			<li data-id="11">NOV</li>';
		$HTML.= '			<li data-id="12">DIC</li>';
		$HTML.= '		</ul>';
		$HTML.= '	</div>';
		$HTML.= '	<div class="montoactualdezona">$ '.$Params['cashactualzona'].'</div>';
		$HTML.= '	<div class="montoanualdezona">$ '.$Params['cashanualzona'].'</div>';
		$HTML.= '</li>';
		$HTML.= '</a>';
    	return $HTML;
    }

    public function HTML_Compact_TProyeccionesResult($Params){
    	$HTML = '';
    	$HTML.='<li data-id="'.$Params['id'].'">';
	    $HTML.='    <div class="numdate"><span>'.$Params['fecha_inicial'].'</span> - <span>'.$Params['fecha_final'].'</span><dd>'.$Params['position'].'</dd></div>';
	    $HTML.='    <blockquote>'.$Params['description'].'</blockquote>';
	    $HTML.='    <strong><sup>'.$Params['tipo_moneda'].' </sup>'.$Params['monto'].'</strong>';
	    $HTML.='</li>';
    	return $HTML;
    }


    public function HTML_Compact_ZProyeccionesResult($Params){
    	$HTML = '';

    	$HTML.='<li data-id="'.$Params['id'].'" zona="inf" tabindex>';
		$HTML.='	<header>'.$Params['nombredezona'].'</header>';
		$HTML.='	<section> '.date('m, y',strtotime($Params['fechas'])).' </section>';
		$HTML.='	<ul>';
		$HTML.='		<li estadistica="zona" style="width: '.$Params['porcentajeproyecciondezona'].';">'.$Params['dinerodezona'].'</li>';
		$HTML.='		<li estadistica="gerencia">'.$Params['dinerogerencia'].'</li>';
		$HTML.='	</ul>';
		$HTML.='	<div class="porcent">';
	    $HTML.='        <div>'.$Params['porcentajeproyecciondezona'].' %</div>';
	    $HTML.='        <div>'.$Params['porcentajeproyecciongerencia'].' %</div>';
	    $HTML.='    </div>';
		$HTML.='	<pre>'.$Params['numero'].'</pre>';
		$HTML.='</li>';
		
    	return $HTML;
    }

    /**
	* @package 		: m_Proyecciones
	* @subpackage 	: SQL_ZnaProductosxFamilia_return
	* @todo 		: Funcion que permite listar los productos de una determinada familia.
	* @see 			: MY_Model
	* @param 		: $userid : ID del usuario logeado.
	*/
    public function HTML_Compact_FamiliasProducto($Params){
    	$HTML = '';
    	$HTML .= '<div class="familia" data-id="'.$Params['id'].'">'.$Params['nombre'].'</div>';
		
    	return $HTML;
    }

    /**
	* @package 		: lbl_Html_Compact.php
	* @subpackage 	: HTML_Compact_ProductoxFamilia
	* @todo 		: Funcion que permite Convertir en elementos html la listade productos de una familia.
	* @see 			: Library
	* @param 		: $Params : array('id'=>?,'nombre'=?);
	*/
    public function HTML_Compact_ProductoxFamilia($Params){
    	$HTML = '';
    	$HTML .= '<div class="producto" data-id="'.$Params['id'].'">'.$Params['nombre'].'</div>';
    	return $HTML;
    }

    /**
	* @package 		: lbl_Html_Compact.php
	* @subpackage 	: HTML_Compact_PresentacionesxProducto
	* @todo 		: Funcion que permite Convertir en elementos html las Presentaciones de un Determinado Producto.
	* @see 			: Library
	* @param 		: $Params : array('producto_id','presentacion_id','presentacion_id','presentacion_precio','presentacion_nombre');
	*/
    public function HTML_Compact_PresentacionesxProducto($Params){
    	$HTML = '';
    	$meses = '<div class="meses"><input data-pos="1" placeholder="?" class="cajacantidad" /><input data-pos="1" placeholder="?" class="cajacantidad" /><input data-pos="1" placeholder="?" class="cajacantidad" /><input data-pos="1" placeholder="?" class="cajacantidad" /><input data-pos="1" placeholder="?" class="cajacantidad" /><input data-pos="1" placeholder="?" class="cajacantidad" /><input data-pos="1" placeholder="?" class="cajacantidad" /><input data-pos="1" placeholder="?" class="cajacantidad" /><input data-pos="1" placeholder="?" class="cajacantidad" /><input data-pos="1" placeholder="?" class="cajacantidad" /><input data-pos="1" placeholder="?" class="cajacantidad" /><input data-pos="1" placeholder="?" class="cajacantidad" /></div>';
    	$HTML .= '<div class="presentacion" producto-id="'.$Params['producto_id'].'" data-id="'.$Params['presentacion_id'].'">'.$Params['presentacion_nombre'].'<pre>'.'s/. '.$Params['presentacion_precio'].'</pre>'.$meses.'</div>';
    	return $HTML;
    }


    /**
	* @package 		: lbl_Html_Compact.php
	* @subpackage 	: HTML_Compact_PresentacionesxProducto
	* @todo 		: Funcion que permite Convertir en elementos html las Presentaciones de un Determinado Producto.
	* @see 			: Library
	* @param 		: $Params : array('producto_id','presentacion_id','presentacion_id','presentacion_precio','presentacion_nombre');
	*/
    public function HTML_Compact_MesesdeunaProyecciondeZona($Params){
    	$HTML = '';
    	$HTML .= '<li data-porcent="'.$Params['porcent'].'" data-monto="'.$Params['monto'].'" mes-name="'.$Params['mesname'].'" data-id="'.$Params['id'].'" data-mes="'.$Params['mesnum'].'" data-proyecc="'.$Params['proyeccionxzonaid'].'" class="mes">';
		$HTML .= '	<span>'.$Params['mesname'].'</span>';
		$HTML .= '	<b>'.$Params['porcent'].'%</b>';
		$HTML .= '	<strong>$'.$Params['monto'].'</strong>';
		$HTML .= '</li>';
    	    		
    	return $HTML;
    }

    /**
	* @package 		: lbl_Html_Compact.php
	* @subpackage 	: HTML_Compact_PresentacionesxProducto
	* @todo 		: Funcion que permite Convertir en elementos html las Presentaciones de un Determinado Producto.
	* @see 			: Library
	* @param 		: $Params : array('producto_id','presentacion_id','presentacion_id','presentacion_precio','presentacion_nombre');
	*/
    public function HTML_Compact_ProductoDetalladodeunMes($Params){
    	$HTML = '';
    	$HTML .= '<li class="productodefamilia" data-id="'.$Params['id'].'" producto-codigo="'.$Params['producto_codigo'].'" familia="'.$Params['familianame'].'">';
		$HTML .= '	<div>';
		$HTML .= '		<span class="prodname">'.$Params['productoname'].'</span> : <b class="codigo">'.$Params['producto_codigo'].'</b>';
		$HTML .= '		<div class="detalle_producto">';
		$HTML .= '			<ul class="presentacionesdelproducto">';
		$HTML .= $Params['html_prexpro'];
		$HTML .= '			</ul>';
		$HTML .= '		</div>';
		$HTML .= '	</div>';
		$HTML .= '</li>';
    	    		
    	return $HTML;
    }

    /**
	* @package 		: lbl_Html_Compact.php
	* @subpackage 	: HTML_Compact_PresentacionesxProducto
	* @todo 		: Funcion que permite Convertir en elementos html las Presentaciones de un Determinado Producto.
	* @see 			: Library
	* @param 		: $Params : array('producto_id','presentacion_id','presentacion_id','presentacion_precio','presentacion_nombre');
	*/
    public function HTML_Compact_PresentacionesdelProductoDetalladodeunMes($Params){
    	$HTML = '';
    	$HTML .='<li class="presentacion_p">';
		$HTML .='	<div class="title">'.$Params['presentacionname'].'</div>';
		$HTML .='	<div class="cash">$<span>'.$Params['cashxpresentacion'].'</span></div>';
		$HTML .='	<div class="Cantidad">'.$Params['cantidad'].'</div>';
		$HTML .='	<div class="price">$ <span>'.$Params['precio'].'</span></div>';
		$HTML .='</li>';
    	    		
    	return $HTML;
    }

    /**
	* @package 		: lbl_Html_Compact.php
	* @subpackage 	: HTML_Compact_MesesDetalladosdeunaProyecciondeZona
	* @todo 		: Funcion que permite Convertir en elementos html las Presentaciones de un Determinado Producto.
	* @see 			: Library
	* @param 		: $Params : array('producto_id','presentacion_id','presentacion_id','presentacion_precio','presentacion_nombre');
	*/
    public function HTML_Compact_MesesDetalladosdeunaProyecciondeZona($Params){
    	$HTML = '';
    	$HTML .='<li data-id="'.$Params['id'].'">';
		$HTML .='	<i icn="'.$Params['isok'].'"></i>';
		$HTML .='	<strong date-month="'.$Params['month'].'">'.$Params['mesname'].'</strong>';
		$HTML .='	<span>$ '.$Params['cash'].'</span>';
		$HTML .='</li>';
    	    		
    	return $HTML;
    }



}



/*
$HTML.='<li tabindex="" zona="inf">';
		$HTML.='	<header>Nombre de zona</header>';
		$HTML.='	<section> <!-- aun sin uso --> </section>';
		$HTML.='	<ul>';
		$HTML.='		<li style="width: 75%;" estadistica="zona">$ 1,750.000</li>';
		$HTML.='		<li estadistica="gerencia">$ 1,900.000</li>';
		$HTML.='	</ul>';
		$HTML.='	<div class="porcent">';
	    $HTML.='        <div>75%</div>';
	    $HTML.='        <div>30%</div>';
	    $HTML.='    </div>';
		$HTML.='	<pre>01</pre>';
		$HTML.='</li>';
*/