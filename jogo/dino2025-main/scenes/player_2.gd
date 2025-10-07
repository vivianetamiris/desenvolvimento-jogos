extends CharacterBody2D

@export_enum("p1", "p2") var player_id := "p1"
@export var speed := 300.0
@export var jump_velocity := -400.0
@onready var anim: AnimatedSprite2D = $anim

var jump_player := false

func _physics_process(delta: float) -> void:
	# Aplica gravidade se não estiver no chão
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
		jump_player = true
	else:
		jump_player = false

	# Input dinâmico baseado no jogador (p1 ou p2)
	var move_left = Input.get_action_strength("move_left_p2")
	var move_right = Input.get_action_strength("move_right_p2")
	var move_up = Input.get_action_strength("move_up_p2")
	var direction_x = move_right - move_left

	# Movimento horizontal
	if direction_x != 0:
		anim.scale.x = direction_x
		velocity.x = direction_x * speed
		if not jump_player:
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if not jump_player:
			anim.play("idle")

	# Pulo
	if Input.is_action_just_pressed("jump_p2") and is_on_floor():
		velocity.y = jump_velocity

	# Checagem de queda/morte
	if position.y >= 400:
		death()

	move_and_slide()

func death():
	anim.play("hurt")
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()
