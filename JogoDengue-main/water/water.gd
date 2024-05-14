extends TileMap
class_name Water_Class

var character = null
var tilemap_position = null
var water_tile_positions = [
					Vector2(568, 240),
					Vector2(30, 40),
					Vector2(50, 60),
					]

func _ready():
	# Obtém todos os nós no grupo "character"
	var characters = get_tree().get_nodes_in_group("character")
	# Verifica se há personagens no grupo
	if characters.size() > 0:
		# Assume o primeiro personagem encontrado
		character = characters[0]

func _process(_delta)->void:
	if character != null and character._is_remove_water:
		for i in range(get_layers_count()):
			if get_layer_name(i) == "water" or get_layer_name(i) == "objects" or get_layer_name(i) == "extra":
				for water_tile_position in water_tile_positions:
					#set_layer_enabled(i,false)
					remove_layer(i)
					break
