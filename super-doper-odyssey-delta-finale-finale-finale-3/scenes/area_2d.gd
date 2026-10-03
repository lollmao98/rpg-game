extends Node2D

var can_enter := false

func _on_body_entered(body):
	if body.name == "mainknight":
		can_enter = true

func _on_body_exited(body):
	if body.name == "mainknight":
		can_enter = false

func yes():
	get_tree().change_scene_to_file("res://scenes/dungeon.tscn")
