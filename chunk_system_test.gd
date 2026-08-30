extends Node2D
@onready var area_2d: Area2D = $Area2D
@onready var cam_movement: Cam_Movement = $Cam_Movement
var right_x = 320
var left_x = -320
var up_y = -160
var down_y = 320
var x = 0
var y = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.global_position = Vector2(0,0)
	pass # Replace with function body


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(cam_movement.global_position)
	move_chunk()
		
func move_chunk():
	if cam_movement.global_position > Vector2(right_x,0):
		area_2d.global_position = cam_movement.global_position + Vector2(160,0)
		right_x = right_x+320
		
	elif cam_movement.global_position < Vector2(left_x+right_x,0):
		area_2d.global_position = cam_movement.global_position - Vector2(160,0)
		right_x = right_x-320
		
	if cam_movement.global_position < Vector2(0,up_y):
		area_2d.global_position = cam_movement.global_position - Vector2(0,160)
		up_y = up_y - 320
		print(1)
		
	elif cam_movement.global_position > Vector2(0,down_y+up_y):
		area_2d.global_position = cam_movement.global_position + Vector2(0,160)
		up_y = up_y + 320
		print(2)
	#elif cam_movement.global_position < Vector2(right_x+left_x,0):
		#area_2d.global_position = cam_movement.global_position - Vector2(160,0)
		#left_x = left_x-320
