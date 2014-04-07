<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
| -------------------------------------------------------------------------
| Hooks
| -------------------------------------------------------------------------
| This file lets you define "hooks" to extend CI without hacking the core
| files.  Please see the user guide for info:
|
|	http://codeigniter.com/user_guide/general/hooks.html
|
*/

/* ****************************************************************** *//**
* @todo : validacion de logeo de usuario a su cuenta.
* |	
* | Valida que la session este activa y si es negativo redirecciona el view
* | al formulario de logeo iniciar o a un formulario fancy para acceder sin
* | salir de la pagina actual de navegacion.
*/ // :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
$hook['pre_controller'] = array(
	                                'class'    => 'SessionData',
	                                'function' => 'initializeData',
	                                'filename' => 'loginHelper.php',
	                                'filepath' => 'hooks',
	                                'params'   => array()
                                );


/* ****************************************************************** *//**
* @todo : validacion de Permisos por usuario administrador
* |	
* | Valida que la session este activa y verifica si el usuario activo es el
* | administrador, permitiendole acceso a siertos contenidos y mostrando la
* | interfaz con controles unicos de un administrador, como el poder editar
*/ // :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
$hook['pre_controller'] = array(
	                                'class'    => 'AdminAccess',
	                                'function' => 'isAdministrator',
	                                'filename' => 'adminPermission.php',
	                                'filepath' => 'hooks',
	                                'params'   => array()
                                );


/* ****************************************************************** *//**
* @todo : validacion de Peticiones por session activa.
* |	
* | Valida que usuario sea el correcto accediendo a traves de un token para
* | cada session y registro independiente x peticion al servidor con ajax.
*/ // :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
$hook['pre_controller'] = array(
	                                'class'    => 'TokenAccess',
	                                'function' => 'isTokenCompare',
	                                'filename' => 'tokenCompare.php',
	                                'filepath' => 'hooks',
	                                'params'   => array()
                                );

/* End of file hooks.php */
/* Location: ./application/config/hooks.php */