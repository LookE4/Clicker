//meu level
level = 0;

nome = global.struct_produtos[indice].nome;
descricao = global.struct_produtos[indice].descricao;

//mais info dos produtos
timer = 0;

//variaveis para arrumar o click na surface, antes tava pegando o da sala, mas agora com surface ele não funciona
meu_x = 0;
meu_y = 0;

//definindo se deve fazer
fazer = false;

tenho_manager = false;
//meus custos
custo = custo_base;

comprado = false;
efeito_comprar = false;

//lucros
lucro = lucro_base

//me inserindo na lista de produtos 
global.produtos[indice] = id;

incremento = 1.07;

comprar = function() {
	global.gold -= custo; //tirei o dinheiro
	comprado = true;
	
	var _custo_atual = floor(custo_base * (power(incremento, level)));
	//aumentando o custo dele
	custo += _custo_atual;
	//ajustando o lucro
	level++;
	//lucro vai ser com base no level e lucro base
	lucro = lucro_base * level;
}

ajusta_infos = function() {
	lucro = lucro_base * level;
	custo = floor(custo_base * (power(incremento, level)));
	
	//atualizando o comprado
	if (comprado) {
		fazer = true;
	}
}

acao = function() {
		timer = 0;
		fazer = tenho_manager;
		//dando o lucro
		global.gold += lucro;
}

//desenhando o prduto
desenha_produto = function() {
	//desenhando o produto na minha esquerda
	//me desenhando
	draw_self();

	draw_set_font(fnt_texto)
	//desenhando o item na minha esquerda
	//draw_sprite(spr_item, indice, x, y - 16);
	
	//desenhando a minha sprite
	draw_sprite(spr_doces, indice, x + 8, y - 18);
	draw_set_valign(1);
	draw_set_halign(1);
	
	draw_set_color(c_black)
	//desenhando o level
	draw_text_transformed(x + 22, y + 12, level, .5, .5, 0);
	
	//alinhado o texto


	//desenhando o level do item
	//fazendo uma elipse atras do texto
	var _x = x;
	var _y = y + 24;
	//draw_ellipse_color(_x - 24, _y - 16, _x + 24, _y + 16, c_dkgray, c_dkgray, false)
	//gpu_set_colorwriteenable(1, 1, 1, 0);
	//draw_text(_x, _y, level);
	//gpu_set_colorwriteenable(1, 1, 1, 1);

	//desenhando a barra de progresso
	var _x1 = x + 53;
	var _y1 = y - 13;
	var _larg = 90;
	var _x2 = _x1 +_larg;
	var _y2 = _y1 + sprite_height / 4;
	//desenhando as bordas da barra
	//draw_rectangle_color(_x1 - 1, _y1 - 1, _x2 + 1, _y2 + 1, c_black, c_black, c_black, c_black, false);
	//desenhando o fundo da barra
	//draw_rectangle_color(_x1, _y1, _x2, _y2, c_gray, c_gray, c_gray, c_gray, false);
	//desenhando o progresso da barra
	var _progresso = (timer / tempo) * _larg;
	
	//desenhando a barra de progresso com sprite
	draw_sprite(spr_barra_temp, 1, _x1, _y1);
	
	//desenhanod o progresso
	draw_sprite_part(spr_barra_temp, 0, 0, 0, _progresso, 9, _x1, _y1);
	
	//draw_rectangle_color(_x1, _y1, _x1 + _progresso, _y2, c_green, c_green, c_green, c_green, false);
	//desenhando o quanto eu rendo
	//ajustando o alinhamento
	draw_set_halign(2);
	var _str = convert_num(lucro);
	//gpu_set_colorwriteenable(1, 1, 1, 0);
	//draw_text(_x2 - 4, _y1 + sprite_height / 8, _str);
	//voltando o alinhamento apra o centro
	draw_set_halign(1);
	//desenhando o meu preço
	//desenhando o quadrado do preço
	_x1 = x + 54;
	_y1 = y - 2;
	var _larg = sprite_width / 2;
	_x2 = _x1 + _larg;
	_y2 = _y1 + 32;
	//definindo a cor com base na possibilidade de me comprar
	var _cor = global.gold >= custo ? c_green : c_gray;
	//se eu tenho dinheiro para comrar entao e a imagem 1
	var _imagem = global.gold >= custo ? efeito_comprar + 1 : 0;
	
	var _str = convert_num(custo);
	
	//botao de comprar
	draw_sprite(spr_botao7, _imagem, _x1, _y1)
	
	//desenhando o custo
	draw_text_transformed(x + 76, y + 6, _str, .4, .4, 0);
	
	//desenhando uma borda se o mouse estiver em cima de mim
	if (efeito_comprar) {
		//draw_rectangle_color(_x1 - 1, _y1 - 1, _x2 + 1, _y2 + 1, c_yellow, c_yellow, c_yellow, c_yellow, false);
	}
	//draw_rectangle_color(_x1, _y1, _x2, _y2, _cor, _cor, _cor, _cor, false);
	//draw_text_transformed(_x1 + _larg / 2, _y1 + 16,_str, 1, 1, 0);
	
	//desenhando o espaco do manager
	draw_sprite(spr_caixa_info2, 0, x + sprite_width, y);
	
	//desenhando o tempo que leva para lucrar
	//descobrindo quantos segundo ele leva 
	var _s = round((tempo - timer) % 60);
	var _m = ((tempo - timer) div 60) div 60;
	var _h = ((tempo - timer) div 60) div 60;
	draw_set_halign(2);
	//definindo a exibição do texto bonitinha
	var _seg = _s > 9 ? _s : "0" + string(_s);
	var _min = _m > 9 ? _m : "0" + string(_m); 
	var _hr = _h > 9 ? _h : "0" + string(_h);
	_str = string("{0}:{1}:{2}", _hr, _min, _seg);
	//draw_text(x + sprite_width -  24, _y1 + 16, string("{0}:{1}:{2}", _hr, _min, _seg));
	//gpu_set_colorwriteenable(1, 1, 1, 1);
	
	//desenhando o tempo
	draw_text_transformed(x + 143, y + 6, _str, .6, .6, 0);

	draw_set_halign(1);

	//resetando o alinhamento do texto
	draw_set_valign(-1);
	draw_set_halign(-1);
	
	if (efeito_comprar) {
		//exibe_info();
	}

	draw_set_font(fnt_texto)
}

//exibindo as info do produto
exibe_info = function() {
	var _x1 = x + sprite_width + 12;
	var _y1 =  y - sprite_height / 2;
	var _marg = 10;
	
	//desenhando a minha caixinha
	draw_sprite_stretched(spr_info, 0, _x1, _y1, sprite_width, sprite_height)
	//nome
	//gpu_set_colorwriteenable(1, 1, 1, 0);
	//draw_text(_x1 + _marg, _y1 + _marg, nome);
	
	//desc
	draw_text_ext(_x1 + _marg, _y1 + 30 + _marg, descricao, 20, sprite_width - _marg * 2);
	//gpu_set_colorwriteenable(1, 1, 1, 1);
}