extends Node2D

@export var quest_given := false

# Store the whole conversation in an Array
var dialogue = [
"QuestGiver: Hey Knight! Come, you must hear this.",
	"Knight: It better be worth it, kid",
	"QuestGiver: They are here!! I SAW THEM!!",
	"Knight: Who is here?",
	"QuestGiver: The Deadians!",
	"Knight: WHAT? How did you know? where did you so them?",
	"QuestGiver: I don't know,",
	"QuestGiver: I was walking down the hill near the archery tower,",
	"QuestGiver: and suddenly a hole appeared from the ground,",
	"QuestGiver: There were many of them,",
	"QuestGiver: but that hole just pulled them all inside it",
	"Knight: So it is still not the time, huh?",
	"QuestGiver: What do you mean by that?",
	"Knight: This thing happened before, when I was your age.",
	"Knight: Back then, the adults did not close the hole,",
	"Knight: thinking it would just pull them again and again.",
	"Knight: But they were wrong,",
	"Knight: One day they came, but this time,",
	"Knight: that hole did NOT close",
	"Knight: They destroyed the whole village,",
	"Knight: and killed most of the adults,",
	"Knight: Before the army showed up,",
	"Knight: Your parents always tell you stories about them, kid",
	"Knight: and you get teached about them,",
	"Knight: But they are much dangerous than you could ever hear",
	"Knight: Take care, Kid, I will go and end them, once and for all"

]
var dialogue2 = [
	"Fashi: HEY! HEY! OVER HEAR",
	"Knight: What is wrong? Why are you shouting so loud?",
	"Fashi: Did not know you were blined.",
	"Knight: I am not blind, what do you mean?",
	"Fashi: Well the, I guess you can see that my leg is broken",
	"Knight: Ah, yes, that. So, what happened?",
	"Fashi: See that sheep, over there,",
	"Fashi: I was fishing and it kicked me into the water, and leg broke",
	"Fashi: I need food, you know , to eat,",
	"Fashi: So can you please go fish me 5 fishes"
]
func interact():
	if quest_given:
		return
	
	quest_given = true
	
	# Loop through the array automatically
	for line in dialogue:
		QuestManager.start_quest(line)
		await get_tree().create_timer(3.5).timeout # Wait slightly longer than the UI
	QuestManager.hide_ui()
func interact2():
	if quest_given:
		return
	
	quest_given = true
	
	# Loop through the array automatically
	for line in dialogue2:
		QuestManager.start_quest(line)
		await get_tree().create_timer(3.5).timeout
	# Optional: Hide UI at the very end of the whole talk
	QuestManager.hide_ui()
