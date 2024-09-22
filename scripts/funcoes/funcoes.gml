function convert_num(_num) {
	//string arrumadinha
	var _simbolo = global.idioma;
	var _custo2 = _num;
	var _valores = ["", "K", "M", "B", "Q"];
	var _i = 0;
	//sempre qeu o valor fr maior do que mil, eu tiro 3 zeros dele
	while (_custo2 > 100) {
		_custo2 /= 1000;
		
		//sempre que eu rodei isso eu subo para a próxima casa
		_i++;
	}
	
	var _str2 = global.idioma == 0 ? "R$ " + string_format(_custo2, 0, 2)+ _valores[_i] : "$ " + string_format(_custo2, 0, 2)+ _valores[_i];
	return _str2;
}

//salvando o jogo
function save_game() {
	//abrindo o arquivo
	var _file = file_text_open_write("save.json");
	
	//sabendo quais produtos já foram comprados
	//criando um vetor para saber quantos produtos ao todo tenho

	var _produtos = array_create(array_length(global.produtos), 0);
	
	for (var i = 0; i < array_length(_produtos); i++) {
		if (instance_exists(global.produtos[i])) {
			var _estrutura = {
				comprado : global.produtos[i].comprado,
				level : global.produtos[i].level,
				tenho_manager : global.produtos[i].tenho_manager
			};
		
			_produtos[i] = _estrutura;
		}
	}
	
	//var _qtd_prod = array_create(array_length(global.produtos), 0);
	
	////criando um metodo para criar a estrutura com os dados de cada produtos
	//var _salva_dados = function(_elemento, _indice) {
	//	//so faco isso se tenho uma instancia nessa posicao
	//	if (instance_exists(global.produtos[i])) {
	//		//pegando as info do elemento
	//		_elemento = {
	//			comprado : global.produtos[_indice].comprado,
	//			level : global.produtos[_indice].level,
	//			tenho_manager : global.produtos[_indice].tenho_manager
	//		};
	//			return _elemento;
	//		}
	//	}
	
	//Iterar pelo array e criar a estrutura com os dados
	//var _produtos = array_map(_qtd_prod, _salva_dados);
	
	//pegando o momento em que o jogo foi fechado
	var _tempo_atual = date_current_datetime();
	//var _dif = date_second_span(_tempo_atual, _tempo2);
	
	//criando a estrutura do que vai ser salvo
	var _struct = {
		gold : global.gold,
		produtos: _produtos,
		gold_seg: global.gold_seg,
		tempo: _tempo_atual,
		idioma: global.idioma
	}
	
	//convertendo a struct em uma string
	var _string = json_stringify(_struct);
	
	//mandando ele salvar
	file_text_write_string(_file, _string);
	
	//fechando o file
	file_text_close(_file);
}
//carregando o jogo

function load_game() {
	//abrindo se ele existe 
	if (file_exists("save.json")) {
		// abrindo o arquivo
		var _file = file_text_open_read("save.json");
	
		//pegando as info do arquivo
		var _string = file_text_read_string(_file);
	
		//convertendo a string em uma string
		var _struct = json_parse(_string);
	
		//passsando o gold para o global.gold
		global.gold = _struct.gold;
	
		//passando as info dos produtos para o jogo
		global.produtos_info = _struct.produtos;
		
		//checnado quanto tempo passou
		var _tempo = date_current_datetime();
		var _dif = date_second_span(_struct.tempo, _tempo);
		var _dinheiro_tempo = _dif * _struct.gold_seg
		var _str = convert_num(_dinheiro_tempo);
		//show_message(global.idioma == 0 ? "Managers fizeram: " + _str + " Por segundo!!" : "Your managers made: " + _str + " Per second!!");
		//sabendo quanto denheiro eu fiz desde que o jogo foi fechado
		//atualizando o gold
		global.gold +=  _dinheiro_tempo;
	
		//pegando o idioma do jogo
		global.idioma = _struct.idioma;
	
		//fechando o arquivo
		file_text_close(_file);
		
		//avisando que o arquivo existe
		return true;
	}
	return false;
}

function carrega_dados(_idioma = 0) {
				 //_idioma == 0 se sim "dados.json" se não "dados_en.json"
	var _arquivo = _idioma == 0 ? "dados.json" : "dados_en.json";
	
	//abrinod o meu json
	var _file = file_text_open_read(_arquivo);
	var _txt = "";
	//rodadno pelo meu arquivo
	while (true) {
		//se chegou no final do arquivo ele sai do llop
		if (file_text_eof(_file)) {
			break;
		} else { // ianda não acabou
			var _linha = file_text_readln(_file)
			_txt += _linha;
		}
	}
	//converter esse texto um uma struct
	global.struct_produtos = json_parse(_txt).items;

	//fechnaod o arquivo 
	file_text_close(_file);
}