extends Control
@onready var label : Label = $Label
func print_label(text):
	label.text = text
