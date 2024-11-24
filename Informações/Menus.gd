extends CanvasLayer

signal novo_jogo

onready var mensagem = $Iniciar/Mensagens
onready var tween = $Tween
onready var pontos_label = $GameOver/VBoxContainer/Pontos
onready var recorde_label = $GameOver/VBoxContainer/Recorde
onready var game_over = $GameOver

var jogo_iniciado = false
		
func _input(event):
	if event.is_action_pressed("clique") && !jogo_iniciado:
		emit_signal("novo_jogo")
		tween.interpolate_property(mensagem, "modulate:a", 1, 0, 0.5)
		tween.start()
		jogo_iniciado = true

func novo_game_over(x, y):
	pontos_label.text = "Semestres: " + str(x)
	recorde_label.text = "Recorde: " + str(y)
	game_over.visible = true
	
	
func _on_Restart_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
