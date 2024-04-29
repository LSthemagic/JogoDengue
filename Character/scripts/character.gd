extends CharacterBody2D
class_name Character

var _state_machine
var _is_attacking: bool = false
var _is_dead: bool = false

var _health: float = 100.0
var _max_health: float = 100.0
var _health_recovery: float = 1.0

signal character_stats_changed

@export_category("Variables")
@export_category("Objects")

@export var _move_speed: float = 64.0 
@export var _friction: float = 0.8
@export var _acceleration: float = 0.4

@export var _attack_timer: Timer = null
@export var _animation_tree: AnimationTree = null

func _ready() -> void:
	emit_signal("character_stats_changed", self)
	_animation_tree.active = true
	_state_machine = _animation_tree["parameters/playback"] 

func  _physics_process(_delta: float) -> void:
	if _is_dead:
		return
	_move()
	_attack()
	_animate()
	move_and_slide()

func _move() -> void:
	var _directions: Vector2 = Vector2(
		Input.get_axis("move_left","move_right"),
		Input.get_axis("move_up","move_down")
	)
	if _directions != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _directions
		_animation_tree["parameters/walk/blend_position"] = _directions
		_animation_tree["parameters/attack/blend_position"] = _directions
		
		
		velocity.x = lerp(velocity.x, _directions.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _directions.normalized().y * _move_speed, _acceleration)
		return
	
	velocity.x = lerp(velocity.x, _directions.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _directions.normalized().y * _move_speed, _friction)
	velocity = _directions.normalized() * _move_speed

func _attack() -> void:
	if Input.is_action_just_pressed("attack") and not _is_attacking:
		set_physics_process(false)
		_attack_timer.start()
		_is_attacking = true

func _animate() -> void:
	
	if _is_attacking:
		_state_machine.travel("attack")
		return
	
	if velocity.length() > 10 :
		_state_machine.travel("walk")
		return
	_state_machine.travel("idle")


func _on_attack_timer_timeout():
	set_physics_process(true)
	_is_attacking = false


func _on_attack_area_body_entered(body):
	if body.is_in_group("enemy"):
		body.update_health()

func die() -> void:
	if _health >= 10:
		_health = _health - 10
		emit_signal("character_stats_changed",self)
		return
	
	_is_dead = true
	_state_machine.travel("death")
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()

func treatment(delta: float) -> void:
	print(delta)
	var _new_health = min(_health + _health_recovery * delta, _max_health)
	if _new_health != _health:
		_health = _new_health
		emit_signal("character_stats_changed",self)
