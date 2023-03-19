extends Node2D


func _ready():
	$fire/animation.play('happy_float')


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

	if Global.turn_limit - Global.turn > 3:
		$'fire/intern'.texture = load('res://assets/sad_intern.png')


func _on_fire_pressed():
	if Global.score < 3:
		$fire/animation.play('not_enough_points')
		return

	Global.score -= 3
	Global.turn_limit = 7
