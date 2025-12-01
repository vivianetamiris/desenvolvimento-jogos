extends Control

@onready var contador_moedas = $container/moedas_container/contador_moedas as Label


func _ready() -> void:
	contador_moedas.text = str("%04d" %Global.modeas)
	
func _process(delta: float) -> void:
	contador_moedas.text = str("%04d" %Global.modeas)
	
