class_name Cam_Movement extends Camera2D
@onready var camera_2d: Camera2D = $"."
var y = 0
@export var speed = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
 
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Vector2.ZERO
	if Input.is_action_pressed("mv_right"):
		direction.x += 1
	if Input.is_action_pressed("mv_left"):
		direction.x -= 1
	if Input.is_action_pressed("mv_down"):
		direction.y += 1
	if Input.is_action_pressed("mv_up"):
		direction.y -= 1
	global_position += direction.normalized() * speed * delta
