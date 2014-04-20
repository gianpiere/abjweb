<section class="content">
		<div class="logo iblk"></div>
		<div class="fr iblk pst_rel fl">
			<nav id="lines">
				<a class="orange" href="#">Primeros Pasos</a>
				<a class="sky" href="#">Datos Personales</a>
				<a class="green" href="#">Confirmacion Email</a>
			</nav>
			<span class="desc"><?=!empty($this->descripcion) ? $this->descripcion : '';?></span>
			<input id="token" type="hidden" value="<?=isset($this->token) ? $this->token : '';?>"></input>
			<script type="text/javascript">
				if(!$('#token').val()){
					$('#token').val(window.location.href.split('#')[1])
				}
			</script>
		</div>
</section>

<section class="content">
		<section id="ConfirmacionEmail" class="mt20 panel_dos leftgreen_9 color_8 fl">
			Hola <?= (isset($this->nombre) && !empty($this->nombre)) ? $this->nombre : '' ?>, <br/>
			Hemos enviado un Email a tu cuenta de correo <span class="color_1"><?= (isset($this->email) && !empty($this->email)) ? $this->email : '';?></span>, con un codigo que confirmara tu cuenta, revisa tu bandeja de entrada.
			<br/><br/>
			en caso de no econtrarlo, revisa tu carpeta de correo span.
			<hr class="linea_verde" />
			<label class="color_2 b"><?= (isset($this->email) && !empty($this->email)) ? $this->email : '';?></label>
			<a id="cambiar" href="#cambiar" class="color_3 ml10">cambiar</a>
			<a id="reenviar" class="color_1 fr" href="#reenviar" data-email="<?= (isset($this->email) && !empty($this->email)) ? $this->email : '';?>">reenviar correo</a>
			<div class="codigo_txt" align="center">
				<input id="codigo" width="70px" class="inp_codigo number" placeholder="CODIGO"></input>
			</div>
			<a id="confirm" class="fr mt30 color_5" href="#confirmar">confirmar</a>
			<a id="omitir" class="fr mt30 mr10 color_4" href="#omitir">omitir</a>
		</section>
</section>


<style scoped>
			.demo-section {
				width: 460px;
				height: 340px;
				padding: 30px;
			}
			.demo-section h2 {
				text-transform: uppercase;
				font-size: 1.2em;
				margin-bottom: 30px;
			}
			#tshirt {float: left;margin: 0 40px 30px 0;}
			#options {padding: 20px 0 30px 30px;}
			#options h3 {font-size: 1em;font-weight: bold;margin: 25px 0 8px 0;}
			#get {margin-top: 25px;}

            .k-readonly{color: #0081B1;}
		</style>
<script>
    $(document).ready(function() {
    	// omitir 
    	$('#omitir').on('click',function(e){
    		e.preventDefault();
    		window.location="paso/2";
    	});

    	// reenviar
    	$('#reenviar').on('click',function(e){
    		e.preventDefault();
    		$Token = $('#token').val();
			if($Uri){
				$.ajax({
					type 		: 'POST',
					data 	 	: 'token='+$Token,
					url			: '',
					success		: function(data){
						$('#token').val(window.location.href.split('#')[1]);
						window.location.hash = '#';	
					},
					error 		: function(){
						$('#reenviar').delay(1200).trigger('click');
					}	
				});
			}else{
				console.log('no hay uri hash');
			}
    	});

    	$('#cambiar').on('click',function(e){
    		E.preventDefault();
    	})


    	// DataPicker 
    	$("#fechanacimiento").kendoDatePicker();

        // ComboBox :: Supervisor
        $("#supervisor").kendoComboBox({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: <?=!empty($this->listarsupervisores) ? $this->listarsupervisores : [];?>,
            filter: "contains",
            suggest: true,
            index: -1
        });

        // ComboBox Curso
        $("#curso").kendoComboBox({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: <?= !empty($this->listadecursos) ? $this->listadecursos : [];?>,
            filter: "contains",
            suggest: true,
            index: -1
        });

        var fabric = $("#fabric").data("kendoComboBox");

        // envio de Datos
        $('#confirm').on('click',function(e){
        	e.preventDefault();
        	$codigo = $('#codigo').val();
        	$email 	= $('#email').val();

        	$.ajax({
        		type 	: 'POST',
        		data 	: 'codigo='+$codigo+'&email='+$email,
        		url		: 'confirmacionemail',
        		success : function(data){
        			try{
        				$data = $.parseJSON(data);
        				if($data[0] == 'OK'){
        					window.location.href="paso/2";
        				}else if($data[0] == '00'){
        					alert($data[1]);
        				}else{
        					console.log(data);
        				}
        			}catch(e){}
        		},
        		error 	: function(){

        		}
        	});
        });

    });
</script>