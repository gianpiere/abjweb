<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class adminaccess extends MY_Controller{
    function isAdministrator(){
        $this->load->library('session');
        $this->load->helper('url');
        $this->load->helper('form');
        
        // exit();
    }

}