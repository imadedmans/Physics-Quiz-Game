extends Sprite2D

@onready var particles = $CPUParticles2D

@export var easyColor: Color
@export var mediumColor: Color
@export var hardColor: Color

var transLerpIntA = 0
var transLerpIntB = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self_modulate = easyColor
	particles.emitting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var curQueInt = get_parent().curQueInt 
	
	if (curQueInt >= 7) && (transLerpIntA < 1):
		transLerpIntA += 0.02
		self_modulate = lerp(easyColor, mediumColor, transLerpIntA)
		
	if (curQueInt >= 12) && (transLerpIntB < 1):
		transLerpIntB += 0.02
		self_modulate = lerp(mediumColor, hardColor, transLerpIntB)
