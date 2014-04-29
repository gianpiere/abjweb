<script type="text/javascript" src="<?=JS_LIB;?>pluginscam/jquery.webcam.as3.js"></script>



<!-- -->
<div class="box color_light">
    <div class="modal-header">
        <button id="button-close" class="close" aria-hidden="true" type="button">×</button>
        <h4> <i class="icon-book"></i>
            <span>Tomar Foto</span> 
        </h4>
    </div>
    <div id='div-content' class="content">
        <div class="container-fluid">
            <div class="form-row control-group row-fluid">
                <label for="normal-field" class="control-label span2">Camaras</label>
                <div class="controls span4">
                    <select id="cameraNames" size="1" onChange="changeCamera()" style="width:245px;font-size:10px;height:25px;">
                    </select>
                </div>
            </div>
            <div class="form-row control-group row-fluid">
                <div id='webcam' style="width:100%; height: 100%">


                </div> 
            </div>
            <!--<button class="btn btn-secondary color_18" id="upload-button" > </button>-->
            <input type="file" id="input-file" accept="image/jpg" style="display: none">
            <p style="margin-top: 10px">
                <button  class="btn btn-secondary color_18" id="upload-button">Subir foto</button> 
                <button  class="btn btn-secondary color_18" id="screenshot-button">Tomar foto</button> 
                <button class="btn btn-secondary color_18" id="screenshot-stop-button">Cerrar</button></p>
            <p></p>
            <p></p>
            <div id="nota" style="color:red;">
                <p>
                    <b><h4> Nota (subir fotos): </h4></b>    
                </p>
                <p>
                    Tamaño máximo de la imagen 100 KB          
                </p>
                <p>
                    Formato imagen .JPG           
                </p>
                <p>
                    Resolucion 320x240 píxeles
                </p>            
            </div>

        </div>
    </div>
</div>
<!-- -->

<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" class="modal hide fade" id="dlgPhoto" style="display: none;">

<div class="box color_light">
    <div class="modal-header">
        <button type="button" aria-hidden="true" class="close" id="button-close">×</button>
        <h4> <i class="icon-book"></i>
            <span>Tomar Foto</span> 
        </h4>
    </div>
    <div class="content" id="div-content">
        <div class="container-fluid">
            <div class="form-row control-group row-fluid">
                <label class="control-label span2" for="normal-field">Camaras</label>
                <div class="controls span4">
                    <select style="width:245px;font-size:10px;height:25px;" onchange="changeCamera()" size="1" id="cameraNames">
                    <option value="0">HP HD Webcam</option><option value="0">HP HD Webcam</option></select>
                </div>
            </div>
            <div class="form-row control-group row-fluid">
                <div style="width:100%; height: 100%" id="webcam"></div> 
            </div>
            <!--<button class="btn btn-secondary color_18" id="upload-button" > </button>-->
            <input type="file" style="display: none" accept="image/jpg" id="input-file">
            <p style="margin-top: 10px">
                <button id="upload-button" class="btn btn-secondary color_18">Subir foto</button> 
                <button id="screenshot-button" class="btn btn-secondary color_18">Tomar foto</button> 
                <button id="screenshot-stop-button" class="btn btn-secondary color_18">Cerrar</button></p>
            <p></p>
            <p></p>
            <div style="color:red;" id="nota">
                <p>
                    <b></b></p><h4><b> Nota (subir fotos): </b></h4>    
                <p></p>
                <p>
                    Tamaño máximo de la imagen 100 KB          
                </p>
                <p>
                    Formato imagen .JPG           
                </p>
                <p>
                    Resolucion 320x240 píxeles
                </p>            
            </div>

        </div>
    </div>
</div>



</div>
<!-- -->
<div class="foto" id="divFoto">
	<img width="120px" height="120px" src="" id="imgphoto">
</div>
<!-- -->





