<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/** 
**************************************************************************
* @todo     : Clase que permite Conectar y redirigir al Usuario segun el 
*             cargo que ejerce sobre el sistema. 
* @author   : Gianpiere Ramo Bernuy. 
* @return   : view : 
* @see      : Grupo Silvestre
* @link     : http:// ...
* @copyright: Grupo Silvestre.
**************************************************************************
*/ # LoginUserAccess ===> class 
class LoginUserAccess extends MY_Controller {
    public function __construct(){
        parent::__construct();
        $this->load->library('form_validation');
        $this->load->helper('form');
    }

}