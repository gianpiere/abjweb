<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/**
 * CodeIgniter
 *
 * An open source application development framework for PHP 5.1.6 or newer
 *
 * @package		CodeIgniter
 * @author		ExpressionEngine Dev Team
 * @copyright	Copyright (c) 2008 - 2011, EllisLab, Inc.
 * @license		http://codeigniter.com/user_guide/license.html
 * @link		http://codeigniter.com
 * @since		Version 1.0
 * @filesource
 */

// ------------------------------------------------------------------------

/**
 * Common Functions
 *
 * Loads the base classes and executes the request.
 *
 * @package		CodeIgniter
 * @subpackage	codeigniter
 * @category	Common Functions
 * @author		ExpressionEngine Dev Team
 * @link		http://codeigniter.com/user_guide/
 */

// ------------------------------------------------------------------------

/**
* Determines if the current version of PHP is greater then the supplied value
*
* Since there are a few places where we conditionally test for PHP > 5
* we'll set a static variable.
*
* @access	public
* @param	string
* @return	bool	TRUE if the current version is $version or higher
*/

    
if ( ! function_exists('us_session'))
{
	function us_session($element){
		$obj =& get_instance();
		$obj->load->library('session');
		###############################################################################################################################
		/** 
		* @see : Lista de los Parametros de session del usuario logeado.
		*/
		$usuario_id 		= $obj->session->userdata('us_id'); 			# Recupera el Usuario [  ID 	   ] de la Sesion existente.
		$usuario_name 		= $obj->session->userdata('us_name'); 			# Recupera el Usuario [  NOMBRE    ] de la Sesion existente.
		$usuario_apellidos	= $obj->session->userdata('us_apellidos'); 		# Recupera el Usuario [  APELLIDOS ] de la Sesion existente.
		$usuario_sexo		= $obj->session->userdata('us_sexo'); 			# Recupera el Usuario [  SEXO      ] de la Sesion existente.
		$usuario_foto		= $obj->session->userdata('us_foto'); 			# Recupera el Usuario [  FOTO      ] de la Sesion existente.
		$usuario_email		= $obj->session->userdata('us_email'); 			# Recupera el Usuario [  TOKEN     ] de la Sesion existente.
		$usuario_password	= $obj->session->userdata('us_password'); 		# Recupera el Usuario [  PASSWORD  ] de la Sesion existente.
		$usuario_token		= $obj->session->userdata('us_token'); 			# Recupera el Usuario [  TOKEN     ] de la Sesion existente.
		$usuario_Permisos	= $obj->session->userdata('us_permisos'); 		# Recupera el Usuario [  PERMISOS  ] de la Sesion existente.

		###############################################################################################################################

		if(!empty($usuario_id) && !empty($usuario_name) && !empty($usuario_apellidos) && !empty($usuario_token) && !empty($usuario_email) && !empty($usuario_password) && !empty($usuario_Permisos) && !empty($usuario_cargo)):
			switch ($element) {
				case 'us_id':
					return $obj->session->userdata('us_id');
					break;
				
				case 'us_name':
					return $obj->session->userdata('us_name'); 
					break;
				
				case 'us_apellidos':
					return $obj->session->userdata('us_apellidos');
					break;
				
				case 'us_sexo':
					return $obj->session->userdata('us_sexo');
					break;

				case 'us_token':
					return $obj->session->userdata('us_token');
					break;
				
				case 'us_email':
					return $obj->session->userdata('us_email');
					break;
				
				case 'us_password':
					return $obj->session->userdata('us_password');
					break;
				
				case 'us_permisos':
					return $obj->session->userdata('us_permisos');
					break;
				
				case 'us_foto':
					return $obj->session->userdata('us_foto');
					break;

				default:
					return false;
					break;
			}
			return true;
		else:
			return false;
		endif;
	}
}

// ------------------------------------------------------------------------

if ( ! function_exists('mes_array_name'))
{
	function mes_array_name($mesnum = 0,$tipo = 'normal',$textstyle = 'uppercase'){

		$meses_min 		= array('MES','ENE','FEB','MAR','ABR','MAY','JUN','JUL','AGO','SEP','OCT','NOV','DIC');
		$meses_normal 	= array('MESES','ENERO','FEBRERO','MARZO','ABRIL','MAYO','JUNIO','JULIO','AGOSTO','SEPTIEMBRE','OCTUBRE','NOVIEMBRE','DICIEMBRE');

		$mes_result = array();
		$tipo == 'min' ? $mes_result = $meses_min : $mes_result = $meses_normal;

		return $textstyle == 'lowercase' ? strtolower($mes_result[(int) $mesnum]) : strtoupper($mes_result[(int) $mesnum]);
			 
	}
}

/**
* @todo : Funcion que permite validar el resultado de un SQL Query Result or Query Rows
*/
if(!function_exists('isQueryR'))
{
	function isQueryR($Query){
		if(!empty($Query) && is_array($Query) && $Query[0] != '00'):
			return true;
		endif;
			return false;	 
	}
}