<script type="text/javascript">
	
	var cameraApi = null;
	$(document).ready(function() {

		// iniciar Api
		$("#webcam").webcam({
            swffile: "<?=JS_LIB;?>/pluginscam/sAS3Cam.swf?v=" + Math.random(),
            previewWidth: 320,
            previewHeight: 240,
            resolutionWidth: 320,
            resolutionHeight: 240,
            StageScaleMode: 'noScale',
            StageAlign: 'TL',
            noCameraFound: function() {
                this.debug('error', 'Web camera is not available');
            },
            swfApiFail: function(e) {
                this.debug('error', 'Internal camera plugin error');
            },
            cameraDisabled: function() {
                this.debug('error', 'Please allow access to your camera');
            },
            debug: function(type, string) {
                if (type === 'error') {
                    //$(".webcam-error").html(string);
                    // console.log(string);
                }
            },
            cameraEnabled: function() {
                cameraApi = this;
                if (!cameraApi.isCameraEnabled) {
                    cameraApi.isCameraEnabled = true;
                    // return;
                }
                var cams = cameraApi.getCameraList();
                //console.log(cams);
                $.each(cams, function(index, text) {
                    //console.log(text);
                    $('#cameraNames').append($('<option></option>').val(index).html(text))
                });
                cameraApi.setCamera('0');

                $("#cameraNames").change(function() {
                    var success = cameraApi.setCamera($(this).val());
                    if (!success) {
                        cameraApi.debug('error', 'Unable to select camera');
                    } else {
                        cameraApi.debug('notice', 'Camera changed');
                    }
                });

                $('#screenshot-button').click(function() {
                    var result = cameraApi.save();
                    if (result && result.length) {
                        $('#imgphoto').attr('src', 'data:image/jpg;base64,' + result);
                        $('#txt_imgphoto').val(result);
                        closeModal();
                        /* resume camera capture */
                        //cameraApi.setCamera($("#cameraNames").val());
                    } else {
                        cameraApi.debug('error', 'Broken camera');
                    }
                });

            }
        });

		// capturar
		$('#screenshot-button').click(function() {
            var result = cameraApi.save();
            if (result && result.length) {
                $('#imgphoto').attr('src', 'data:image/jpg;base64,' + result);
                $('#txt_imgphoto').val(result);
                closeModal();
                /* resume camera capture */
                //cameraApi.setCamera($("#cameraNames").val());
            } else {
                cameraApi.debug('error', 'Broken camera');
            }
        });

		// acciones secundarias
		$('#input-file').change(function() {
            readImage(this);
        });

        $('#upload-button').on('click', function(e) {
            $('#input-file').trigger('click');
            e.preventDefault();
        });

        $('#screenshot-stop-button, #button-close').on('click', function() {
            closeModal();
        });

	});

	// funciones fuera del REady
	function closeModal() {
        $('#webcam').html('');
        $('#submit').removeAttr('disabled');
        $('#close').removeAttr('disabled');
        // $('#dlgPhoto').modal('hide');
        if (cameraApi !== null)
            cameraApi.isCameraEnabled = false;
    }

    function readImage(input) {
        if (input.files && input.files[0]) {
            var fileup = input.files[0].name;
            var ext = fileup.substring(fileup.lastIndexOf(".") + 1, fileup.length).toLowerCase();
            if (ext !== 'jpg') {
                //jAlert('Solo se aceptan imagenes con el formato JPG', tituloInformacion);
                alert('Solo se aceptan imagenes con el formato JPG');
                return;
            }
            // solo archivos menores a un 1mb
            console.log(fileup.size);
            if (fileup.size > 102400) {
                // jAlert('Solo se permiten imagenes de maxímo 100 KB', tituloInformacion);
                alert('Solo se permiten imagenes de maxímo 100 KB');
                return;
            }
            var FR = new FileReader();
            FR.onload = function(e) {
                console.log(e.total);
                if(e.total > 102400){
                    // jAlert('Solo se permiten imagenes de maxímo 100 KB', tituloInformacion);
                    alert('Solo se permiten imagenes de maxímo 100 KB');
                    return;
                }
                var value = e.target.result.replace("data:image/jpeg;base64,", "");
                $('#imgphoto').attr("src", e.target.result);
                $('#txt_imgphoto').val(value);
                closeModal();
            };
            FR.readAsDataURL(input.files[0]);
        }
    }
</script>