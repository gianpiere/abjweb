(function($){
	$.fn.extend({
		fancyblack : function(option = {}){ if($(this).attr('disabled')){return false;} option = (option || {}); 
			var o,REQUEST,$btn = $(this),defaults = {
				url : ''
			}; o = $.extend({},defaults,option);

			return this.each(function(){
				$(this).click(function(){ $this = $('html');	

					$btn.attr('disabled','disabled'); // desactivamos el boton.
					
					$this
						.prepend('<div id="fancy_wrap" style="display:none;"></div>')
						.css({overflow:'hidden'})
					;

					var Hdl = {
						true_close 	: function(){
							$('#fancy_wrap').data('IsCloseActive','on');
						},
						false_close : function(){
							$('#fancy_wrap').data('IsCloseActive','off');
						},
						close_active: function(){
							var status_close = $('#fancy_wrap').data('IsCloseActive');
							if(status_close == 'on'){ $this = $(this);
								$('.panel_fancy').animate({top:'-=100%'},'slow','easeInOutBack',function(){$this.fadeOut('fast',function(){$this.remove();}) }).fadeOut("fast");
							}else{}
						},
						escaction 	: function(e){

						},
						loadUrl 	: function(){
							$('#fancy_wrap').fadeIn("slow");
							$('#fancy_wrap').append("<i class='login'></i>");
							$('panel_fancy').css({display:'none'});
							$.ajax({
								type 		: 'POST',
								data 		: '',
								url 		: o.url,
								success 	: function(PAGEVIEW){
									REQUEST = PAGEVIEW;
									$('#fancy_wrap')
										.html(REQUEST)
										.css({position:'fixed'})
										.data('IsCloseActive','on')
										.dblclick(Hdl.close_active)
										.on('keypress',Hdl.escaction)
									;
								},
								error 		: function(){
									return false;
								},
								complete	: function(){
									$('.panel_fancy')
										.on('mouseleave',Hdl.true_close)
										.on('mouseenter',Hdl.false_close)
										.css({position:'absolute',overflow:'auto'})
									;

									$("i[fancy=close]").off('click').on('click',Hdl.xclose);
								}
							})
						},
						xclose : function(){ $this = $('#fancy_wrap');
							$('.panel_fancy').animate({top:'-=100%'},'slow','easeInOutBack',function(){$this.fadeOut('fast',function(){$this.remove();}) }).fadeOut("fast");
						}

					}

					Hdl.loadUrl();
					$btn.removeAttr('disabled'); // desactivamos el boton.

				});
			});
		}
	});
})(jQuery);