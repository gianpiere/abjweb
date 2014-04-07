<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/** 
**************************************************************************
* @todo     : Email Send
* @author   : Gianpiere Ramo Bernuy. 
* @return   : view : 
* @see      : ABJ WEB
* @link     : http:// ...
* @copyright: Academia Biblica Juvenil
**************************************************************************
*/ # --------------------------------------------------------------------- 
class EmailSend extends MY_Controller{
    public function __construct(){
        parent::__construct();
        date_default_timezone_set('America/Lima');
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
        $this->sendEmail();
    }

    public function sendEmail($Params){
        $Email_Destino  = $Params['Email_Destino'];
        $Email_Titulo   = $Params['Email_Titulo'];
        $Email_Motivo   = $Params['Email_Motivo'];
        $Email_Mensaje  = $Params['Email_Mensaje'];
        $NombreUsuario  = $Params['NombreUsuario'];
        
        // $encrypted_string = str_replace('@','%40',$Email_Destino).'::::'.$Email_Mensaje;
        $encrypted_string = str_replace('=','%3D',base64_encode($Email_Destino.'::::'.$Email_Mensaje));
        $Mensaje_Personalixado = '<div style="width:530px; height:335px; background:#820000;" ><table colspan="0" cellspacing="0"><td width="330px"><img src="http://abjlosolivos.com/statics/images/mailtitle.png" width="298px" height="48px" /><div align="left"><p style="text-align:justify;width:260px;padding-left:10px;"><font color="#FFF">'.$NombreUsuario.',</br>Bienvenido!, Academia Bíblica Juvenil</br>Confirmara tu Cuenta de Correo para ello Tu Codigo de Activación es: <strong><h1 style="padding-left:20px;">'.$Email_Mensaje.'</h1></strong></font></p></div></td><td><img src="http://abjlosolivos.com/statics/images/mail.png" width="228px" height="232px" /></td></table><div><span style="font-size:12px;color:#CCC;">Tambien puedes hacer click en el siguiente enlace para validar tu cuenta de correo.</span></div><div style="text-align:center"><p><a style="color:#FF0" href="http://abjlosolivos.com/ConfirmacionxCorreo/'.$encrypted_string.'">http://abjlosolivos.com/ConfirmacionxCorreo/'.$encrypted_string.'</a></p></div></div>';
        $this->load->library('My_PHPMailer');
        
        $mail = new PHPMailer();
        $mail->IsSMTP(); // establecemos que utilizaremos SMTP
        $mail->SMTPAuth   = true; // habilitamos la autenticación SMTP
        $mail->SMTPSecure = "ssl";  // establecemos el prefijo del protocolo seguro de comunicación con el servidor
        $mail->Host       = "smtp.gmail.com";      // establecemos GMail como nuestro servidor SMTP
        $mail->Port       = 465;                   // establecemos el puerto SMTP en el servidor de GMail
        $mail->CharSet    = 'utf-8';                   // establecemos el UTF-8
        $mail->Username   = "jgianpiere@gmail.com";  // la cuenta de correo GMail
        $mail->Password   = "CAGADA.g1";            // password de la cuenta GMail
        $mail->SetFrom('jgianpiere@gmail.com', $Email_Titulo);  //Quien envía el correo
        $mail->AddReplyTo("jgianpiere@gmail.com",$Email_Titulo);  //A quien debe ir dirigida la respuesta
        $mail->Subject    = $Email_Motivo; // "Correo de Prueba";  //Asunto del mensaje
        $mail->Body      = $Mensaje_Personalixado; // "<h1>hola</h1><a href='#'>Cuerpo en HTML</a> grgr <br /> <strong>negrita</strong>";
        $mail->AltBody    = $NombreUsuario." Bienvenido tu Codigo de Activacion es: ".$Email_Mensaje;
        $destino = $Email_Destino; // "gianpiere@outlook.com";
        $mail->AddAddress($destino, $NombreUsuario);

        // $mail->AddAttachment("images/phpmailer.gif");      // añadimos archivos adjuntos si es necesario
        // $mail->AddAttachment("images/phpmailer_mini.gif"); // tantos como queramos

        if($mail->Send()) {
            $data["message"] = "Error en el envío: " . $mail->ErrorInfo;

            $data['message'] = "Correo de Confirmacion Enviado por favor revise su correo electronico.";
            $data['destino'] = $Email_Destino;
            $this->data = $data;
            $this->load->view('page/registro/registro');

        } else {
            $data["message"] = "¡Mensaje enviado correctamente!";
            echo 'error al enviar';
        }
    }

    public function confirmacionxlink($usuarioyclave){

        // $defrag = explode('::::',str_replace('%40','@',$usuarioyclave));
        $defrag = explode('::::',str_replace('%40','@',base64_decode(str_replace('%3D','=',$usuarioyclave))));
        echo json_encode($defrag);
    }


}

