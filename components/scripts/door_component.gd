extends Area2D
class_name DoorComponent

var _player_ref: Character = null
var _time_since_heal: float = 0.0
var _heal_interval: float = 2.0
var _heal_amount: int = 5

@export_category("Variables")
@export var _teleport_position: Vector2

@export_category("Objects")
@export var _animation: AnimationPlayer = null

func _process(delta: float):
	if _player_ref is Character:
		_time_since_heal += delta
		if _time_since_heal >= _heal_interval:
			_time_since_heal = 0.0
			_player_ref.treatment(_heal_amount)
			

func _on_body_entered(_body):
	if _body is Character:
		_player_ref = _body
		_animation.play("open")

func _on_animation_finished(_anim_name: String) -> void:
	if _anim_name == "open" :
		_player_ref.global_position = _teleport_position
		_animation.play("close")

