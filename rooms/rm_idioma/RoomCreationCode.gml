//checando se por ventura o jogo ja tem save
if (load_game()) {// retornou true
	room_goto_next();
	carrega_dados(global.idioma);
}