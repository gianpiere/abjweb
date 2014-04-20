<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/** 
**************************************************************************
* @todo     : Maskara
* @author   : Gianpiere Ramo Bernuy. 
* @return   : view : 
* @see      : Grupo Silvestre
* @link     : http:// ...
* @copyright: Abj WEB.
**************************************************************************
*/ # --------------------------------------------------------------------- 
class UserPage extends MY_Controller{
    public function __construct(){
        parent::__construct();
        $this->load->library('form_validation');
        $this->load->helper('form');
    }

    public function index(){

    }

  	public function inicio(){

  	}

  	public function AccesoOk(){
  		echo 'estoy en mi cuenta';
  	}


}

