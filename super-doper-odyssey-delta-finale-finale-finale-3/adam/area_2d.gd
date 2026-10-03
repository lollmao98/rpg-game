extends Area2D

# 1. Find the Battle UI
# We go UP to Player (..), UP to MainLevel (..), then DOWN to BattleUI
@onready var battle_ui = $"../../BattleUI"

func _ready():
	# 2. Connect the "Bump" signal automatically
	area_entered.connect(_on_nose_bump)

func _on_nose_bump(enemy_area):
	# 3. Check if we hit a bad guy
	if enemy_area.is_in_group("Goblins"):
		print("BUMPED A GOBLIN!")
		battle_ui.start_battle("Goblins")
		
	elif enemy_area.is_in_group("TNT"):
		print("BUMPED TNT!")
		battle_ui.start_battle("TNT")
