extends Node2D

var types = ['i', 'j', 'l', 'o', 's', 't', 'z']


func load_part(part_type):
	var new_part = load('res://scenes/parts/' + part_type + '.tscn').instance()
	new_part.part_type = part_type
	add_child(new_part)


func generate_new_part():
	load_part(Global.next_part)

	var next_part_type = types[randi() % types.size()]
	Global.next_part = next_part_type


func check_full_line():
	for line in range(20):
		var full_line = true

		for collumn in range(10):
			if Global.inactive_positions.has(Vector2(collumn, line)):
				continue

			full_line = false
			break

		if not full_line:
			continue

		Global.score += 1

		for collumn in range(10):
			# limpa todos os blocos da linha
			var current_position = Vector2(collumn, line)
			Global.inactive_positions[current_position].queue_free()
			Global.inactive_positions.erase(current_position)

		for upper_line in range(line, 0, -1):
			# move todos os blocos acima da linha para baixo
			for collumn in range(10):
				var current_position = Vector2(collumn, upper_line)

				if not Global.inactive_positions.has(current_position):
					continue

				var current_block = Global.inactive_positions[current_position]
				Global.inactive_positions.erase(current_position)
				current_block.position.y += 54
				Global.inactive_positions[Vector2(collumn, upper_line+1)] = current_block


func _input(event):
	if event.is_action_pressed('hold_part'):
		var current_part = null

		for child in get_children():
			if child.is_active:
				current_part = child
				break

		if Global.holding_part != null:
			load_part(Global.holding_part)
		else:
			generate_new_part()

		Global.holding_part = current_part.part_type
		current_part.queue_free()


func _ready():
	generate_new_part()
