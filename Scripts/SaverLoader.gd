extends Node

func save_game_state():
	print("Saving...")
	var saved_game:save_manager_class = save_manager_class.new()
	
	#Save information about nodes in the game.
	saved_game.paddle_pos = get_tree().get_first_node_in_group("Paddle").global_position
	saved_game.ball_velocity = get_tree().get_first_node_in_group("Ball").velocity
	saved_game.ball_position = get_tree().get_first_node_in_group("Ball").global_position
	saved_game.score = gm.score
	saved_game.level = gm.level
	
	#Get the bricks
	for brick in get_tree().get_nodes_in_group("Block"):
		saved_game.block_positions.append(brick.global_position)
		
	#Finalize saving and print that we're done.
	ResourceSaver.save(saved_game, "user://saved_game.tres")
	gm.no_save = false
	print("Save finished at ", Time.get_datetime_dict_from_system())
	
func load_game_state():
	print("Loading...")
	gm.is_loading = true
	var saved_game:save_manager_class = load("user://saved_game.tres") as save_manager_class
	
	for block in get_tree().get_nodes_in_group("Block"):
		block.get_parent().remove_child(block)
		block.queue_free()
		
	for pos in saved_game.block_positions:
		var block = preload("res://Scenes/block.tscn")
		var new_block = block.instantiate()
		var world_root = $".."
		world_root.add_child(new_block)
		new_block.global_position = pos
	
	get_tree().get_first_node_in_group("Paddle").position = saved_game.paddle_pos
	get_tree().get_first_node_in_group("Ball").velocity = saved_game.ball_velocity 
	get_tree().get_first_node_in_group("Ball").global_position = saved_game.ball_position 
	gm.score = saved_game.score
	gm.level = saved_game.level
	
	await get_tree().create_timer(1).timeout
	gm.is_loading = false
	gm.is_resume = false

	print("Loading done.")
