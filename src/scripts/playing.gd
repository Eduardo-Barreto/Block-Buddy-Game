extends Node2D


func _process(_delta):
	if Global.next_part != null:
		$next.texture = load('res://assets/parts/' + Global.next_part + '.png')

	if Global.holding_part != null:
		$holding.texture = load('res://assets/parts/' + Global.holding_part + '.png')

	$score.text = str(Global.score)
