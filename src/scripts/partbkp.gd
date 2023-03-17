extends KinematicBody2D

var active = true
export (String) var part_type = 'j'

var move_strength = 0
var move_incrementer = 0.05

onready var size = Global.parts[part_type]


func snap_to_grid():
	var new_x = round(position.x / 54) * 54
	var new_y = round(position.y / 54) * 54

	position = Vector2(new_x, new_y)

	if int(size.x)%int(2) == 0:
		position.x -= 27

	if int(size.y)%int(2) == 1:
		position.y -= 27


func move_x(direction):
	var new_x = position.x + direction * 54
	var new_collumn = abs(round(new_x / 54))
	position.x = Global.collumns[new_collumn]

	if int(size.x)%int(2) == 0:
		position.x -= 27


func move_y(direction):
	var new_y = position.y + direction * 54
	var new_line = abs(round(new_y / 54))

	position.y = Global.lines[new_line]

	if int(size.y)%int(2) == 1:
		position.y -= 27

func _ready():
	$Sprite.texture = load('res://assets/parts/' + part_type + '.png')
	add_child(load('res://scenes/shapes/' + part_type + '.tscn').instance())

	move_x(4)


func _input(event):
	if not active:
		return

	if event.is_action_pressed('ui_left'):
		move_x(-1)

	if event.is_action_pressed('ui_right'):
		move_x(1)

	if event.is_action_pressed('ui_up'):
		rotation_degrees += 90
		size = Vector2(size.y, size.x)


func _physics_process(_delta):
	if not active:
		return

	if is_on_floor():
		snap_to_grid()
		active = false
		get_parent().get_parent().generate_part()
		return

	move_strength += move_incrementer

	if move_strength > 1:
		move_y(1)
		move_strength = 0.1

	move_and_slide(Vector2(0, 0.01), Vector2(0, -1))
