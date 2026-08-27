class_name Button_Animation extends Node

#if you want to note have set everything manually over and over againg
#its recommended to change them to your more used setting to save time
#---------------------------------------------------------------------
@export var from_center : bool = true
@export var hover_scale : Vector2 = Vector2(1,1)
@export var time : float = 0.1
@export var transition_type : Tween.TransitionType
#---------------------------------------------------------------------

var target : Control
var default_scale : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_parent()
	conneting_signals()
	call_deferred("setup")


func conneting_signals() -> void:
	target.mouse_entered.connect(on_hover)
	target.mouse_exited.connect(off_hover)



func setup() -> void:
	if from_center:
		target.pivot_offset = target.size / 2
	default_scale = target.scale


func on_hover() -> void:
	add_tween("scale", hover_scale, time)


func off_hover() -> void:
	add_tween("scale", default_scale, time)
	
func add_tween(property: String, value, seconds: float) -> void:
	var tween = create_tween()
	tween.tween_property(target, property, value, seconds).set_trans(transition_type)
