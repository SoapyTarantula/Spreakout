extends Node2D

var starting_position: Vector2
@onready var camera = $Camera2D
var block = preload("res://Scenes/block.tscn")

@export_category("Block settings")
@export var block_rows: int = 9
@export var block_columns: int = 30
@export var margin: int = 30

var has_won: bool = false

func _ready():
	if not gm.is_resume:
		has_won = false
		starting_position.x = camera.get_screen_center_position().x
		starting_position.y = camera.get_screen_center_position().y * 1.95
		$Paddle.position = starting_position
		make_blocks()
	else:
		has_won = false
		%SaverLoader.load_game_state()
	
func _process(_delta):
	if get_tree().get_nodes_in_group("Block").size() == 0 and not has_won and not gm.is_loading:
		has_won = true
		print("winner")
		$Sounds/success.volume_db = Music.gvol_db
		$Sounds/success.play()
		#%SaverLoader.save_game_state()
		await get_tree().create_timer(1).timeout
		call_deferred("new_level")
		
func new_level():
	gm.next_level = true
	gm.level += 1
	get_tree().reload_current_scene()
	
func prettification():
	var colors = [
		Color(0.392157, 0.584314, 0.929412, 1), # Cornflower blue
		Color(0.564706, 0.933333, 0.564706, 1), # Light green
		Color(1, 0.980392, 0.803922, 1), # Lemon chiffon
		Color(0.576471, 0.439216, 0.858824, 1), # Medium purple
		Color(1, 0.894118, 0.882353, 1), # Misty rose
		Color(0.254902, 0.411765, 0.882353, 1), # Royal blue
	]
	return colors

func make_blocks():
	var colors = prettification()
	colors.shuffle()
	
	for r in block_rows:
		for c in block_columns:
			var rand = randi_range(0,2)
			if rand > 0:
				var newBlock = block.instantiate()
				add_child(newBlock)
				newBlock.position = Vector2(margin + (20 * c), margin + (20 * r))
				
				var sprite = newBlock.get_node("Sprite2D")
				var particle = newBlock.get_node("CPUParticles2D")
				if r <= 9:
					sprite.modulate = colors[0]
					particle.modulate = colors[0]
				if r < 6:
					sprite.modulate = colors[1]
					particle.modulate = colors[1]
				if r < 3:
					sprite.modulate = colors[2]
					particle.modulate = colors[2]
