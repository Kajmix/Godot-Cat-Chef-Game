extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("You escape!")
#		In future I will make here an easter egg.
