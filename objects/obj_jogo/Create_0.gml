alarm[0] = (game_get_speed(gamespeed_fps) * 60) * 2;

//carregando meus dados
//carrega_dados();

//cirei o objeto jogo carrego as info do jogo
//load_game();

//lista dos produtos
produtos = [];
managers = [];

//dadso da minha surface dos produtos
surf_prod = noone;
prod_w = 860;
prod_h = 500;
prod_x = 48;
prod_y = 48;

//dadso da minha surface dos managers
surf_mana = noone;
mana_w = 460;
mana_h = 1;
mana_h_base = 500;
mana_x = 880;
mana_y = 48;

base_y = 80;
produtos_y = 0 + base_y;
vel_scroll = 5;

//criando os produtos dentro da lista dos produtos
cria_produtos = function(_qnt = 1) {
	for (var i = 0; i < _qnt; i++) {
		//struct com os meus dados que eu estou pegando
		var _struct = global.struct_produtos[i];
		

		
		produtos[i] = instance_create_layer(0, 0, layer, obj_produto, _struct);
		
		//passando as info dos produtos para eles
		//se eu tenho as info ai eu fasso ese krl
		if (global.produtos_info[i] != 0 ) {
			// atualizando o manager
			global.managers[i] = global.produtos_info[i].tenho_manager;
				with (produtos[i]) {
					level = global.produtos_info[i].level;
					comprado = global.produtos_info[i].comprado;
					tenho_manager = global.produtos_info[i].tenho_manager;
				
					//ataulizando as info
					ajusta_infos();
				}
		}
	}
}

cria_managers = function() {
	//1 manager para cada produto
	for (var i = 0; i < array_length(produtos); i++) {
		var _meu_produto = {
			indice : i
		};
		 managers[i] = instance_create_layer(900, 100 + i * 100, layer, obj_manager, _meu_produto);
		 
		 managers[i].custo = global.produtos[i].custo_base * 10;
		 managers[i].indice = i;
	}
}

rolagem_produtos = function() {
	if (keyboard_check(vk_up)) {
		produtos_y += vel_scroll;
	} else if (keyboard_check(vk_down)) {
		produtos_y -= vel_scroll;
	}
	
	//descobrindo o valor maximo da rolagem para cima
	var _qtd = array_length(produtos);
	var _max = (96 * _qtd) + (20 * _qtd) + 20 - prod_h;
	
	//limitando o scroll dos produtos
	produtos_y = clamp(produtos_y, -_max, base_y);
}

rolagem = function(_val = 10, _x = 0, _y = 0, _w = 0, _h = 0) {
	var _qtd = 0;
	var _fazer = false;
	
	if (_w != 0) { 
		_fazer = point_in_rectangle(mouse_x, mouse_y, _x, _y, _x + _w, _y + _h + 90);	
	} 
	
	if (_fazer) {
		//rolando a bolinha do mouse
		if (mouse_wheel_down()) {
			_qtd = -_val;
		}
	
		if (mouse_wheel_up()) {
			_qtd = +_val;
		}	
	}
	
	return _qtd;
}

gerencia_produtos = function() {
	static _meu_y = 0;
	var _alt = sprite_get_height(spr_produto);
	var _larg = sprite_get_width(spr_produto);
	var _marg = 20;
	//checando se o mouse está em cima de mim
	_meu_y += rolagem(30, prod_x, prod_y, prod_w/2, prod_h);
	
	//limitando meu y
	var _qtd = array_length(produtos);
	var _max = (_alt * _qtd )+ (_marg * _qtd) + _marg - room_height;
	_meu_y = clamp(_meu_y, -_max, 0);
	
	for (var i = 0; i < array_length(produtos); i++) {
		var _x = 24;
		var _y = _meu_y + _marg + ((i * _alt) + (i * _marg));
		
		with (produtos[i]) {
			x = _x;
			y = _y + sprite_height / 2;
		}
	}
}

gerencia_managers = function() {
	static _meu_y = 0;
	var _alt = sprite_get_height(spr_manager);
	var _larg = sprite_get_width(spr_manager);
	var _marg = 20;
	_meu_y += rolagem(30, mana_x, mana_y, mana_w, mana_h);
	
	//limitando meu y
	var _qtd = array_length(managers);
	var _max = (_alt * _qtd )+ (_marg * _qtd) + _marg - room_height;
	_meu_y = clamp(_meu_y, -_max, 0);
	
	for (var i = 0; i < _qtd; i++) {
		var _x = 0;
		var _y = _meu_y + _marg + ((i * _alt) + (i * _marg));
		
		with (managers[i]) {
			x = _x;
			y = _y + sprite_height / 2;
		}
	}
}

//criando a sufrace dos managers
desenha_managers = function () {
	//mudando o tamanho da surface com base na global.exibe_manager
	if (global.exibe_manager) {
		mana_h = lerp(mana_h, mana_h_base, .1)
	} else {
		mana_h = lerp(mana_h, 1, .1)
	}
	
	if (surface_exists(surf_mana)) {
		surface_set_target(surf_mana);
		draw_clear_alpha(c_black, 0);
		draw_rectangle_color(0, 0, mana_w, mana_h, c_black, c_black, c_black, c_black, 0);
		
		if(mana_h > 3) {
			with(obj_manager) {
				desenhar_manager();
				meu_x = other.mana_x;
				meu_y = other.mana_y;
			}
		}
		
		surface_reset_target();

		draw_surface(surf_mana, mana_x, mana_y);
		
		surface_resize(surf_mana, mana_w, mana_h)
	} else {
		surf_mana = surface_create(mana_w, mana_h);
	}
	
}

//criando a sufrace dos produtos
desenha_produtos = function () {
	//cirando uma surface para desenhar produtos nela
	//checando se a surface existe
	if (surface_exists(surf_prod)) {
		//fazer coisas na surface
		//configruando a minha surface
		surface_set_target(surf_prod);
		draw_clear_alpha(c_black, 0);
		
		//draw_rectangle_color(0, 0, prod_w, prod_h, c_black, c_black, c_black, c_black, false);
		
		//desenhando o produto
		with(obj_produto) {
			desenha_produto();
			meu_x = other.prod_x;
			meu_y = other.prod_y;
		}
		
		//resetando a surface
		surface_reset_target();
		
		//desenhando a surface
		draw_surface(surf_prod, prod_x, prod_y);
	} else {//se não existe
		//criar ela
		surf_prod = surface_create(prod_w, prod_h);
	}
	
}

//cria a quantidade de produtos que tem na minha struct
//cria_produtos(array_length(global.struct_produtos));
cria_managers();