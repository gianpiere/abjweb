<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/** 
**************************************************************************
* @todo     : Clase que permite redireccionar al ci_model, personalizando
*             
* @author   : Gianpiere Ramo Bernuy. 
* @return   : view : 
* @see      : Grupo Silvestre
* @link     : http:// ...
* @copyright: Grupo Silvestre.
**************************************************************************
*/ # LoginUserAccess ===> class 
class MY_Model extends CI_Model{
	 function __construct(){
        parent::__construct();
    }

    /**
    * @todo : Funcion que permite convertir un resultado de una sola fila en un arreglo para mostrarse al Controller.
    */
    function QueryRows($Arreglo){ 
        if(is_array($Arreglo)):
            $arr = [];
            foreach ($Arreglo as $key => $Capa){
                $arr[] = $Capa;
            } return $arr;
        else:
            return false;
        endif;
    }

    /**
    * @todo : Funcion que permite convertir un resultado de multiples filas en un arreglo vidimencional.
    */
    function QueryResult($Arreglo){
        if(is_array($Arreglo)):
    	   $arr = [];
            foreach ($Arreglo as $key => $Capa) {
                $subarr = [];
                if(is_array($Capa)):
            		foreach ($Capa as $scp => $SubCapa) {
                        $subarr[] = $SubCapa;
            		} $arr [] = $subarr;
                endif;
        	} return $arr;
        else:
            return array('ERROR');
        endif;
    }

}