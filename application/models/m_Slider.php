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
class m_Slider extends MY_Model{

	function SQL_sld_Sliders(){
		$sql = "CALL SP_sld_Sliders()";
		$QueryRpt = $this->db->query($sql);
		$Resultado = $QueryRpt->result_array();
		$this->db->close();
		$Results = $this->QueryResult($Resultado);
		return $Results;
	}

}