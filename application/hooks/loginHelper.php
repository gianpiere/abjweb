<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class sessiondata extends MY_Controller{
    function initializeData(){
        $this->load->library('session');
        $this->load->helper('url');
        $this->load->helper('form');
        // $this->session->set_userdata('email','gianpiere.ramos@gruposilvestre.com.pe');
        $page_is = strtolower($this->uri->segment(1,false));
        # Arreglo de excepciones 
        $ListaEx = array(
            'login',
            'validateuser'
        );
        
        if($this->session->userdata('us_email') && !$page_is):
            redirect('landingPageUser');
        elseif(!$this->session->userdata('us_email') && !in_array($page_is, $ListaEx)):
            if(strtoupper($_SERVER['REQUEST_METHOD']) === 'POST'):
                echo '<script type="text/javascript">location.reload();</script>';
                exit();
            else:
                redirect('logIn');
            endif;
        endif;
    }

}