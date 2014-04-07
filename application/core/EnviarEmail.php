
<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
# EnviarEmail.php
    
if ( ! function_exists('Email_ConfirmaciondeCuenta'))
{
	/**
	* @Params : EmailDestino, NombreUsuario, CodigoActivacion, 
	*/
	function Email_ConfirmaciondeCuenta($Params){
		$obj =& get_instance();

		$obj->load->library('lbl_Html_Compact');
		$HtmlParams = array(
			'NombreUsuario' 	=> $Params['NombreUsuario'],
			'EmailMensaje'		=> 'Su Codigo de COnfirmacion es: '.$Params['CodigoActivacion'],
			'CodigoActivacion'	=> $Params['CodigoActivacion'],
			'EnlaceAlterno'		=> 'http://localhost/abjweb/accountconfirmation/6743242'
		);

		$HTML_Mensaje = $obj->lbl_html_compact->HTML_Email_ConfirmaciondeCuenta($HtmlParams);
		echo $HTML_Mensaje;
		$obj->load->library('EnvioEmail');

        $Config = array(
 			'EmailDestino'	=> $Params['EmailDestino'],
 			'EmailTitulo'	=> 'Academia Biblica Juvenil :: ABJ',
 			'EmailMotivo'  	=> 'Confirmacion de Cuenta',
 			'EmailMensaje' 	=> $HtmlParams['EmailMensaje'],
 			'NombreUsuario' => $Params['NombreUsuario'],
 			'HtmlMensaje'	=> $HTML_Mensaje,
 			'ErrorMesaje'	=> 'Error al Enviar E-mail',
 			'SuccessMsg'	=> 'El Correo fue enviado con exito.'
 		);

        $EnvioEmail = new EnvioEmail();
        
        $Params = array();
        $EnvioEmail->Config = $Config;
        $EnvioEmail->sendEmail();

	}
}