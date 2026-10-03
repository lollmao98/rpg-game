extends CanvasLayer

@onready var p_sprite = $Player
@onready var e_sprite = $Enemy
@onready var p_bar = $Player/PlayerHP
@onready var e_bar = $Enemy/EnemyHP
@onready var status = $StatusLabel
@onready var btn_atk = $Buttons/AttackButton
@onready var btn_heal = $Buttons/HealButton
@onready var sfx = $SFX
@onready var bgm = $BGM
@onready var vapor = $vapor
var p_hp = 100
var e_hp = 250
var current_group = ""

# IMPORTANT: Make sure these files exist in your folder!
##var snd_heal = preload("res://heal.wav")

func _ready():
	self.visible = false
func play_vapor_buster():
	# 2. Assign the music file path
	# Note: Godot handles the spaces and '+' inside the quotes automatically
	vapor.stream = load("res://adam/Toby Fox - DELTARUNE Chapters 3+4 OST - 15 Vapor Buster.mp3")
func start_battle(group_name):
	current_group = group_name
	vapor.play()
	p_hp = 100
	e_hp = 250
	p_bar.value = p_hp
	e_bar.value = e_hp
	get_tree().paused = true
	self.visible = true
	p_sprite.play("idle")
	e_sprite.play("idle")
	bgm.play()
	toggle_buttons(false)
	status.text = "BATTLE START!"
func _on_attack_button_pressed():
	toggle_buttons(true)
	status.text = "ATTACKING!"
	
	# Play Sound and Animation
	#play_sfx(snd_atk)
	p_sprite.play("attack")
	
	# Wait for animation OR wait 1 second (Safety)
	await get_tree().create_timer(1.0).timeout 
	p_sprite.play("idle")
	
	# Damage Enemy
	e_hp -= 30
	e_bar.value = e_hp
	e_sprite.play("hurt")
	await get_tree().create_timer(0.5).timeout
	e_sprite.play("idle")
	
	check_health()

func _on_heal_button_pressed():
	toggle_buttons(true)
	status.text = "HEALING!"
	
	#play_sfx(snd_heal)
	p_sprite.play("heal")
	
	await get_tree().create_timer(1.0).timeout
	p_sprite.play("idle")
	
	p_hp = clamp(p_hp + 30, 0, 100)
	p_bar.value = p_hp
	
	check_health()

func enemy_turn():
	status.text = "ENEMY ATTACK!"
	e_sprite.play("attack")
	#play_sfx(snd_atk)
	
	await get_tree().create_timer(1.0).timeout
	e_sprite.play("idle")
	
	p_hp -= 25
	p_bar.value = p_hp
	p_sprite.play("hurt")
	
	await get_tree().create_timer(0.5).timeout
	p_sprite.play("idle")
	
	status.text = "YOUR TURN"
	toggle_buttons(false)

func check_health():
	if e_hp <= 0:
		status.text = "VICTORY!"
		vapor.stop()

		await get_tree().create_timer(1.0).timeout
		finish(true)

	elif p_hp <= 0:
		status.text = "DEFEAT..."
		await get_tree().create_timer(1.0).timeout
		finish(false)
	else:
		# If it was the player's action, move to enemy turn
		if status.text == "ATTACKING!" or status.text == "HEALING!":
			status.text = "WAITING..."
			await get_tree().create_timer(1.0).timeout
			enemy_turn()

func finish(won):
	if won:
		get_tree().change_scene_to_file("res://EndScene.tscn")


func toggle_buttons(state):
	btn_atk.disabled = state
	btn_heal.disabled = state

func play_sfx(sound):
	if sound:
		sfx.stream = sound
		sfx.play()
