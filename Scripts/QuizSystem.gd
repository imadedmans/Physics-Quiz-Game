extends Control

@onready var questionLabel = $TopPanel/QuestionLabel
@onready var qnumLabel = $TopPanel/QNumLabel
@onready var scoreLabel = $TopPanel/ScoreLabel
@onready var timerLabel = $TopPanel/TimerLabel
@onready var waitTimer = $WaitTimer
@onready var questionTimer = $QuestionTimer
@onready var healthBar = $ButtonPanel/HealthBar

@onready var optionButtonA = $ButtonPanel/OptionAButton
@onready var optionButtonB = $ButtonPanel/OptionBButton
@onready var optionButtonC = $ButtonPanel/OptionCButton
@onready var optionButtonD = $ButtonPanel/OptionDButton

@onready var resultCorrectAns = $ResultsPanel/ResultLabel
@onready var resultLives = $ResultsPanel/ResultLabel2
@onready var resultScore = $ResultsPanel/ResultLabel3

@onready var bombhead = $DrTypicalBombhead
@onready var resultsPanel = $ResultsPanel
@onready var camera = $Camera2D
@onready var animPlayer = $AnimationPlayer
@onready var transAnim = $TransitionAnim
@onready var damageSFX = $DrTypicalBombhead/TheDamage

@export var deathAnimFinish = false
@export var winAnimFinish = false
@export var canChangeScene = false

var questionTxt
var answerTxt

var questions = []
var corAnsInt = []
var optionAns = []
var quesAnswered = [] #Stores Question ints already answered

var curQueInt: int = 5
var randomQueInt: int = 0

var numOfTurns: int = 6
var score: int = 0
var switchQ: bool = true
var numOfCorAns: int = 0
var loadWinResults: bool = false

var startQueInt: int = 1
var endQueInt: int = 5

var easyPoint = Vector2i(1, 6)
var midPoint = Vector2i(7, 11)
var hardPoint = Vector2i(12, 15)
var talkInt = 0
var restartScene: bool = false

signal bombhead_talk(talkType: int)

func _ready():
	transAnim.play("Transition_Right")
	disable_buttons(true)
	
	questions = txtHandler(StringManager.questionsString)
	var answerSet = txtHandler(StringManager.answersString)
	
	for g in range(len(questions)):
		var ansArray = answerSet[g].split("|")
		corAnsInt.append(int(ansArray[4]))
		ansArray.remove_at(4)
		optionAns.append(ansArray)
	
	startQueInt = easyPoint.x
	endQueInt = easyPoint.y
	
	MusicPlayer.volume_db = 0
	MusicPlayer.pitch_scale = 1
	deathAnimFinish = false
	winAnimFinish = false
	load_question()

func _process(delta):
	var qNumText = clamp(curQueInt, 1, 15)
	qnumLabel.text = "Question " + str(qNumText)
	timerLabel.text = "Time Left: " + str(int(questionTimer.time_left + 1))
	healthBar.value = numOfTurns * 10
	
	if (deathAnimFinish):
		bombhead_talk.emit(4)
		deathAnimFinish = false
	
	if (winAnimFinish):
		bombhead_talk.emit(5)
		loadWinResults = true
		winAnimFinish = false

func rand_num_gen():
	var daNum = randi_range(startQueInt, endQueInt) - 1
	var canProceed = false
	
	while !canProceed:
		canProceed = true
		for t in range(len(quesAnswered)):
			if daNum == quesAnswered[t]:
				canProceed = false
				daNum = randi_range(startQueInt, endQueInt) - 1
	
	quesAnswered.append(daNum)
	#print(quesAnswered)
	return daNum

func load_question():
	disable_buttons(false)
	randomQueInt = rand_num_gen()
	var i = randomQueInt
	
	questionLabel.text = questions[i]
	optionButtonA.text = "1. " + optionAns[i][0]
	optionButtonB.text = "2. " + optionAns[i][1]
	optionButtonC.text = "3. " + optionAns[i][2]
	optionButtonD.text = "4. " + optionAns[i][3]
	
	switchQ = true
	questionTimer.start()

