extends CharacterBody2D

const SPEED = 2000.0
var direction = 1


@onready var bate_volta = $bate_volta as RayCast2D

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta	
	if bate_volta.is_colliding():
		direction *= -1
		bate_volta.scale.x = direction
		$anim.scale.x = direction
	velocity.x = direction * SPEED * delta
	
	
	move_and_slide()


 
