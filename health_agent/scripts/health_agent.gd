extends CharacterBody2D
class_name healthAgent
var _player_ref = null
var _timeline = null

func _on_area_2d_body_entered(_body):
	var _executed: bool = false
	if _body.is_in_group("character"):
		_player_ref = _body
		if(_player_ref._mission_passed):
			_timeline = "mission_passed"
			_player_ref._is_remove_water = true
			_executed = true
		else:
			_timeline = "mission_incomplete"
		Dialogic.start(_timeline)
		get_viewport().set_input_as_handled()
		
		if _executed:
			await get_tree().create_timer(40.0).timeout
			get_tree().change_scene_to_file("res://user_interface/scenes/game_winner.tscn")

func _on_area_2d_body_exited(_body):
	_player_ref = null
	Dialogic.end_timeline()
