var $datasource = 
[
	{
		title		: 'slider 1 (UNO)',
		description : 'Prueba 1(uno) <br/> ejemploto 1 description 1',
		img 		: 'foto1.jpg',
		button		: ['ACCEDER','#uno1']
	},
	{
		title		: 'slider 2 (DOS)',
		description : 'Prueba 2(dos) <br/> ejemploto 2 description 2',
		img 		: 'foto2.jpg',
		button		: ['ENTRAR','#dos2']
	},
	{
		title		: 'slider 3 (TRES)',
		description : 'Prueba 3(tres) <br/> ejemploto 3 description 3',
		img 		: 'foto3.jpg',
		button		: ['VER','#tres3']
	}
]

$(document).on('ready',function(){
	$('.sliderpanel').webslider({
		init 		: 1,
		DataSource 	: $datasource
	});
});