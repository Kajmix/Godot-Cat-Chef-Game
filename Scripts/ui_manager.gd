extends Control
@onready var label : Label = $Control/Money/Label
func _ready() -> void:
	MainGameManager.loading_finished.connect(_on_loading_finished)
	SignalBus.found_keys.connect(_on_found_keys)
func update_label():
	label.text = "Money: $" + str(MainGameManager.money)
func _on_loading_finished():
	update_label()
func _on_found_keys():
	%KeyIcon.show()
