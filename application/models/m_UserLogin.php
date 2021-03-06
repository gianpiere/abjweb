<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/** 
**************************************************************************
* @todo     : Clase que registra y visualiza session de usuario. 
* @author   : Gianpiere Ramo Bernuy. 
* @return   : view : 
* @see      : ABJ WEB
* @link     : http:// ...
* @copyright: Academia Biblica Juvenil.
**************************************************************************
*/ # 
class m_UserLogin extends MY_Model{

	/**
	* @package 		: m_UserLogin
	* @subpackage 	: SQL_dv_LeerUltimoDevocional
	* @todo 		: Funcion que permite listar los devocionales diarios.
	* @see 			: SP_dvDevocionalMostrarUltimo
	* @param 		: no params
	*/
	function SQL_lg_InsertUsuarioNuevo($params){
		$sql = "CALL SP_usCrearUsuario(?,?,?,?,?,?,?,?)";
		$QueryRpt = $this->db->query($sql,$params);
		$Resultado = $QueryRpt->row_array();
		$this->db->close();
		$Results = $this->QueryRows($Resultado);
		return $Results;
	}

	/**
	* @package 		: m_UserLogin
	* @subpackage 	: 
	* @todo 		: devuelve los datos del nuevo usuario logeado.
	* @see 			: 
	* @param 		: no params
	*/
	function SQL_lg_GetUsuarioNuevo($params){
		$sql = "CALL SP_usBuscarUsuarioId(?)";
		$QueryRpt = $this->db->query($sql,$params);
		$Resultado = $QueryRpt->row_array();
		$this->db->close();
		$Results = $this->QueryRows($Resultado);
		return $Results;
	}

	/**
	* @package 		: m_UserLogin
	* @subpackage 	: 
	* @todo 		: confirma el codigo de email de un usuario
	* @see 			: 
	* @param 		: no params
	*/
	function SQL_UsuarioConfirmarCodigo($params){
		$sql = "CALL SP_usConfirmarActivacionUsuario(?,?,?)";
		$QueryRpt = $this->db->query($sql,$params);
		$Resultado = $QueryRpt->row_array();
		$this->db->close();
		$Results = $this->QueryRows($Resultado);
		return $Results;
	}

	/**
	* @package 		: m_UserLogin
	* @subpackage 	: 
	* @todo 		: actualiza los datos basicos de un usuario
	* @see 			: 
	* @param 		: no params
	*/
	function SQL_usaddUsuarioDatosBasicos($params){
		$sql = "CALL SP_usUpdateUsuarioDatosBasicos(?,?,?,?,?,?)";
		$QueryRpt = $this->db->query($sql,$params);
		$Resultado = $QueryRpt->row_array();
		$this->db->close();
		$Results = $this->QueryRows($Resultado);
		return $Results;
	}
	

	/**
	* @package 		: m_UserLogin
	* @subpackage 	: 
	* @todo 		: iniciar session
	* @see 			: 
	* @param 		: IN xUsuarioEmail VARCHAR(70), IN xUsuarioPassword VARCHAR(25)
	*/
	function SQL_usIniciarSession($params){
		$sql = "CALL SP_usIniciarSession(?,?)";
		$QueryRpt = $this->db->query($sql,$params);
		$Resultado = $QueryRpt->row_array();
		$this->db->close();
		$Results = $this->QueryRows($Resultado);
		return $Results;
	}






}