extends CanvasLayer
	
func _ready():
	visible = false
	
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true

func _on_Voltar_pressed():
	get_tree().paused = false
	visible = false


func _on_Resetar_pressed():
	ScriptDados.resetar_recorde()
	ScriptDados.carregar_dados()


func _on_Fechar_pressed():
	get_tree().quit()
