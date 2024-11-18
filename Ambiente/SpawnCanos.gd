extends Node2D

signal criar_obstaculo(obs)

onready var tempo = $Timer

var Obstaculo = preload("res://Ambiente/Obstaculos.tscn")

func _ready():
	randomize()

func _on_Timer_timeout():
	spawn()

func spawn():
	var obstaculo = Obstaculo.instance()
	add_child(obstaculo)
	obstaculo.position.y = randi()%400 + 150
	emit_signal("criar_obstaculo", obstaculo)
	
func iniciar():
	tempo.start()
	
func parar():
	tempo.stop()
	
