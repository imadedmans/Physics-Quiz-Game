extends Camera2D

@export var canShake = false
@export var force = 10
@export var timeToShake: float = 2.0

var orgPos: Vector2 = Vector2(0, 0)
var curForce
var curTime

# Called when the node enters the scene tree for the first time.
func _ready():
	curForce = force
	curTime = timeToShake

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if (canShake) && (curTime > 0):
		position.x = randf_range(-curForce, curForce)
		position.y = randf_range(-curForce, curForce)
		curForce = (curTime * force) / timeToShake #1.5 value temp there
		curTime -= delta
	else:
		position = orgPos
		canShake = false
		curForce = force
		curTime = timeToShake
