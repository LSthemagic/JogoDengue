extends Label
var _character = null
# Chamado quando o nó entra na árvore da cena pela primeira vez.
func _ready():
	pass
# Chamado sempre que o sinal character_stats_changed é emitido pelo Character.
func _process(_delta):
	var _text_label = str("INIMIGOS: ",35 - _character._enemies_dead)
	if(35 - _character._enemies_dead <= 10):
		_text_label = str("Vá ao Agente de saúde,\nos inimigos podem voltar.")
	text = _text_label


func _on_character_character_stats_changed(_player):
	_character = _player
