<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require_once('PHPMailer/class.phpmailer.php');
/** 
**************************************************************************
* @todo     : Login Class
* @author   : Gianpiere Ramo Bernuy. 
* @return   : view : 
* @see      : ABJ WEB
* @link     : http:// ...
* @copyright: Academia Biblica Juvenil
**************************************************************************
*/ # --------------------------------------------------------------------- 
class Login extends MY_Controller{
    public function __construct(){
        parent::__construct();
        $this->load->library('form_validation');
        $this->load->helper(array('form', 'url'));
    }

    /**
    * @package  : CodeIgniter :: .
    * @link     :  
    * @author   : Gianpiere Julio Ramos Bernuy.
    * @since    : Version 1.0
    * @copyright: Academia Biblica Juvenil
    * @license  : http://10.10.1.8:8087/
    *
    * ========================================================================
    * @todo     : function que permite mostrar el formulario de logeo 
    * ========================================================================
    */
    public function index(){
        $this->sendEmail();
    }

    /**
    * @package  : CodeIgniter :: .
    * @link     :  
    * @author   : Gianpiere Julio Ramos Bernuy.
    * @since    : Version 1.0
    * @copyright: Academia Biblica Juvenil
    * @license  : 
    *
    * ========================================================================
    * @todo     : function que permite mostrar el formulario de logeo 
    * ========================================================================
    */
    public function FormularioRegistro(){
        $this->css = array('lg.css');
        $this->js  = array('lg.js');
        $pathmask = 'page/login/lg/';
        $this->fancy('page/login/lg/FormRegistrar',$pathmask);
    }

    /**
    * @package  : CodeIgniter :: .
    * @link     :  
    * @author   : Gianpiere Julio Ramos Bernuy.
    * @since    : Version 1.0
    * @copyright: Academia Biblica Juvenil
    * @license  : 
    *
    * ========================================================================
    * @todo     : function que permite Registrar los datos de un nuevo usuario
    * ========================================================================
    */
    public function RegistrarUsuario(){

        $this->form_validation->set_rules('name', 'Nombre', 'required');
        $this->form_validation->set_rules('password', 'Password', 'required');
        $this->form_validation->set_rules('passconf','Confirm Password', 'required');
        $this->form_validation->set_rules('email', 'Email', 'required');

        $usnombre   = $this->input->post('name');
        $usemail    = $this->input->post('email');
        $password   = $this->input->post('password');
        $passconf   = $this->input->post('passconf');

        if($this->form_validation->run() == FALSE):
            echo validation_errors();
        elseif($password == $passconf):
            $this->load->model('m_UserLogin');
            $Params = array($usnombre,NULL,NULL,NULL,NULL,$usemail,$password,NULL);
            $insert_result = $this->m_UserLogin->SQL_lg_InsertUsuarioNuevo($Params);
            if(isQueryR($insert_result)):

                $this->load->library('lbl_Html_Compact');
                $HtmlParams = array(
                    'NombreUsuario'     => 'Gianpiere Ramos Bernuy',
                    'EmailMensaje'      => 'Su Codigo de COnfirmacion es: '.'07777770',
                    'CodigoActivacion'  => '07777770',
                    'EnlaceAlterno'     => 'http://localhost/abjweb/accountconfirmation/6743242'
                );

                $HTML_Mensaje = $this->lbl_html_compact->HTML_Email_ConfirmaciondeCuenta($HtmlParams);

                $Parametros = array(
                    'Email_Destino' => $usemail,
                    'Email_Titulo'  => 'ABJ - Confirmacion de cuenta.',
                    'Email_Motivo'  => 'Academia Biblica Juvenil :: Correo de Confirmacion.',
                    'Email_Mensaje' => $HTML_Mensaje,
                    'NombreUsuario' => explode($usnombre,' ')[0],
                    'text_mensaje'  => 'Su Codigo de activacion es: '.'07777770'
                );
                
                if(is_array($insert_result) && isset($insert_result) && !empty($insert_result)):
                   #$this->sendEmail($Parametros);

                    $arraySession = array(
                        'UsuarioId'                     => $insert_result[0],
                        'UsuarioNombre'                 => $insert_result[1],
                        'UsuarioEmail'                  => $insert_result[2],
                        'UsuarioToken'                  => $insert_result[3],
                        'UsuarioCodigoActivacion'       => $insert_result[4],
                        'UsuarioFechaActivacion'        => $insert_result[5],
                        'UsuarioEstado'                 => $insert_result[6],
                        'UsuarioDatosId'                => $insert_result[7]
                    );

                    $this->session->set_userdata($arraySession);

                    echo json_encode(array('OK',hash_hmac('crc32',$insert_result[3],$insert_result[4])));
                endif;

            else:
                #code..
            endif;
        else:
            #code..
        endif;
    }

