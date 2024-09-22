//desenhando o gold
var _n = 0;
var _alt = 20;
draw_set_halign(0);
var _str = convert_num(global.gold);
draw_text(20, _alt * _n++, _str);
draw_set_halign(-1);


//eu quero saber quanto dinheiro ao todo eu faço por segundo
var _dinheiro_seg = 0;

//descobrindo
//rodando pelos produtos
for (var i = 0; i < array_length(global.produtos); i++) {
	if (global.produtos[i] != 0) {
		//pegando as info dos produtos
		var _atual = global.produtos[i];
		with (_atual) {//with consegue pegar o _atual para todos
			if (tenho_manager && comprado) {
				_dinheiro_seg += (lucro / tempo);
			}
		}

	}	
}
global.gold_seg = _dinheiro_seg;
var _str = convert_num(global.gold_seg);
draw_text(20, _alt * _n++, _str);