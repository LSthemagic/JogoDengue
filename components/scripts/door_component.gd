extends Area2D
class_name DoorComponent

var _player_ref: Character = null
const MAX_ENEMIES: int = 10
var enemies_spawned: int = 0
var enemy_scene = preload("res://Character/scenes/enemy.tscn")
var enemy_spawn_positions = [
	Vector2(640, 200),
	Vector2(472, 320),
	Vector2(904, 296),
	Vector2(744, -24),
	Vector2(720, -48),
	Vector2(144, 288),
	Vector2(720, -48),
]

@export_category("Variables")
@export var _teleport_position: Vector2

@export_category("Objects")
@export var _animation: AnimationPlayer = null
			

func _on_body_entered(_body):
	if _body.is_in_group("character"):
		_player_ref = _body
		_animation.play("open")
		if enemies_spawned < MAX_ENEMIES :
			# Escolhe aleatoriamente uma posição de spawn
			var spawn_index = randi() % enemy_spawn_positions.size()
			var spawn_position = enemy_spawn_positions[spawn_index]
			# Instancia um novo inimigo na posição escolhida aleatoriamente
			var enemy_instance = enemy_scene.instantiate()
			enemy_instance.global_position = spawn_position
			get_parent().add_child(enemy_instance)
			enemies_spawned += 1

func _on_animation_finished(_anim_name: String) -> void:
	if _anim_name == "open" :
		_player_ref.global_position = _teleport_position
		_animation.play("close")
		
