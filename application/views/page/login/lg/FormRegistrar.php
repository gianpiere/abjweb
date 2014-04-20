<style type="text/css">
	#frm_login{
		width: 596px;
		height: 348px;
		background: white;
		left: 50%;
		margin: -298px;
	}

	.header_login{
		height: 68px;
		background: #f6ad2d;
		position: relative;
	}

	i.icn.close{
		float: right;	
	}

	.header_login h2{
		float: left;
		margin: 4px;
	}

	.hand{cursor: pointer;}

	.lf{float: left;}
	.lr{float: right;}
	.mrRstandar{margin-right: 20px;}
	.mrLstandar{margin-left: 20px;}
	.lgsubpanel{width: 288px; height: 256px;}
	.msg_resume{height: 30px;display: block;}
	.lgregistro{}
		.lgregistro input{ width:260px;height:26px; border: none; padding: 4px; background: #fffcd9; font-size: 18px; color: orange; margin:0px 10px 5px 10px;}
		.lgregistro button.btn_registrar{ width: 268px; height: 44px; background: #f0a31c; color: white; font-size: 20px; text-align: center; text-decoration: uppercase; margin:5px 10px 5px 10px;}
	.lglogin{}
		.lglogin input{ width:260px;height:26px; border: none; padding: 4px; background: #fffcd9; font-size: 18px; color: #ffd489; margin:0px 10px 5px 10px;}
		.lglogin button.btn_iniciarsession{ width: 268px; height: 44px; background: #f27835; color: white; font-size: 20px; text-align: center; text-decoration: uppercase; margin:5px 10px 5px 10px;}
	.loginaccess{height: 40px; width: 268px; color: white; background: #3b5998; text-align: center; text-decoration: uppercase; margin:0px 10px 5px 10px;}
	.dividir_login{height: 20px;margin: 4px auto 8px auto;text-align: center;}
</style>
<div class="panel_fancy" id="frm_login" style="display:none;">
	<section class="form_login">
		<div class="header_login">
			<h2><?=lang('Global.title.formlogin');?></h2>
			<i class="icn hand close" fancy="close">(x)</i>
		</div>
		<div class="contenido">
			<section class="lf lgsubpanel lgregistro mrRstandar">
				<div class="msg_resume"></div>
				<form id="registrar" name="registrar" action="registrar" method="post">
					<input type="text" id="name" name="name" placeholder="<?= lang('Global.input.name');?>" class="" />
					<input type="text" id="email" name="email" placeholder="<?= lang('Global.input.email');?>" class="" />
					<input type="password" id="password" name="password" placeholder="<?= lang('Global.input.pass');?>" class="" />
					<input type="password" id="passconf" name="passconf" placeholder="<?= lang('Global.input.rpass');?>" class="" />
					<button id="btn_registrar" class="btn_registrar"><?=lang('Global.button.registrar');?></button>
				</form>
			</section>
			<section class="lr lgsubpanel lglogin">
				<div class="msg_resume"></div>
				<button id="facebooklogin" class="loginaccess">Acceder con facebook</button>
				<div class="dividir_login">ó</div>
				<form id="accountacess" name="accountacess" action="accountacess" method="post">
					<input type="text" id="email" name="email" placeholder="<?= lang('Global.input.email');?>" class="" />
					<input type="password" id="password" name="password" placeholder="<?= lang('Global.input.pass');?>" class="" />
					<button id="btn_iniciarsession" class="btn_iniciarsession"><?=lang('Global.button.accountacess');?></button>
				</form>
			</section>
		</div>
	</section>
</div>