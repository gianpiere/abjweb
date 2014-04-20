<section id="PrimerosPasos" class="content">
		<div class="logo iblk"></div>
		<div class="fr iblk pst_rel fl">
			<nav id="lines">
				<a class="orange" href="#">Primeros Pasos</a>
				<a class="sky" href="#">Datos Personales</a>
				<a class="green" href="#">Confirmacion Email</a>
			</nav>
			<span class="desc">description</span>
		</div>
</section>
<section class="content">
		<section id="ConfirmacionEmail" class="panel_uno leftgreen_9 color_4 fl">
			Hola, Gianpiere, <br/>
			Hemos enviado un Email a tu cuenta de correo <span class="color_1">gianpiere@live.com</span>, con un codigo que confirmara tu cuenta, revisa tu bandeja de entrada.
			<br/><br/>
			en caso de no econtrarlo, revisa tu carpeta de correo span.
			<hr class="linea_verde" />
			<label class="color_2 b">gianpiere@live.com</label>
			<a href="#cambiar" class="color_3 ml10">cambiar</a>
			<a class="color_1 fr" href="#reenviar">reenviar correo</a>
			<div class="codigo_txt" align="center">
				<input id="codigo" width="70px"  class="inp_codigo number" placeholder="CODIGO"></input>
			</div>
			<a class="fr mt30 color_5" href="">confirmar</a>
			<a class="fr mt30 mr10 color_4" href="">omitir</a>
		</section>
		<section class="panel_uno bgcolor_1 fl ml7">
			<div class="p4 color_6">Informacion importante</div>

			<div class="inp_foto"></div>

			<div class="p4 color_7">sexo:</div>
			<label class="input color_6"><input id="rbo_sexo" name="rbo_sexo" class="rbo_sexo" value="1" type="radio" />Hombre</label>
			<label class="input color_6"><input id="rbo_sexo" name="rbo_sexo" class="rbo_sexo" value="0" type="radio" />Mujer</label>
			<div class="p4 color_7">fecha nacimiento:</div>
			<input id="fechanacimiento" value="10/10/2011" style="width:150px;" />
			<div class="p4 color_7">Supervisor:</div>
			<input id="supervisor" placeholder="[Seleccione]" />

		</section>

		<div class="title p7 fl mt20" >Tienes algun curso que hayas llevado?, dinos cual es para tenerlo en tu lista de cursos completados</div>
		<section class="panel_dos mt20 fl">
			<ul>
				<ol class="addcurso">
					Curso:
					<input id="curso" placeholder="[Seleccione]" />
					<button class="btnadd">agregar</button>
				</ol>
				<li class="curso">
					<p class="color_5">Primeros Pasos por la biblia</p>
					<strong class="color_3">I nivel</strong>
					<a data-id="1" href="#delete" class="color_1">eliminar</a>
				</li>
			</ul>
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

    });
</script>