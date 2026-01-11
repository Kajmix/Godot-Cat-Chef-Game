extends Control
@onready var label : Label = $Control/Money/Label
func update_label():
	label.text = "Money: " + str(MainGameManager.money)


func _on_auto_save_money_timeout() -> void:
	update_label()
