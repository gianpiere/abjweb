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

        $usnombre   = ucwords($this->input->post('name'));
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
                
                if(is_array($insert_result) && isset($insert_result) && !empty($insert_result)):
                    $PrimerNombre = lang('Global.text.pluralname');
                    $name = ucfirst(strtolower(explode(' ',$insert_result[1],1)[0]));
                    if(!empty($name)): $PrimerNombre = $name; endif;

                    $arraySession = array(
                        'UsuarioId'                     => $insert_result[0],
                        'UsuarioNombre'                 => $insert_result[1],
                        'UsuarioPrimerNombre'           => $PrimerNombre,
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
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $Codigo_post = $this->input->Post('token');
                $usToken = $this->session->userdata('UsuarioToken');
                $usCoAct = $this->session->userdata('UsuarioCodigoActivacion');
            if (!empty($usToken) && !empty($usCoAct)):
                $Codigo_sess = hash_hmac('crc32',$this->session->userdata('UsuarioToken'),$this->session->userdata('UsuarioCodigoActivacion'));
                if ($Codigo_sess == $Codigo_post):
                    $nombre = $this->session->userdata('UsuarioPrimerNombre');
                    $PrimerNombre = lang('Global.text.pluralname');
                    if(isset($nombre) && !empty($nombre)): 
                        $PrimerNombre = $this->session->userdata('UsuarioPrimerNombre');
                    endif;
                    # enviar el Email..
                    $this->load->library('lbl_Html_Compact');
                    $HtmlParams = array(
                        'NombreUsuario'     => $PrimerNombre,
                        'EmailMensaje'      => 'su codigo es:',
                        'CodigoActivacion'  => $this->session->userdata('UsuarioCodigoActivacion'),
                        'EnlaceAlterno'     => ''
                    ); $HTML_Mensaje = $this->lbl_html_compact->HTML_Email_ConfirmaciondeCuenta($HtmlParams);

                    $Parametros = array(
                        'Email_Destino' => $this->session->userdata('UsuarioEmail'),
                        'Email_Titulo'  => lang('Global.text.emailconfirtitle'),
                        'Email_Motivo'  => lang('Global.text.emailconfirmacion'),
                        'Email_Mensaje' => $HTML_Mensaje,
                        'NombreUsuario' => $PrimerNombre,
                        'text_mensaje'  => lang('Global.text.emailconfmsg').$this->session->userdata('UsuarioCodigoActivacion')
                    ); $this->sendEmail($Parametros);

                else:
                    # no coinside el token asignado..
                endif;
            else:
                # usuario no tiene session o se perdio..
            endif;
        }else{
            $this->Pasos();
        }
    }

    public function LogInAccess(){
        if ($_SERVER['REQUEST_METHOD'] == 'POST'):
            $email      = str_replace('%40','@',$this->input->post('email'));
            $password   = $this->input->post('password');

            if(!empty($email) && !empty($password)):
                $this->load->model('m_UserLogin');
                $params = array(
                    'UserEmail'     => $email,
                    'UserPassw'     => $password
                );

                $result = $this->m_UserLogin->SQL_usIniciarSession($params);
                if(isset($result) && !empty($result)):
                    $PrimerNombre = lang('Global.text.pluralname');
                    $name = ucfirst(strtolower(explode(' ',$result[4],1)[0]));
                    if(!empty($name)): $PrimerNombre = $name; endif;

                    $arraySession = array(
                        'UsuarioId'                     => $result[0],
                        'UsuarioNombre'                 => $result[4],
                        'UsuarioPrimerNombre'           => $PrimerNombre,
                        'UsuarioEmail'                  => $result[1],
                        'UsuarioToken'                  => $result[3],
                        'UsuarioCodigoActivacion'       => NULL,
                        'UsuarioFechaActivacion'        => NULL,
                        'UsuarioEstado'                 => $result[6],
                        'UsuarioDatosId'                => $result[16]
                    );

                    $this->session->set_userdata($arraySession);
                    echo json_encode(array('OK', BASE_PATH.'Account/LandingPage'));
                endif;
            else:
                echo json_encode(array('00','usuario o Password no ingresado'));
            endif;
        endif;
    }

    public function EmailConfirmCode(){
        if ($_SERVER['REQUEST_METHOD'] == 'POST'):
            $email  = $this->session->userdata('UsuarioEmail');
            $ccodi  = $this->session->userdata('UsuarioCodigoActivacion');
            $codigo = $this->input->post('codigo');
            if(!$email): $email = $this->input->post('email'); endif;
            if($ccodi == (int) $codigo):
                $params = array(
                    'UsuarioId'     => $this->session->userdata('UsuarioId'),
                    'UsuarioCodigo' => $codigo, 
                    'Token'         => $this->session->userdata('UsuarioToken')
                );
                $this->load->model('m_userlogin');
                $result = $this->m_userlogin->SQL_UsuarioConfirmarCodigo($params);
                echo json_encode($result);
            else:
                echo json_encode(array('00','ERROR Codigo Incorrecto'));
            endif;
        endif;
    }

    public function DatosPersonalesBasicos(){
        $foto = $this->input->post('foto_b64');
        $sexo = $this->input->post('rbo_sexo');
        $supervisor = $this->input->post('supervisor_id');
        $fechanacim = $this->input->post('fecha_nac');

        $this->load->model('m_UserLogin');

        $Params = array(
            'xUsuarioId'                => $this->session->userdata('UsuarioId'),
            'xUsuarioToken'             => $this->session->userdata('UsuarioToken'),
            'xUsuarioSexo'              => $sexo, 
            'xUsuarioFechaNacimiento'   => $fechanacim, 
            'xUsuarioSupervisorId'      => $supervisor, 
            'xUsuarioFotoUrl'           => $foto
        );
        $result = $this->m_UserLogin->SQL_usaddUsuarioDatosBasicos($Params);

        echo json_encode($result);
    }

    public function CursosRealizadosxAgregar(){
        $curso      = (int) $this->input->post('cursoid');
        $UsuarioId  = $this->session->userdata('UsuarioId');
        $usToken    = $this->session->userdata('UsuarioToken');

        if($curso && $UsuarioId && $usToken):
            $this->load->model('m_cursos');
            $params = array(
                'xUsuarioId'    => $UsuarioId,
                'xUsuarioToken' => $usToken,
                'xCursoId'      => $curso
            );
            $result = $this->m_cursos->SQL_crspAgregarCursoPrevio($params);
            echo json_encode($result);
        elseif(!$UsuarioId):
            echo json_encode(array('00','05'));
        else:
            echo json_encode(array('00','Curso invalido'));
        endif;
    }

    public function Pasos(){
            $Paso = (int) $this->uri->segment(3,false);
            if($Paso == 1 || !$Paso):
                $this->PasoUno();
            elseif($Paso == 2):
                $this->PasoDos();
            elseif($Paso == 3):
                $this->PasoTres();
            else:
                # nada
            endif;
    }

    public function PasoUno(){

            $this->css = array('pasouno.css');
            $this->js  = array('pasouno.js');
            $name = $this->session->userdata('UsuarioNombre');
            $PrimerNombre = $this->session->userdata('UsuarioPrimerNombre');
            $this->descripcion  = 'Confirma el codigo que enviamos a tu E-mail';
            $this->email        = $this->session->userdata('UsuarioEmail');
            $this->nombre       = $PrimerNombre;

            $Codigo_sess = hash_hmac('crc32',$this->session->userdata('UsuarioToken'),$this->session->userdata('UsuarioCodigoActivacion'));
            $this->token        =  $Codigo_sess;

            $this->load->model('m_cursos');
            $cursos = $this->m_cursos->SQL_crsListarCursos();
            if(isQueryR($cursos)):
                $ListadeCursos = [];
                foreach ($cursos as $crs => $curso) {
                    $cur = array(
                        'text'  =>$curso[1].','.lang('Global.text.nivel').$curso[11].' ('.$curso[12].')',
                        'value' =>$curso[0]
                    ); 
                    $ListadeCursos[] = $cur;
                }

                $this->listadecursos = json_encode($ListadeCursos);
            endif;

            $this->load->model('m_supervisor');
            $supervisores = $this->m_supervisor->SQL_crsListarSupervisor();
            if(isQueryR($supervisores)):
                $ListarSupervisores = [];
                foreach ($supervisores as $sup => $Supervisor) {
                    $superv = array(
                        'text'  => $Supervisor[1],
                        'value' => $Supervisor[0]
                    );
                    $ListarSupervisores[] = $superv;
                }

                $this->listarsupervisores = json_encode($ListarSupervisores);
            endif;

            $this->vista('page/newaccount/pasouno/','pasouno.php');
    }

    public function PasoDos(){
            $this->css = array('pasodos.css');
            $this->js  = array('pasodos.js');
            $name = $this->session->userdata('UsuarioNombre');
            $this->descripcion  = 'Ingresa algunos datos personales';
            $this->email        = $this->session->userdata('UsuarioEmail');
            $this->nombre       = $this->session->userdata('UsuarioPrimerNombre');

            $this->load->model('m_cursos');
            $cursos = $this->m_cursos->SQL_crsListarCursos();
            if(isQueryR($cursos)):
                $ListadeCursos = [];
                foreach ($cursos as $crs => $curso) {
                    $cur = array(
                        'text'  =>$curso[1].','.lang('Global.text.nivel').$curso[11].' ('.$curso[12].')',
                        'value' =>$curso[0]
                    ); 
                    $ListadeCursos[] = $cur;
                }

                $this->listadecursos = json_encode($ListadeCursos);
            endif;

            $this->load->model('m_supervisor');
            $supervisores = $this->m_supervisor->SQL_crsListarSupervisor();
            if(isQueryR($supervisores)):
                $ListarSupervisores = [];
                foreach ($supervisores as $sup => $Supervisor) {
                    $superv = array(
                        'text'  => $Supervisor[1],
                        'value' => $Supervisor[0]
                    );
                    $ListarSupervisores[] = $superv;
                }

                $this->listarsupervisores = json_encode($ListarSupervisores);
            endif;

            $this->vista('page/newaccount/pasodos/','pasodos.php');
    
    }

    public function PasoTres(){
            $this->css = array('pasotres.css');
            $this->js  = array('pasotres.js');
            $name = $this->session->userdata('UsuarioNombre');
            $PrimerNombre = $this->session->userdata('UsuarioPrimerNombre');
            $this->descripcion  = 'Actualiza los cursos que ya llevaste';
            $this->email        = $this->session->userdata('UsuarioEmail');
            $this->nombre       = $PrimerNombre;

            $Codigo_sess = hash_hmac('crc32',$this->session->userdata('UsuarioToken'),$this->session->userdata('UsuarioCodigoActivacion'));
            $this->token        =  $Codigo_sess;

            $this->load->model('m_cursos');
            $cursos = $this->m_cursos->SQL_crsListarCursos();
            if(isQueryR($cursos)):
                $ListadeCursos = [];
                foreach ($cursos as $crs => $curso) {
                    $cur = array(
                        'text'  =>$curso[1].','.lang('Global.text.nivel').$curso[11].' ('.$curso[12].')',
                        'value' =>$curso[0]
                    ); 
                    $ListadeCursos[] = $cur;
                }

                $this->listadecursos = json_encode($ListadeCursos);
            endif;

            $this->load->model('m_supervisor');
            $supervisores = $this->m_supervisor->SQL_crsListarSupervisor();
            if(isQueryR($supervisores)):
                $ListarSupervisores = [];
                foreach ($supervisores as $sup => $Supervisor) {
                    $superv = array(
                        'text'  => $Supervisor[1],
                        'value' => $Supervisor[0]
                    );
                    $ListarSupervisores[] = $superv;
                }

                $this->listarsupervisores = json_encode($ListarSupervisores);
            endif;

            $this->vista('page/newaccount/pasotres/','pasotres.php');
    
    }

    public function LandingPageUser(){
        echo 'landing';
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

