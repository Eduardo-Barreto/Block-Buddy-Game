extends Node2D

var types = ['i', 'j', 'l', 'o', 's', 't', 'z']


func generate_new_part():
	var part_type = types[randi() % types.size()]
	var new_part = load('res://scenes/parts/' + part_type + '.tscn').instance()
	new_part.part_type = part_type
	add_child(new_part)


func _ready():
	generate_new_part()
	pass
