extends Timer

@onready var Player : CharacterBody2D = $"../Player"
@onready var UI : Control = $"../ui/ui"
@onready var ControlNode : Control = $Control
func _ready() -> void:
	ControlNode.hide()
	MainGameManager.load_save(Player)
	MainGameManager.autosave(Player)
	UI.update_label()
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		MainGameManager.autosave(Player)

func _on_auto_save_timeout() -> void:
	ControlNode.show()
	MainGameManager.autosave(Player)
	await get_tree().create_timer(2.5).timeout
	ControlNode.hide()
