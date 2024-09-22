atualiza_tempo();

//deixando o jogo mais rápido 
if (keyboard_check(vk_space)) {
	global.game_spd = 1000;
} else {
	global.game_spd = 1;
}

if (keyboard_check(ord("S"))) {
	save_game();
}

if (keyboard_check(ord("Z"))) {
	global.gold += 10000;
}

gerencia_produtos();
gerencia_managers();