<style type="text/css">
    .panelfotoperfil{
        height: 400px;
        width: 500px;
        background: white;
        position: absolute;
        top: 50%;
        margin-top: -250px;
        left: 50%;
        margin-left: -200px;
        border:1px solid black; 
    }

    .panelfotoperfil .header{
        height: 20px;
        background: #e9b130;
        margin-bottom: 10px;
    }

    #webcam{
        width:220px; 
        height: 220px; 
        background:#646464;
        margin-left: 16px;
        float: left;
    }

    .panelfotoperfil .controls{
        width: 200px;
        height: auto;
        min-height: 220px;
        margin-right: 10px;
    }

    #cameraNames{
        width:100%;
        font-size:12px;
        height:25px;
    }

    #unicacamara{
        text-align: center;
        padding: 5px;
    }

    #capture_pic{
        width: 100%;
        height: 40px;
        text-align: center;
        color: white;
        background: #5799ca;
        padding: 5px;
        margin-top: 8px;
        border:0px;
    }

    #cerrarv_pic{
        width: 100%;
        height: 40px;
        text-align: center;
        color: white;
        background: #e9b130;
        padding: 5px;
        margin-top: 8px;
        border:0px;   
    }

    .right{float: right;}
    
    .footer_f{
        bottom: 0px;
        width: 400px;
        height: 30px;
        background: url(<?=ICONOS;?>logo30tinf.png) left center no-repeat;
    }

    #visualiazador{
        height: 370px;
        width: 500px;
        position: relative;
        background: url(<?=FONDOS;?>bg_fancy_white.png);
    }

    .cerrar_muestras{
        margin: 3px 3px 3px 3px; 
    }

    .picpreview{
        margin: 4px;
    }

    .pic128{
        width: 128px;
        height: 128px;
    }

    .pic64{
        width: 64px;
        height: 64px;
    }

    .pic32{
        width: 32px;
        height: 32px;
    }

    .pic24{
        width: 24px;
        height: 24px;
    }

    .picviewcontent{
        margin-left: 13px; 
        overflow: auto;
        float: left;
        width: 250px;
        height: 137px;
    }

    .options_picpreview{
        width: 200px;
        height: auto;
        min-height: 220px;
        margin-right: 10px;
    }

    button{
        cursor: pointer;
    }

    #aceptar_foto{
        width: 100%;
        height: 40px;
        text-align: center;
        color: white;
        background: #83b950;
        padding: 5px;
        margin-top: 8px;
        border:0px;
    }

    #capturar_nueva_foto{
        width: 100%;
        height: 40px;
        text-align: center;
        color: white;
        background: #579aca;
        padding: 5px;
        margin-top: 8px;
        border:0px;
    }

    #cerrar_foto_camara{
        width: 100%;
        height: 40px;
        text-align: center;
        color: white;
        background: #e9b230;
        padding: 5px;
        margin-top: 8px;
        border:0px;
    }
</style>

<section class="panelfotoperfil">
    <div class="header">
        <input id="txt_imgphoto" type="hidden" value="" />
    </div>
    <div id='webcam'>
        <!-- load camara -->
    </div>
    <section class="controls right">
        <select style="display:none;" onchange="changeCamera()" size="1" id="cameraNames">
            <!-- camaras -->
        </select>
        <div id="unicacamara" style="display:none;"></div>
        <div>
            <button id="capture_pic">Tomar Foto</button>
            <button id="cerrarv_pic">Cerrar Camara</button>
        </div>
    </section>
    <div id="visualiazador" style="z-index:1;display:none;">
        <div class="picviewcontent">
            <div class="left pic128 picpreview">
                <img id="imgphoto128" src="" height="128px" width="128px" style="display:block;" />    
            </div>

            <div class="left pic64 picpreview">
                <img id="imgphoto64" src="" height="64px" width="64px" style="display:block;" />    
            </div>

            <div class="left pic32 picpreview">
                <img id="imgphoto32" src="" height="32px" width="32px" style="display:block;" />    
            </div>

            <div class="left pic24 picpreview">
                <img id="imgphoto24" src="" height="24px" width="24px" style="display:block;" />    
            </div>
        </div>

        <div class="options_picpreview right">
            <button id="aceptar_foto">Usar Esta Foto</button>
            <button id="capturar_nueva_foto">Tomar Otra Foto</button>
            <button id="cerrar_foto_camara">Cerrar Camara</button>
        </div>
    </div>
    <!-- <div class="footer_f"></div> -->
