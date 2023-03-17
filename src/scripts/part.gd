extends Node2D

var is_active = true
var part_type = 'i'


func get_blocks():
	var blocks = []
	for block in get_children():
		if block is Timer:
			continue

		blocks.append(block)

	return blocks


func inactivate():
	is_active = false
	for block in get_blocks():
		var block_position = block.position_to_grid()

		Global.inactive_positions.append(block_position)


func move(direction: int) -> void:
	for block in get_blocks():
		if not block.can_move(direction):
			return

	for block in get_blocks():
		block.move(direction)

func move_down():
	for block in get_blocks():
		if not block.can_move_down():
			inactivate()

	for block in get_blocks():
		block.move_down()


func _on_Timer_timeout():
	move_down()


func _ready():
	for block in get_blocks():
		block.part_type = part_type

	var timer = Timer.new()
	timer.connect('timeout', self, '_on_Timer_timeout')
	timer.wait_time = 0.5
	timer.one_shot = false
	add_child(timer)
	timer.start()


func _input(event):
	if event.is_action_pressed('ui_right'):
		move(1)

	if event.is_action_pressed('ui_left'):
		move(-1)


func _process(_delta):
	if not is_active:
		return
