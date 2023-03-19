extends Node2D


func _ready():
	$fire/animation.play('float')


func _process(_delta):
	if Global.next_part != null:
		$next.texture = load('res://assets/parts/' + Global.next_part + '.png')
	else:
		$next.texture = null

	if Global.holding_part != null:
		$holding.texture = load('res://assets/parts/' + Global.holding_part + '.png')
	else:
		$holding.texture = null

	$score.text = str(Global.score)
