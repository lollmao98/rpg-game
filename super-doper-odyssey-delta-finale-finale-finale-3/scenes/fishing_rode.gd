extends Node2D

var can_enter := false

func _on_body_entered(body):
	if body.name == "mainknight":
		can_enter = true

func _on_body_exited(body):
	if body.name == "mainknight":
		can_enter = false

func yes():
	# Find the player node in the current scene to get its position
	var player = get_tree().current_scene.find_child("mainknight")
	if player:
		GameManager.start_fishing(player.global_position)
	else:
		get_tree().change_scene_to_file("res://fishing.tscn")