    /**
    * @package  : CodeIgniter :: .
    * @link     :  
    * @author   : Gianpiere Julio Ramos Bernuy.
    * @since    : Version 1.0
    * @copyright: Academia Biblica Juvenil
    * @license  : 
    *
    * ========================================================================
    * @todo     : function que permite Acceder a una cuenta como Pre-Registro
    * ========================================================================
    */
    public function PreRegistro(){

        echo 'preRegistro';
    }

    public function sendEmail($Params){
        $Email_Destino  = $Params['Email_Destino'];
        $Email_Titulo   = $Params['Email_Titulo'];
        $Email_Motivo   = $Params['Email_Motivo'];
        $Email_Mensaje  = $Params['Email_Mensaje'];
        $NombreUsuario  = $Params['NombreUsuario'];
        $text_mensaje   = $Params['text_mensaje'];
        
        $this->load->library('EnvioEmail');
        
        $mail = new PHPMailer();
        $mail->IsSMTP();                                                // establecemos que utilizaremos SMTP
        $mail->SMTPAuth   = true;                                       // habilitamos la autenticación SMTP
        $mail->SMTPSecure = "ssl";                                      // establecemos el prefijo del protocolo seguro de comunicación con el servidor
        $mail->Host       = "smtp.gmail.com";                           // establecemos GMail como nuestro servidor SMTP
        $mail->Port       = 465;                                        // establecemos el puerto SMTP en el servidor de GMail
        $mail->CharSet    = 'utf-8';                                    // establecemos el UTF-8
        $mail->Username   = "jgianpiere@gmail.com";                     // la cuenta de correo GMail
        $mail->Password   = "CAGADA.g1";                                // password de la cuenta GMail
        $mail->SetFrom('jgianpiere@gmail.com', $Email_Titulo);          // Quien envía el correo
        $mail->AddReplyTo("jgianpiere@gmail.com",$Email_Titulo);        // A quien debe ir dirigida la respuesta
        $mail->Subject    = $Email_Motivo;                              // "Correo de Prueba";  //Asunto del mensaje
        $mail->Body      = $Email_Mensaje;                              // "<h1>hola</h1><a href='#'>Cuerpo en HTML</a> grgr <br /> <strong>negrita</strong>";
        $mail->AltBody    = $text_mensaje;                              //
        $destino = $Email_Destino;                                      // "gianpiere@outlook.com";
        $mail->AddAddress($destino, $NombreUsuario);                    //

        // $mail->AddAttachment("images/phpmailer.gif");      // añadimos archivos adjuntos si es necesario
        // $mail->AddAttachment("images/phpmailer_mini.gif"); // tantos como queramos

        if($mail->Send()) {
            $data["message"] = "Error en el envío: " . $mail->ErrorInfo;

            $data['message'] = "Correo de Confirmacion Enviado por favor revise su correo electronico.";
            $data['destino'] = $Email_Destino;
            $this->data = $data;
            return true;
            # echo 'correo enviado!';

        } else {
            $data["message"] = "¡Mensaje enviado correctamente!";
            echo 'error al enviar';
        }
    }


}

