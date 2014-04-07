<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

// ------------------------------------------------------------------------
/** 
* @return 	: default view
* @see		: URI Defaults.
*/
$route['default_controller'] = "Home/inicio";
$route['404_override'] = '';

// ------------------------------------------------------------------------

///////////////////////////////////////////////////////////////////////////
#| PACKAGE NAME GROUP , EXAMPLE : USER ACCESS ADMINISTRATOR.
// ........................................................................



/* ****************************************************************** *//**
* @see 		: 
* @link 	: Class function in File link 
* @param 	: uri segment params
* @return 	: view return name
* @package 	: FileName
* @author 	: Gianpiere Ramos Bernuy.
* @version 	: 1.0
***************************************************************************
* @date 	: 
* @todo 	: Function description and method use.
**************************************************************************/
# $route[''] = '';

//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::GRB://


/* ****************************************************************** *//**
* @see 		: 
* @link 	: Class function in File link 
* @param 	: uri segment params
* @return 	: view return name
* @package 	: FileName
* @author 	: Gianpiere Ramos Bernuy.
* @version 	: 1.0
***************************************************************************
* @date 	: 
* @todo 	: Function description and method use.
**************************************************************************/
$route['fnc_login'] = 'Login/FormularioRegistro';
$route['registrar'] = 'Login/RegistrarUsuario';
$route['Account'] 	= 'Login/PreRegistro';

//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::GRB://


/* ****************************************************************** *//**
* @see 		: 
* @link 	: Home/inicio 
* @param 	: localhost - basepath
* @return 	: bienvenida/bv/bv.php
* @package 	: Home
* @author 	: Gianpiere Ramos Bernuy.
* @version 	: 1.0
***************************************************************************
* @date 	: 
* @todo 	: Pagina Principal de aterrisaje de un usuario.
**************************************************************************/
$route['Home'] 			= 'Home/inicio';
$route['Nosotros'] 		= 'Nosotros/inicio';
$route['Actividades'] 	= 'Actividades/inicio';
$route['Cursos'] 		= 'Cursos/inicio';
$route['Fotos'] 		= 'Fotos/inicio';
$route['Contactenos'] 	= 'Contactenos/inicio';
$route['Mas'] 			= 'Mas/inicio';

//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::GRB://


/* ****************************************************************** *//**
* @see 		: 
* @link 	: Home/inicio 
* @param 	: localhost - basepath
* @return 	: bienvenida/bv/bv.php
* @package 	: Home
* @author 	: Gianpiere Ramos Bernuy.
* @version 	: 1.0
***************************************************************************
* @date 	: 
* @todo 	: Pagina Principal de aterrisaje de un usuario.
**************************************************************************/

$route['static'] = 'Maskara/anonymousurl';
$route['static/(:any)'] = 'Maskara/anonymousurl/$1';

//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::GRB://