func answer_question (a: int, timedOut: bool):
	if(switchQ):
		if (a == corAnsInt[randomQueInt]):
			score += 100
			if (numOfTurns < 6):
				numOfTurns += 1
			numOfCorAns += 1
			talkInt = 0
			questionLabel.text = "Correct!"
		elif (timedOut):
			questionLabel.text = "Ran out of time!"
			if (!MusicPlayer.calmModeActive):
				numOfTurns -= 2
			
			talkInt = 2
			damageSFX.play()
			camera.canShake = true
		else:
			questionLabel.text = "Wrong! the correct answer is " + str(corAnsInt[randomQueInt])
			if (!MusicPlayer.calmModeActive):
				numOfTurns -= 2
				
			talkInt = 1
			damageSFX.play()
			camera.canShake = true
		
		questionTimer.paused = true
		if (numOfTurns < 0):
			numOfTurns = 0
		
		var scoreText = "Score: " + str(score)
		scoreLabel.text = scoreText
		waitTimer.start()
		disable_buttons(true)
		switchQ = false

func txtHandler(fileName: String):
	#var txtFile = FileAccess.open(fileName, FileAccess.READ)
	#var array2Use = txtFile.get_as_text().split("\n")
	#var txtFile = load(fileName)
	#var array2Use = txtFile.textString
	
	var array2Use = fileName.split("\n")
	
	var j = 0
	while j < len(array2Use):
		if array2Use[j].is_empty():
			array2Use.remove_at(j)
		j += 1
	
	j = 0
	while j < len(array2Use):
		if array2Use[j].contains("@"):
			array2Use.remove_at(j)
		j += 1
	
	return array2Use

func results():
	resultCorrectAns.text = "Correct answers: " + str(numOfCorAns) + "/15"
	resultLives.text = "Lives left: " + str(numOfTurns) + "/6"
	resultScore.text = "Total score: " + str(score)

	questionTimer.paused = true
	MusicPlayer.volume_db = -10
	animPlayer.play("GetResults")

func _on_wait_timer_timeout():
	if numOfTurns <= 0:
		MusicPlayer.stop()
		animPlayer.play("Lose")
		camera.canShake = true
	else:
		curQueInt += 1
		
		match(curQueInt):
			7:
				MusicPlayer.pitch_scale = 1.1
				startQueInt = midPoint.x
				endQueInt = midPoint.y
			12:
				MusicPlayer.pitch_scale = 1.2
				startQueInt = hardPoint.x
				endQueInt = hardPoint.y
	
		if numOfTurns <= 2:
			talkInt = 3
	
		bombhead_talk.emit(talkInt)

func disable_buttons(canDisable: bool):
	optionButtonA.disabled = canDisable
	optionButtonB.disabled = canDisable
	optionButtonC.disabled = canDisable
	optionButtonD.disabled = canDisable

func _on_question_timer_timeout():
	answer_question(0, true)

func _on_option_a_button_pressed():
	answer_question(1, false)

func _on_option_b_button_pressed():
	answer_question(2, false)

func _on_option_c_button_pressed():
	answer_question(3, false)

func _on_option_d_button_pressed():
	answer_question(4, false)

func _on_retry_button_button_down():
	MusicPlayer.play()
	transAnim.play("Transition_Left")
	restartScene = true

func _on_quit_button_button_down():
	MusicPlayer.play()
	transAnim.play("Transition_Left")
	restartScene = false

func _can_proceed():
	if numOfTurns <= 0:
		results()
	elif curQueInt > 15:
		if (loadWinResults):
			results()
		else:
			bombhead.frame = 0
			animPlayer.play("WackJob")
	else:
		#curQueInt += 1
		questionTimer.paused = false
		load_question()


func _on_transition_anim_animation_finished(anim_name):
	if anim_name == "Transition_Left":
		if (restartScene):
			get_tree().reload_current_scene() 
		else:
			get_tree().change_scene_to_file("res://TitleScreen.tscn")
