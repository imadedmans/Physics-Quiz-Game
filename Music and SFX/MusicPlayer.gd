extends AudioStreamPlayer

@export var calmModeActive: bool = false

func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		print("See ya")
		get_tree().quit()

func _on_finished():
	play()
