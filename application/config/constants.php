<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/*
|--------------------------------------------------------------------------
| File and Directory Modes
|--------------------------------------------------------------------------
|
| These prefs are used when checking and setting modes when working
| with the file system.  The defaults are fine on servers with proper
| security, but you may wish (or even need) to change the values in
| certain environments (Apache running a separate process for each
| user, PHP under CGI with Apache suEXEC, etc.).  Octal values should
| always be used to set the mode correctly.
|
*/
define('FILE_READ_MODE', 0644);
define('FILE_WRITE_MODE', 0666);
define('DIR_READ_MODE', 0755);
define('DIR_WRITE_MODE', 0777);

/*
|--------------------------------------------------------------------------
| File Stream Modes
|--------------------------------------------------------------------------
|
| These modes are used when working with fopen()/popen()
|
*/

define('FOPEN_READ',							'rb');
define('FOPEN_READ_WRITE',						'r+b');
define('FOPEN_WRITE_CREATE_DESTRUCTIVE',		'wb'); // truncates existing file data, use with care
define('FOPEN_READ_WRITE_CREATE_DESTRUCTIVE',	'w+b');// truncates existing file data, use with care
define('FOPEN_WRITE_CREATE',					'ab');
define('FOPEN_READ_WRITE_CREATE',				'a+b');
define('FOPEN_WRITE_CREATE_STRICT',				'xb');
define('FOPEN_READ_WRITE_CREATE_STRICT',		'x+b');


# Definimos las Constantes del Proyecto 
define('DOMAIN','localhost');
define('BASE_PATH', 'http://'.DOMAIN.'/abjweb/');
# define('BASE_PATH', 'http://localhost/abjweb/');
define('KENDO',BASE_PATH.'statics/kui/');
define('CSS', BASE_PATH.'statics/css/');
define('CSS_LIB', BASE_PATH.'statics/css_lib/');
define('JS', BASE_PATH.'statics/js/');
define('JS_LIB', BASE_PATH.'statics/js_lib/');
define('IMG', BASE_PATH.'statics/img/');
define('GALERIA', BASE_PATH.'statics/galerias/');
define('SLIDER', BASE_PATH.'statics/galerias/slider/');
define('UPLOAD',BASE_PATH.'statics/upload/');
define('IMGPORTADA',BASE_PATH.'statics/galerias/portada/');
define('ICONOS',BASE_PATH.'statics/img/icons/');
define('FONDOS',BASE_PATH.'statics/img/fondo/');

# Caracteres especiales
define("LATIN1_UC_CHARS", "ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝ");
define("LATIN1_LC_CHARS", "àáâãäåæçèéêëìíîïðñòóôõöøùúûüý");

# Direcciones Redes Sociales
define('FACEBOOK','https://www.facebook.com/abjlosolivos');
/* End of file constants.php */
/* Location: ./application/config/constants.php */