extends StaticBody2D

@onready var Items_Holder : Node2D = $"Items Holder"
var free_order_items = [] #free as free space, not free food xD
var taken_order_items = []
var Items = []

func get_free_order_items():
	Items = Items_Holder.get_children()
	free_order_items = Items.filter(func(i): return i.is_taken == false)
	
func get_taken_order_items():
	Items = Items_Holder.get_children()
	taken_order_items = Items.filter(func(i): return i.is_taken == true)
	
#func _ready() -> void:
	#get_free_order_items()
	#get_taken_order_items()
	#print(free_order_items)

func order_handler(table_id, order_sprite):
	get_free_order_items()
	#print("Zamówienie:")
	#print(table_id)
	#print(order_sprite)
	if free_order_items.size() > 0:
		var ordered_item = free_order_items[0]
		ordered_item.new_order(table_id, order_sprite)
