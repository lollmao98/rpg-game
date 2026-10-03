extends Node

# This signal is the "shout" that the UI will listen for
signal quest_started(text)
signal quest_finished() 

func start_quest(text: String):
	quest_started.emit(text)
	
func hide_ui():
	# Instead of changing a variable, we just send the signal
	quest_finished.emit()
