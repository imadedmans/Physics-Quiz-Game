extends Sprite2D

@onready var speechBubble = $SpeechBubble
@onready var label = $SpeechLabel
@onready var chrTimer = $TalkTimer
@onready var audio = $AudioStreamPlayer
@onready var animPlayer = get_parent().get_node("AnimationPlayer")

@export var talkTime: float = 0.05
@export var shakeForce: float = 10

var dialogueLines = []
var curDiagLine = -1

var numOfTurns = 6
var currentLine = ""
var curChrInt = 0
var hasTalked = false
var canSkip = false
var curQueInt

@export var canShake = false
signal can_proceed

# Called when the node enters the scene tree for the first time.
func _ready():
	animPlayer = get_parent().get_node("AnimationPlayer")
	speechBubble.visible = false
	chrTimer.wait_time = talkTime
	
	#var ogFile = FileAccess.open("res://Text Files/BombheadResponses.txt", FileAccess.READ)
	var dialogueLinesTXT = Array(StringManager.responsesString.split("@"))
	dialogueLinesTXT.pop_at(0)
	
	for j in range(len(dialogueLinesTXT)):
		dialogueLines.append(dialogueLinesTXT[j].split("\n"))
		dialogueLines[j] = Array(dialogueLines[j])
		dialogueLines[j].pop_at(0)
		dialogueLines[j].pop_at(len(dialogueLines[j]) - 1)
		
		if (j != len(dialogueLinesTXT) - 1):
			dialogueLines[j].pop_at(len(dialogueLines[j]) - 1)
		
	label.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	numOfTurns = get_parent().numOfTurns 
	curQueInt = get_parent().curQueInt
	
	if (numOfTurns >= 5) and (curQueInt < 15):
		canShake = false
		animPlayer.play("Bombhead_Norm")
	elif (numOfTurns < 5) and (numOfTurns >= 3) and (curQueInt < 15):
		canShake = false
		animPlayer.play("Bombhead_Worry")
	elif (numOfTurns < 3) and (numOfTurns >= 1) and (curQueInt < 15):
		canShake = true
		animPlayer.play("Bombhead_Panic")
	else:
		pass
	
	if Input.is_action_just_pressed("Click") and canSkip:
		label.visible = false
		speechBubble.visible = false
		can_proceed.emit()
		canSkip = false
	
	if (canShake):
		position.x = randf_range(-shakeForce, shakeForce)

func talk():
	label.visible = true
	speechBubble.visible = true
	
	if curChrInt < len(currentLine):
		label.text += currentLine[curChrInt]
		#audio.play()
		chrTimer.start()
	elif curChrInt == len(currentLine):
		canSkip = true

func _on_talk_timer_timeout():
	curChrInt += 1
	talk()

func _on_scene_bombhead_talk(talkType: int):
	curDiagLine += 1
	curChrInt = 0
	label.text = ""
	
	var loadRandLineInt = randi_range(0, dialogueLines[talkType].size() - 1)
	currentLine = dialogueLines[talkType][loadRandLineInt]
	
	match(curQueInt):
		6: 
			currentLine += ". The questions are going to get harder..."
		11: 
			currentLine += ". The questions are going to get harder!"
		
	talk()
