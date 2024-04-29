extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_character_character_stats_changed(_player) -> void:
	$bar.size.x  = 74 * _player._health / _player._max_health
