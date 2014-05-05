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
class Home extends MY_Controller{
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
    * @license  : jGianpiere
    *
    * ========================================================================
    * @todo     : function que permite Listar las Proyecciones totales creadas
    * ========================================================================
    */
    public function inicio(){
        $this->css = array('hm.css');
        $this->js  = array('hm.js');

        $this->load->model('m_devocional');

        $devocional = $this->m_devocional->SQL_dv_LeerUltimoDevocional();

        if(isset($devocional) && !empty($devocional) && is_array($devocional) && $devocional[0] != '00'):
            $this->devocional = array(
                'textcontent'   => $devocional[0],
                'rutabiblica'   => $devocional[1]
            );
        endif;

        $this->load->model('m_fotos');
        $imagenHome = $this->m_fotos->SP_ftw_ImagenWebTipo('COD00000002');
        if(isset($imagenHome) && !empty($imagenHome)):
            $this->imagenPortada = $imagenHome;
        endif;

        $this->load->model('m_Slider');
        $result_sliders = $this->m_Slider->SQL_sld_Sliders();
        if(!empty($result_sliders) && is_array($result_sliders)):
            $sliders = [];
            foreach ($result_sliders as $sld => $slider) {
                $slide = 
                    array(
                        'title'         => $slider[10],
                        'img'           => SLIDER.$slider[4],
                        'description'   => $slider[5],
                        'button'        => array($slider[7],$slider[6],$slider[16]),
                        'options'       => array('textdirection' => $slider[13], 'titlecolor' => $slider[11], 'textcolor' => $slider[12])
                    );

                $sliders[] = $slide;
            }

            $this->sliders = json_encode($sliders);
        endif;

        $this->focus = 'home';
        $this->Theme('page/Home/hm/','hm.php');
    }


}

