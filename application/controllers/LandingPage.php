
<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/** 
**************************************************************************
* @todo     : Nosotros Page
* @author   : Gianpiere Ramo Bernuy. 
* @return   : view : 
* @see      : ABJ WEB
* @link     : http:// ...
* @copyright: Academia Biblica Juvenil
**************************************************************************
*/ # --------------------------------------------------------------------- 
class LandingPage extends MY_Controller{
    public function __construct(){
        parent::__construct();
        $this->load->library('form_validation');
        $this->load->helper('form');
    }
}

