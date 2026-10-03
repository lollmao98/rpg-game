extends Node2D

@onready var circle_area: Area2D = $CircleArea
@onready var circle: AnimatedSprite2D = $CircleArea/Circle
@onready var collision: CollisionShape2D = $CircleArea/CollisionShape2D
@onready var move_timer: Timer = $MoveTimer
@onready var game_timer: Timer = $GameTimer
@onready var fish_label: Label = $FishLabel


var fish_count := 0
var radius := 32.0
var win := false   # outcome

# Play area
var play_position := Vector2(0, 0)
var play_size := Vector2(600, 300)

func _ready():
	# Safe radius from collision
	if collision.shape is CircleShape2D:
		radius = collision.shape.radius

	circle_area.input_event.connect(_on_circle_clicked)
	move_timer.timeout.connect(_on_move_timer_timeout)
	game_timer.timeout.connect(_on_game_over)

	move_timer.start()
	game_timer.start()

	circle.play("Idle")
	move_circle()

func _on_circle_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if randi() % 5 == 0:
			fish_count += 1
			fish_label.text = "Fish: %d" % fish_count

		move_circle()

		# Win if 10 fish collected
		if fish_count == 5:
			win = true
			game_over()

func _on_move_timer_timeout():
	move_circle()

func move_circle():
	var x = randf_range(play_position.x + radius, play_position.x + play_size.x - radius)
	var y = randf_range(play_position.y + radius, play_position.y + play_size.y - radius)
	circle_area.global_position = Vector2(x, y)

func _on_game_over():
	# Timer ran out → lose
	if fish_count < 5:
		win = false
	game_over()

func game_over():
	move_timer.stop()
	game_timer.stop()
	
	print("Game Over. Win =", win)
	
	# Instead of just hiding, go back to the world
	# Use a small timer or wait for a click if you want them to see the result first
	await get_tree().create_timer(0.5).timeout
	GameManager.return_to_world()
