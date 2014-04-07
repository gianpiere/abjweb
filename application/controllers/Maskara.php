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
class Maskara extends MY_Controller{
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
    * @copyright: ABJ LOS OLIVOS
    * @license  : http://localhost/
    *
    * ========================================================================
    * @todo     : function que permite enmascarar la ruta del archivo CSS.
    * ========================================================================
    */
    public function anonymousurl($v){
        $ruta = $this->uri->segment(2,false);
        if(!empty($ruta)):
            // recibe la ruta ensamblada.
            $ruta = str_replace('_', '/',$ruta);
            // separamos el ensamblado
            $partes = explode('\\',FCPATH.'application\\views\\page\\'.str_replace('/', '\\',$ruta));
            // separamos el nombre del archivo con extencion de la ruta completa
            $filecrop = $partes[count($partes)-1];
            // recogemos la extencion del archivo para usarlo como carpeta
            $ext = explode('.',$filecrop);
            // verificamos que exista la extencion del archivo para evitar conflictos
            if(is_array($ext) && !empty($ext[1])): 
                $ext = $ext[1];
                // ensamblamos la ruta del archivo para buscar su existencia en el sistema
                $compuesto  = str_replace($filecrop, $ext.'\\'.$filecrop,FCPATH.'application\\views\\page\\'.str_replace('/', '\\',$ruta));
                // ensamblamos la ruta para cargar la vista del archivo en el navegador
                $vistafinal = str_replace('\\','/',str_replace(FCPATH.'application\\views\\', '',$compuesto));
                // imprimimos el archivo 
                if(file_exists($compuesto)):
                    if ($ext == 'css'):
                        header("Content-type: text/css");
                    elseif($ext == 'js'):
                        header('Content-type: application/javascript');
                    endif;
                    
                    $this->load->view($vistafinal);
                else:
                    echo 'ERROR NO EXISTE';
                endif;
            else: 
                echo 'ERROR'; 
            endif;

            //if(file_exists(APPBASE))
        endif;

        
    }


}

