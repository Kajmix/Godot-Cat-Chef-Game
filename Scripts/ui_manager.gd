extends Control
@onready var label : Label = $Label
func update_label():
	label.text = "Money: " + str(MainGameManager.money)
