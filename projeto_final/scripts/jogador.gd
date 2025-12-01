extends CharacterBody2D

const SPEED = 200
const JUMP_FORCE = -400
const GRAVITY = 1200
const DEATH_Y = 600

var sprite

func _ready():
	sprite = $anim  # <-- seu nó de animação

func _physics_process(delta):
	# Gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Movimento horizontal
	var dir = Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * SPEED

	# Pulo
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_FORCE

	# Animação + Flip
	if sprite:
		if dir < 0:
			sprite.flip_h = true
		elif dir > 0:
			sprite.flip_h = false

		if not is_on_floor():
			sprite.play("jump")
		elif dir != 0:
			sprite.play("run")
		else:
			sprite.play("idle")

	move_and_slide()

	# Morte ao cair
	if position.y > DEATH_Y:
		die()

func die():
	print("MORREU")
	get_tree().reload_current_scene()
