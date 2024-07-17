extends Control

@onready var score_label = $Score
@onready var level_label = $Level

func _process(_delta):
	if gm.score:
		score_label.text = str(gm.score)
	else:
		score_label.text = "0"
	if gm.level == 0:
		level_label.text =  str("Level 0")
	else:
		level_label.text = str("Level ", + gm.level)
