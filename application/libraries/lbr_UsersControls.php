<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
class lbr_UsersControls extends MY_Controller{
	public function __construct(){
        parent::__construct();
    }
	/**
	* @param : $Params = array(| nombre, cargo, foto, empresa, zona_s,  |)
	*/
	public function fn_subcnt_datosdeusuario($Params){
		return 'GRB;';	
	}
}