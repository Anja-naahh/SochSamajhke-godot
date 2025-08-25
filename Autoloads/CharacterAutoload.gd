extends Node

var character_instance = null

func load_character():
	if character_instance:
		character_instance.queue_free()  # Remove old one

	if  GameState.chosen_character == "kamal":
		var scene = preload("res://Characters/kamal.tscn")
		character_instance = scene.instantiate()
	else:
		var scene = preload("res://Characters/suman.tscn")
		character_instance = scene.instantiate()

	get_tree().current_scene.add_child(character_instance)
	character_instance.name = "PlayerCharacter"

	
