extends CharacterBody2D
class_name Doctor

var _player_ref: Character = null
var _time_since_heal: float = 0.0
var _heal_interval: float = 2.0
var _heal_amount: int = 5
var _isConversation: bool = false

@export_category("Objects")

func _process(delta: float):
	if _isConversation:
		if _player_ref is Character:
			_time_since_heal += delta
			if _time_since_heal >= _heal_interval:
				_time_since_heal = 0.0
				_player_ref.treatment(_heal_amount)

func _on_detection_area_body_entered(_body) -> void:
	if _body.is_in_group("character"):
		_player_ref = _body
		var _health = _player_ref._health
		if _health >= 80:
			Dialogic.start("treatment_easy")
		elif _health >= 60 and _health < 80:
			Dialogic.start("treatment_medium")
		elif _health >= 40 and _health < 60:
			Dialogic.start("treatment")
		elif _health < 40:
			Dialogic.start("treatment_hard")
		get_viewport().set_input_as_handled()
		_isConversation = true


func _on_detection_area_body_exited(_body) -> void:
	if _body.is_in_group("character"):
		_player_ref = null
		_isConversation = false
		Dialogic.end_timeline()
		
