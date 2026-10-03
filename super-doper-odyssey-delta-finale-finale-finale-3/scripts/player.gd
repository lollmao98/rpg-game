extends CharacterBody2D

@export var speed: float = 300.0
@onready var animated: AnimatedSprite2D = $AnimatedSprite2D
@onready var hole: Node2D = $"../hole"
@onready var fishing_rode: Node2D = $"../FishingRode"


var interact_target: Node = null

var quest1 = "QuestGiver"
var quest2 = "QuestGiver2"
var dungeon = "hole"
var fishingrod = "FishingRode"

func _ready():
	# If we have a saved position, teleport the player there
	if GameManager.player_return_position != Vector2.ZERO:
		global_position = GameManager.player_return_position
func _physics_process(_delta):
	
	if Input.is_action_just_pressed("interact") and interact_target:
		if interact_target.name == quest1:
			interact_target.interact()
		elif interact_target.name == quest2:
			interact_target.interact2()
		elif interact_target.name == dungeon:
			interact_target.yes()
		elif interact_target.name == fishingrod:
			interact_target.yes() 
	var direction := Vector2.ZERO

	if Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_key_pressed(KEY_S):
		direction.y += 1
	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
		animated.flip_h = true
	if Input.is_key_pressed(KEY_D):
		direction.x += 1
		animated.flip_h = false

	if direction == Vector2.ZERO:
		animated.play("idle")
		velocity = Vector2.ZERO
	else:
		animated.play("walking")
		direction = direction.normalized()
		velocity = direction * speed

	move_and_slide()
	





func _on_interaction_area_area_entered(area: Area2D) -> void:
	print("Entered:", area.get_parent().name)

	interact_target = area.get_parent()

func _on_interaction_area_area_exited(area: Area2D) -> void:
	interact_target = null
