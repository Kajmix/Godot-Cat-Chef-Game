extends StaticBody2D
@onready var colision = $CollisionShape2D
func _ready() -> void:
	if MainGameManager.is_after_ending:
		colision.disabled = false
		show()
	else:
		colision.disabled = true
		hide()
