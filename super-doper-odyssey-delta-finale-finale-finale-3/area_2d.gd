extends Area2D

# 1. This creates a SLOT in the Inspector
@export var goblin_battle_ui: CanvasLayer
@export var tnt_battle_ui: CanvasLayer
@export var boss_battle_ui: CanvasLayer
func _ready():
	# 2. Connect the "Bump" signal
	# If the enemy is an Area2D, use area_entered
	area_entered.connect(_on_nose_bump)
	
	# If the enemy is a PhysicsBody (like a wall), we also check this:
	body_entered.connect(_on_nose_bump)

func _on_nose_bump(target):
	# 3. Debugging: Print ANY hit to the output at the bottom
	print("I hit something: ", target.name)
	
	# 4. Check for Goblins
	if target.is_in_group("Goblins"):
		print("Starting Goblin Fight!")
		goblin_battle_ui.start_battle("Goblins")
		
	# 5. Check for TNT
	elif target.is_in_group("TNT"):
		print("Starting TNT Fight!")
		tnt_battle_ui.start_battle("TNT")
		
	elif target.is_in_group("Boss"):
		print("Starting boss Fight!")
		boss_battle_ui.start_battle("Boss")
