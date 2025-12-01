extends CharacterBody2D

const SPEED = 200
const JUMP_FORCE = -400
const GRAVITY = 900

var death_y = 600

func _physics_process(delta):
	# GRAVIDADE
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# MOVIMENTO LATERAL (ESQUERDA/DIREITA)
	var direction = 0
	if Input.is_action_pressed("ui_right"):
		direction += 1
	if Input.is_action_pressed("ui_left"):
		direction -= 1

	velocity.x = direction * SPEED

	# VIRAR O PERSONAGEM
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction > 0:
		$AnimatedSprite2D.flip_h = false

	# PULO
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_FORCE

	# ANIMAÇÕES
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
	else:
		if direction == 0:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("run")

	# MOVIMENTO FINAL
	move_and_slide()

	# VERIFICA SE O PLAYER CAIU
	if position.y > death_y:
		die()

func die():
	print("Morreu!")
	get_tree().reload_current_scene()
