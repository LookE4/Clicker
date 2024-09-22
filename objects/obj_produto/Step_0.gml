if (comprado) {
	if (fazer) {
		//aumentando o timer
		timer += global.framerate;
	
		//enchi a barra
		if (timer > tempo) {
			acao();
		}
	}
}
//checando se o meu mouse está pro cima do manager
mouse_manager = point_in_rectangle(mouse_x, mouse_y, x + sprite_width, y - 22, x + sprite_width + 44, y + 22);

// checandno de a pessao cliccou nele
var _mouse_sobre = position_meeting(mouse_x - meu_x, mouse_y - meu_y, id);
var _mouse_click = mouse_check_button_pressed(mb_left);

if (_mouse_sobre) {
	//se o mouse esta por cima de mim então eu fico com a borda
	image_index = 1;
	
	infos = true;
	if ( _mouse_click) {
		fazer = true;
	}
	//chencado se o mouse esta na ciaxa de comprar
	var _x1 = x + 52;
	var _y1 = y - 2;
	var _x2 = _x1 + 42;
	var _y2 = _y1 + 16;
	var _mouse_caixa = point_in_rectangle(mouse_x - meu_x, mouse_y - meu_y, _x1, _y1, _x2, _y2);
	efeito_comprar = _mouse_caixa;
	if (_mouse_caixa) {
		//chencado se a pessoa cliclou
		if (_mouse_click) {
			//chencando se ela tem o dinheiro
			if (global.gold >= custo) {
				comprar();
			}
		}
	}
} else {
	infos = false;
	efeito_comprar = false;
	image_index = 0;
}