extends CanvasLayer

@onready var subViewport = $SubViewport

@export var def_camera: Camera2D
@export var pp_camera: Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame #pause the script for just ONE frame
	
	var pixel_perfecto: Array = get_tree().get_nodes_in_group("Pixel Perfect")
	for obj in pixel_perfecto:
		obj.call_deferred("reparent", subViewport, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !pp_camera or !def_camera:
		return
