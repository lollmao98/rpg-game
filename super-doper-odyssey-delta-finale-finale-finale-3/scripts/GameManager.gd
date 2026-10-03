# GameManager.gd
extends Node

# This variable will store the position globally
var player_return_position: Vector2 = Vector2.ZERO

# Helper function to switch scenes and save position
func start_fishing(current_pos: Vector2):
	player_return_position = current_pos
	get_tree().change_scene_to_file("res://fishing.tscn")

func return_to_world():
	get_tree().change_scene_to_file("res://scenes/game.tscn") # Put your main scene path here
