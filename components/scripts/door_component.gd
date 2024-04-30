extends Area2D
class_name DoorComponent

var _player_ref: Character = null

@export_category("Variables")
@export var _teleport_position: Vector2

@export_category("Objects")
@export var _animation: AnimationPlayer = null
			

func _on_body_entered(_body):
	if _body is Character:
		_player_ref = _body
		_animation.play("open")
		#Dialogic.start("treatment")
		#get_viewport().set_input_as_handled()

func _on_animation_finished(_anim_name: String) -> void:
	if _anim_name == "open" :
		_player_ref.global_position = _teleport_position
		_animation.play("close")

