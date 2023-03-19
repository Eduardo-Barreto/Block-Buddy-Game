extends Node2D

var types = ['i', 'j', 'l', 'o', 's', 't', 'z']


func generate_new_part():
	var new_part = load('res://scenes/parts/' + Global.next_part + '.tscn').instance()
	new_part.part_type = Global.next_part
	add_child(new_part)

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


func _ready():
	generate_new_part()
