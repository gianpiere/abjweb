<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/** 
**************************************************************************
* @todo     : Clase que graba y lee los devocionales. 
* @author   : Gianpiere Ramo Bernuy. 
* @return   : view : 
* @see      : ABJ WEB
* @link     : http:// ...
* @copyright: Academia Biblica Juvenil.
**************************************************************************
*/ # 
class m_Fotos extends MY_Model{

	/**
	* @package 		: m_Fotos
	* @subpackage 	: 
	* @todo 		: 
	* @see 			: 
	* @param 		: no params
	*/
	function SP_ftw_ImagenWebTipo($codigo){
		$sql = "CALL SP_ftw_ImagenWebTipo(?)";
		$QueryRpt = $this->db->query($sql,array($codigo));
		$Resultado = $QueryRpt->row_array();
		$this->db->close();
		$Results = $this->QueryRows($Resultado);
		return $Results;
	}

}