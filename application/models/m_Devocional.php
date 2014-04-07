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
class m_Devocional extends MY_Model{

	/**
	* @package 		: m_Devocional
	* @subpackage 	: SQL_dv_LeerUltimoDevocional
	* @todo 		: Funcion que permite listar los devocionales diarios.
	* @see 			: SP_dvDevocionalMostrarUltimo
	* @param 		: no params
	*/
	function SQL_dv_LeerUltimoDevocional(){
		$sql = "CALL SP_dvDevocionalMostrarUltimo()";
		$QueryRpt = $this->db->query($sql);
		$Resultado = $QueryRpt->row_array();
		$this->db->close();
		$Results = $this->QueryRows($Resultado);
		return $Results;
	}

}