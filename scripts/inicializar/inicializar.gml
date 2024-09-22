//configuradno o tempo do jogo
//definindo os frames por segund
#macro FRAMES 160
game_set_speed(FRAMES, gamespeed_fps);

//usando o deltatime para ajustar o tempo do jogo
//velocidade do jogo
global.game_spd = 1;
//definindo o frame rate do jogo
global.framerate = global.game_spd / FRAMES;
//Identificando a duração de um segundo no joof
global.gamesegundos = 0;

//função para atualizar o tempo do jogo
function atualiza_tempo() {
	//pegando o tempo em segundos 
	global.gamesegundos = delta_time / 1000000;
	global.framerate = global.gamesegundos * global.game_spd;
}

global.exibe_manager = false;

//variaveis de dinehiro
global.gold = 4;
global.gold_seg = 0;

//info dos manager
global.managers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

//lista dos produtos
global.produtos = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
global.produtos_info = array_create(10, 0);

global.idioma = 0;
