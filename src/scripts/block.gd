extends Node2D

export (Color) var color = Color(1, 1, 1, 1)
var part_type = 'i'


func position_to_grid(pos):
	return Vector2(int(pos.x / 54), int(pos.y / 54))


func _ready():
	$shape.color = Color(Global.part_types[part_type]['color'])
	print($shape.color)


func can_move_down() -> bool:
	var next_pos = position_to_grid(position)
	next_pos.y += 1

	if next_pos.y > 19:
		return false

	return not Global.inactive_positions.has(next_pos)


func can_move(direction: int) -> bool:
	var next_pos = position_to_grid(position)
	next_pos.x += direction

	if next_pos.x > 9 or next_pos.x < 0:
		return false

	return not Global.inactive_positions.has(next_pos)


func move(direction: int):
	var next_pos = position_to_grid(position)
	next_pos.x += direction

	position = next_pos * 54


func move_down():
	var next_pos = position_to_grid(position)
	next_pos.y += 1

	position = next_pos * 54
