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
<section class="content">
	<div class="title p7 fl mt20" >Tienes algun curso que hayas llevado?, dinos cual es para tenerlo en tu lista de cursos completados</div>
	
	<input id="curso" placeholder="[Seleccione]" />
	<button id="addcurso">Agregar</button>
		<button id="confirm" class="mt20 fr color_5">Confirmar</button>
		<button id="omitir" class="mt20 fr color_4">omitir</button>
	<section class="panel_dos mt20 fl">
		<ul id="cursos_lst">
			
		</ul>
	</section>

</section>

<script>
    $(document).ready(function() {
        // ComboBox Curso
        $("#curso").kendoComboBox({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: <?= !empty($this->listadecursos) ? $this->listadecursos : [];?>,
            filter: "contains",
            suggest: true,
            index: -1
        });

        $('#addcurso').on('click',function(){
        	var curso = $("#curso").data("kendoComboBox");
        	$curso = curso.text().split(',')[0];
        	$mask_html = '';
        	$mask_html += '<li class="curso" data-result="grabando">';
        	$mask_html += 	'<p class="color_5">'+$curso+'</p>';
        	$mask_html += 	'<strong class="color_3">cargando..</strong>';
        	$mask_html += 	'<a data-id="pendiente" href="#delete" class="color_1">eliminar</a>';
        	$mask_html += '</li>';

        	$('ul#cursos_lst').prepend($mask_html);
        });

        // delete item
        $('#cursos_lst').delegate('a[href="#delete"]','click',function(e){ $this = $(this);
        	e.preventDefault();
        	$this.parent().fadeOut('slow');
        	console.log('delete on');
        });

        // omitir
        $('#omitir').on('click',function(){
        	window.location.href="../LandingPage";
        });

        // confirmar
        $('#confirm').on('click',function(){
        	$.ajax({
        		type 	: 'POST',
        		data 	: 'paso=finish&token='+$('#token').val(),
        		url		: '../paso',
        		success : function(data){
        			window.location.href="../LandingPage";
        		},
        		error 	: function(){

        		}
        	})
        });

        // agregar curso
        $('#addcurso').on('click',function(){
        	var $curso = $("#curso").data("kendoComboBox");
        	$.ajax({
        		type	: 'POST',
        		data 	: 'cursoid='+$curso.value(),
        		url 	: '../addcursoprevio',
        		success : function(data){

        		},
        		error 	: function(){

        		}
        	})
        });

    });
</script>