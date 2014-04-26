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
        <section class="cropfoto" id="cropfoto">
            <img id="fotorecorte" src="">
        </section>
        <section class="panel_dos bgcolor_1 fl ml7">
            <form id="frm_datosper" action="" name="frm_datosper" method="post">
                <div class="p4 color_6">Informacion importante</div>

                <div id="foto" class="inp_foto">
                    <input id="b64_foto" type="hidden" value="" />
                    <i class="iconfotofile"><input type="file" id="slfile" /></i>
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

        $('#slfile').on('change',function(){
            alert('OK');
        });


        // cargar foto por drag and drop
        // foto

        function handleFileSelect(evt) { // $.message_loading(1);
            evt.stopPropagation();
            evt.preventDefault();

            var files = evt.dataTransfer.files; // FileList object.
            // files.length // numero de Fotos agregadas.
            // files is a FileList of File objects. List some properties.
            var output = [];
            for (var i = 0, f; f = files[i]; i++) { 
              output.push('<li><strong>', escape(f.name), '</strong> (', f.type || 'n/a', ') - ',
                          f.size, ' bytes, last modified: ',
                          f.lastModifiedDate.toLocaleDateString(), '</li>');
            }
            // document.getElementById('list').innerHTML = '<ul class="hiden_files" style="display:none;">' + output.join('') + '</ul>';


            // Loop through the FileList and render image files as thumbnails.
            for (var i = 0, f; f = files[i]; i++) {
                /*if(i == 9){
                    console.log(HiddenListArr);
                }*/

              // Only process image files.
              if (!f.type.match('image.*')) {
                continue;
              }

              var reader = new FileReader();

              // Closure to capture the file information.
              reader.onload = (function(theFile) {
                return function(e) {
                  // Render thumbnail.
                
                  var div = document.createElement('div');
                  div.setAttribute("class", "miniatura_img");
                  // <div class="miniatura_img">
                  // HiddenListArr.push([theFile.name,e.target.result,theFile.size,theFile]);

                    $('#fotorecorte').attr('src',
                        e.target.result
                    );

                  console.log([theFile.name,e.target.result,theFile.size,theFile]);

                  div.innerHTML = ['<img class="thumb" src="', e.target.result,
                                    '" title="', escape(theFile.name), '"/><div class="info"><div class="datos"><div class="delete_pic">eliminar</div><div class="name">'+theFile.name+' | size: '+theFile.size+'</div></div></div>'].join('');
                  // document.getElementById('list').insertBefore(div, null);
                  $('#list').append(div);

                  // $.message_loading(0);
                  $('.change_files_pics').text('');
                };
              })(f);

               // Read in the image file as a data URL.
              reader.readAsDataURL(f);
                // $.message_loading(0);
            }

        }
        
        function handleDragOver(evt) {
            $('.change_files_pics').text('Cargando Imagenes...');
            evt.stopPropagation();
            evt.preventDefault();
            evt.dataTransfer.dropEffect = 'copy'; // Explicitly show this is a copy.
        }

        function puente(event){
            // puente handleFileSelect;
            // $.message_loading(1,handleFileSelect(event));
            console.log(handleFileSelect(event));
            return false;
        }

        function mifunc(){
            $('.change_files_pics').text('');
        }

        // Setup the dnd listeners.
          var dropZone = document.getElementById('foto');
          dropZone.addEventListener('dragover', handleDragOver, false);
          dropZone.addEventListener('dragleave', mifunc, false);

          dropZone.addEventListener('drop', puente, false);
        // -> desde aqui empieza el codigo del plugin 


    });
</script>