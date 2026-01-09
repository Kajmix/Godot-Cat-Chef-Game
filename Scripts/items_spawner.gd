extends StaticBody2D

@onready var Items_Holder : Node2D = $"Items Holder"
@onready var Player : CharacterBody2D = $"../Player"
var free_order_items = [] #free as free space, not free food xD
var taken_order_items = []
var Items = []
var is_player_in_items_area = false

func get_free_order_items():
	Items = Items_Holder.get_children()
	free_order_items = Items.filter(func(i): return i.is_taken == false)
	
func get_taken_order_items():
	Items = Items_Holder.get_children()
	taken_order_items = Items.filter(func(i): return i.is_taken == true)

func order_handler(table_id : StaticBody2D, order_sprite):
	get_free_order_items()
	if free_order_items.size() > 0:
		var ordered_item = free_order_items[0]
		ordered_item.new_order(table_id, order_sprite)

func take_ordered_item():
	get_taken_order_items()
	if taken_order_items.size() > 0:
		Player.is_any_item_not_taken = false
		var selected_item = taken_order_items[0]
		Player.take_ordered_item_handler(selected_item.id, selected_item.frame)
		if taken_order_items.size() == 1:
			selected_item.is_taken = false
			selected_item.hide()
		else:
			shift_taken_items_left()

func shift_taken_items_left():
	get_taken_order_items()
	if taken_order_items.size() <=1:
		return
	for i in range(1, taken_order_items.size()):
		var prev_item = taken_order_items[i-1]
		var curr_item = taken_order_items[i]
		prev_item.copy_from(curr_item)
	
	var last = taken_order_items[taken_order_items.size() -1]
	last.is_taken = false
	last.hide()
func _process(_delta: float) -> void:
	if is_player_in_items_area && Input.is_action_pressed("interact") && Player.is_any_item_not_taken:
		take_ordered_item()

func _on_items_area_body_entered(body) -> void:
	if body.is_in_group("Player"):
		is_player_in_items_area = true

func _on_items_area_body_exited(body) -> void:
	if body.is_in_group("Player"):
		is_player_in_items_area = false