</section>

<script type="text/javascript">
	var cameraApi = null;

    function mostrarcapturas(){
        $('#visualiazador').show(0);
    }

	$(document).ready(function() {

        // cerrar muestras
        $('#capturar_nueva_foto').on('click',function(){
            $('#visualiazador').fadeOut('slow',function(){
                activarCamarayTomarFoto();
            });
        });

        activarCamarayTomarFoto();
        
        
		// capturar
		/*$('#screenshot-button').click(function() {
            var result = cameraApi.save();
            if (result && result.length) {
                $('#imgphoto').attr('src', 'data:image/jpg;base64,' + result);
                $('#txt_imgphoto').val(result);
                closeModal();
                //resume camera capture
                //cameraApi.setCamera($("#cameraNames").val());
            } else {
                cameraApi.debug('error', 'Broken camera');
            }
        });*/

		// acciones secundarias
		/*$('#input-file').change(function() {
            readImage(this);
        });

        $('#upload-button').on('click', function(e) {
            $('#input-file').trigger('click');
            e.preventDefault();
        });

        $('#screenshot-stop-button, #button-close').on('click', function() {
            closeModal();
        });*/

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

    function activarCamarayTomarFoto(){
        // iniciar Api
        $("#webcam").webcam({
            swffile: "<?=JS_LIB;?>/pluginscam/sAS3Cam.swf?v=" + Math.random(),
            previewWidth: 220,
            previewHeight: 220,
            resolutionWidth: 220,
            resolutionHeight: 220,
            StageScaleMode: 'noScale',
            StageAlign: 'TL',
            noCameraFound: function() {
                this.debug('error', 'No Encontramos ningun dispositivo de camara.');
            },
            swfApiFail: function(e) {
                this.debug('error', 'Internal camera plugin error 2');
            },
            cameraDisabled: function() {
                this.debug('error', 'Please allow access to your camera');
            },
            debug: function(type, string) {
                if (type === 'error') {
                    //$(".webcam-error").html(string);
                    console.log(string);
                }
            },
            cameraEnabled: function() {
                cameraApi = this;
                if (!cameraApi.isCameraEnabled) {
                    cameraApi.isCameraEnabled = true;
                }
                var cams = cameraApi.getCameraList();
                
                if(cams.length > 1){
                    $('#cameraNames').html('');
                    $('#cameraNames').fadeIn(0);
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
                }else if(cams.length == 1){
                    console.log(cams);
                    $('#unicacamara').fadeIn(0).text(cams);
                }

                $('#capture_pic').on('click',function() {
                    var result = cameraApi.save();
                    if (result && result.length) {
                        mostrarcapturas();
                        $('#imgphoto128').attr('src', 'data:image/jpg;base64,' + result).show('slow');
                        $('#imgphoto64').attr('src', 'data:image/jpg;base64,' + result).show('slow');
                        $('#imgphoto32').attr('src', 'data:image/jpg;base64,' + result).show('slow');
                        $('#imgphoto24').attr('src', 'data:image/jpg;base64,' + result).show('slow');
                        $('#txt_imgphoto').val(result);

                        closeModal();
                        /* resume camera capture */
                        cameraApi.setCamera('0');
                    } else {
                        cameraApi.debug('error', 'Broken camera');
                    }
                });

                // quedarse con esta img.
                $('#aceptar_foto').on('click',function(){
                    var result = $('#txt_imgphoto').val();
                    $('#fotorecorte').attr('src','data:image/jpg;base64,' + result);
                    $('#cerrarv_pic').trigger('click');
                    $('#fotorecorte').fadeIn(0);
                });

                $('#cerrarv_pic,#cerrar_foto_camara').on('click',function(){
                    closeModal();
                    $('#fancy_wrap').fadeOut(500).delay(500).fadeOut(0,function(){ $('.panelfotoperfil').remove(); });
                });

            }
        });
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
                $('#imgphoto128').attr("src", e.target.result);
                $('#txt_imgphoto').val(value);
                closeModal();
            };
            FR.readAsDataURL(input.files[0]);
        }
    }
</script>