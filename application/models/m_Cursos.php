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
class m_Cursos extends MY_Model{

	/**
	* @package 		: m_Cursos
	* @subpackage 	: 
	* @todo 		: 
	* @see 			: 
	* @param 		: 
	*/
	function SQL_crsListarCursos(){
		$sql = "CALL SP_crsListarCursos()";
		$QueryRpt = $this->db->query($sql);
		$Resultado = $QueryRpt->result_array();
		$this->db->close();
		$Results = $this->QueryResult($Resultado);
		return $Results;
	}

	/**
	* @package 		: m_Cursos
	* @subpackage 	: 
	* @todo 		: 
	* @see 			: 
	* @param 		: 
	*/
	function SQL_crspAgregarCursoPrevio($params){
		$sql = "CALL SP_crspInsertarCursoPrevio(?,?,?)";
		$QueryRpt = $this->db->query($sql,$params);
		$Resultado = $QueryRpt->row_array();
		$this->db->close();
		$Results = $this->QueryRows($Resultado);
		return $Results;
	}

}