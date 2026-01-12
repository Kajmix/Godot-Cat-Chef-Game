extends Timer

@onready var Player : CharacterBody2D = $"../Player"
@onready var UI : Control = $"../ui/ui"
func _ready() -> void:
	MainGameManager.load_save(Player)
	MainGameManager.autosave(Player)
	UI.update_label()
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		MainGameManager.autosave(Player)

func _on_auto_save_timeout() -> void:
	MainGameManager.autosave(Player)
