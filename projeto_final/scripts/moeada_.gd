extends Area2D

var moeda := 1
func _ready():
	pass 

func _process(delta: float) -> void:
	pass


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$anim.play("coletar") 
	await $colisao.call_deferred("queu_free")
	Global.modeas += moeda

func _on_anim_animation_finished() -> void:
	queue_free()
