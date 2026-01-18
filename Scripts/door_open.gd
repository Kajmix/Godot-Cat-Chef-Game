extends TileMapLayer

func _ready() -> void:
	MainGameManager.loading_finished.connect(_on_loading_finished)
func _on_loading_finished():
	if MainGameManager.is_door_open:
		show()
	else:
		hide()
