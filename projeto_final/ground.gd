extends TileMapLayer

var speed = 30
var falling = false

func start_falling():
	print("GROUND RECEBEU start_falling()")
	falling = true

func _physics_process(delta):
	if falling:
		speed += 2 * delta  # acelera aos poucos
		global_position.y += speed * delta
