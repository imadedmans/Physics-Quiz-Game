extends Control

@onready var transAnim = $TransitionAnim
@onready var animPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.volume_db = 0
	MusicPlayer.pitch_scale = 1
	
	transAnim.play("Transition_Right")
	animPlayer.play("Bombhead_Norm")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_classic_mode_pressed():
	MusicPlayer.calmModeActive = false
	transAnim.play("Transition_Left")

func _on_relaxed_mode_pressed():
	MusicPlayer.calmModeActive = true
	transAnim.play("Transition_Left")

func _on_transition_anim_animation_finished(anim_name):
	if anim_name == "Transition_Left":
		get_tree().change_scene_to_file("res://QuizScene.tscn")
