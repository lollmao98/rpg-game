extends CanvasLayer

@onready var panel = $Panel
@onready var label = $Panel/Label

func _ready():
	panel.visible = false
	
	if QuestManager:
		# Connect to both signals
		QuestManager.quest_started.connect(show_quest)
		QuestManager.quest_finished.connect(hide_quest_ui)
		print("DEBUG: QuestUI connected to Manager signals")

func show_quest(text: String):
	label.text = text
	label.visible_characters = 0 
	panel.visible = true
	
	var duration = text.length() * 0.04
	var tween = create_tween()
	tween.tween_property(label, "visible_characters", text.length(), duration)

# This function runs when the Manager emits "quest_finished"
func hide_quest_ui():
	panel.visible = false
