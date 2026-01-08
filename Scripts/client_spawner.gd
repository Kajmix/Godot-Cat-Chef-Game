extends Node2D

var tables: Array = []
var taken_tables : Array = []
var free_tables : Array = []

func _ready():
	# Get all nodes in the "table" group
	tables = get_tree().get_nodes_in_group("table")
	free_tables = get_free_tables()
	taken_tables = get_taken_tables()

func get_free_tables():
	return tables.filter(func(t): return t.is_taken == false)

func get_taken_tables():
	return tables.filter(func(t): return t.is_taken == true)

func _on_client_cooldown_timeout() -> void:
	free_tables = get_free_tables()
	if free_tables.size() > 0:
		var table = free_tables[randi_range(0,free_tables.size() - 1)]
		table.show_customer(table)
