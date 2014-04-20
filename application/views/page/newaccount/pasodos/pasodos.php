<section id="PrimerosPasos" class="content">
		<div class="logo iblk"></div>
		<div class="fr iblk pst_rel fl">
			<nav id="lines">
				<a class="orange" href="#">Primeros Pasos</a>
				<a class="sky" href="#">Datos Personales</a>
				<a class="green" href="#">Confirmacion Email</a>
			</nav>
			<span class="desc"><?=!empty($this->descripcion) ? $this->descripcion : '';?></span>
		</div>
</section>
<section class="content mt20">
		<section class="panel_dos bgcolor_1 fl ml7">
			<form id="frm_datosper" action="" name="frm_datosper" method="post">
				<div class="p4 color_6">Informacion importante</div>

				<div id="foto" class="inp_foto">
					<input id="b64_foto" type="hidden" value="" />
					<input type="file" style="display:none;" />
				</div>

				<div class="fl ml20">
					<div class="p4 color_7">sexo: </div>
					<label class="input color_6"><input name="rbo_sexo" value="1" type="radio" />Hombre</label>
					<label class="input color_6"><input name="rbo_sexo" value="0" type="radio" />Mujer</label>
				</div>

				<div class="fl ml20">
					<div class="p4 color_7">fecha nacimiento:</div>
					<input id="fechanacimiento" name="fecha_nac" value="" style="width:150px;" />
				</div>

				<div class="fl ml20">
					<div class="p4 color_7">Supervisor:</div>
					<input id="supervisor" name="supervisor_id" placeholder="[Seleccione]" />
				</div>
			</form>
		</section>
</section>

<section class="allbutons">
	<button id="confirm" class="mt20 fr color_5">Confirmar</button>
	<button id="omitir" class="mt20 fr color_4">omitir</button>
</section>

<style type="text/css">
	.file_hidden{
		position: absolute;
		height: 1px;
		width: 1px;
		top:-100px;
		left:-100px;
	}
</style>

<script>
	var fechanac,supervis;
    $(document).ready(function() {

    	// DataPicker 
    	fechanac = $("#fechanacimiento").kendoDatePicker({
    		format: "yyyy-MM-dd"
    	});

        // ComboBox :: Supervisor
        supervis = $("#supervisor").kendoComboBox({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: <?=!empty($this->listarsupervisores) ? $this->listarsupervisores : [];?>,
            filter: "contains",
            suggest: true,
            index: -1
        });

        $('#basicdata').on('click',function(e){
        	e.preventDefault();
        	console.log($(this).serialize());
        });

        $('#confirm').on('click',function(e){
        	$.ajax({
        		type	: 'POST',
        		data 	: $('#frm_datosper').serialize(),
        		url 	: '../datosbasicos',
        		success : function(data){
        			try{
        				$data = $.parseJSON(data);
        				if($data[0] == 'OK'){
        					window.location.href="3";
        				}else if($data[0] == '00'){
        					console.log('ERROR '+$data[1]);
        				}
        			}catch(e){
        				console.log('ERROR INESPERADO');
        			}		
        		},
        		error 	: function(){

        		}
        	});
        });

        $('#omitir').on('click',function(e){
        	window.location.href="3";
        });
    });
</script>