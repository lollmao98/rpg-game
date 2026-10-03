extends CanvasLayer

@onready var label = $Label
@onready var voice_sound = $VoiceSound

@export var typing_speed: float = 0.05
var last_visible_chars: int = 0

func _ready():
	start_typewriter_effect()
	print("ready")

func start_typewriter_effect():
	label.visible_characters = 0
	last_visible_chars = 0
	print("ready to typewrite")
	var total_chars = label.get_total_character_count()
	var duration = total_chars * typing_speed
	
	var tween = get_tree().create_tween()
	tween.tween_property(label, "visible_characters", total_chars, duration)

func _process(_delta):
	# Check if the number of visible characters has increased
	if label.visible_characters > last_visible_chars:
		play_voice_sound()
		last_visible_chars = label.visible_characters

func play_voice_sound():
	# Only play if the current character isn't a space (optional)
	var current_char = label.text[label.visible_characters - 1]
	if current_char != " " and current_char != "\n":
		# Stop and restart to allow rapid fire sounds
		voice_sound.play()
