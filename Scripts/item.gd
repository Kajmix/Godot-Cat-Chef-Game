extends AnimatedSprite2D
@export var id : StaticBody2D
@export var is_taken = false
func new_order(Table_ID, Sprite_ID):
	is_taken = true
	id = Table_ID
	frame = Sprite_ID
	show()
	print("zamowienie:")
	print(id)
	print(frame)
	
func _ready() -> void:
	hide()
