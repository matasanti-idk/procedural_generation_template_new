extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	commmands()
	
func commmands() -> void:
	if Input.is_action_just_pressed("force_quit"):
		get_tree().quit()
		print_rich("[color=yellow]game was forcefully quited[/color]")
