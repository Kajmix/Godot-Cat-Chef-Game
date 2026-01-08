extends AnimatedSprite2D
@export var id : StaticBody2D
@export var is_taken = false

func new_order(Table_ID, Sprite_ID):
	is_taken = true
	id = Table_ID
	frame = Sprite_ID
	show()

func copy_from(other):
	id = other.id
	frame = other.frame
	is_taken = other.is_taken
	
	if is_taken:
		show()
	else:
		hide()
func _ready() -> void:
	hide()
