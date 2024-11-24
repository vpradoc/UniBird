extends CanvasLayer

onready var musica = $"../MusicaFundo"

const LOG_RECORD = "user://salvarrecord.save"
const recorde = 0

func salvar_recorde():
	var salvar = File.new()
	salvar.open(LOG_RECORD, File.WRITE)
	salvar.store_var(recorde)
	salvar.close()
	
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
	salvar_recorde()


func _on_Fechar_pressed():
	get_tree().quit()


func _on_BMusica_toggled(button_pressed):
	if !button_pressed:
		musica.stop()
	if button_pressed:
		musica.play()
