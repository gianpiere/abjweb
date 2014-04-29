<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/** 
**************************************************************************
* @todo     : Home Page
* @author   : Gianpiere Ramo Bernuy. 
* @return   : view : 
* @see      : ABJ WEB
* @link     : http:// ...
* @copyright: Academia Biblica Juvenil
**************************************************************************
*/ # --------------------------------------------------------------------- 
class Fotos extends MY_Controller{
    public function __construct(){
        parent::__construct();
        $this->load->library('form_validation');
        $this->load->helper('form');
    }

    /**
    * @package  : CodeIgniter :: .
    * @link     : FormularioInicio 
    * @author   : Gianpiere Julio Ramos Bernuy.
    * @since    : Version 1.0
    * @copyright: Academia Biblica Juvenil
    * @license  : http://10.10.1.8:8087/
    *
    * ========================================================================
    * @todo     : function que permite Listar las Proyecciones totales creadas
    * ========================================================================
    */
    public function inicio(){
        $this->css = array('ft.css');
        $this->js  = array('ft.js');

        $this->load->model('m_devocional');

        $devocional = $this->m_devocional->SQL_dv_LeerUltimoDevocional();

        if(isset($devocional) && !empty($devocional) && is_array($devocional) && $devocional[0] != '00'):
            $this->devocional = array(
                'textcontent'   => $devocional[0],
                'rutabiblica'   => $devocional[1]
            );
        endif;

        $this->focus = 'fotos';
        $this->Theme('page/fotos/ft/','ft.php');
    }

    public function TomarFotoPerfil(){
        $this->css = array();
        $this->js  = array();
        $pathmask = 'page/tomarfoto/tf/';
        $this->fancy('page/tomarfoto/tf/tf',$pathmask);
    }


}

