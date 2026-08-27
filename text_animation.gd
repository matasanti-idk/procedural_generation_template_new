class_name text_animation
extends Node

@export var visible_characters_behavior: TextServer.VisibleCharactersBehavior 
@export var time : float = 1.0 
@export var node_1: Node 
@export var times_played: int = 1 
@export var repeat_on_visible: bool = true

var times_that_was_played: int = 0 
var target : Control 
var is_playing: bool = false
var was_hidden: bool = true 

func _ready() -> void: 
	target = get_parent()

func _process(_delta: float) -> void: 
	start_when_visible() 

func start_when_visible():
	var currently_visible = target.is_visible_in_tree()
	
	if currently_visible and was_hidden:
		was_hidden = false
		if repeat_on_visible:
			times_that_was_played = 0 

	if not currently_visible: 
		was_hidden = true 
		return 
		
	if is_playing:
		return
		
	set_animation() 

func set_animation(): 
	if times_that_was_played >= times_played: 
		return 
	if not node_1: 
		return 
	is_playing = true
	node_1.visible_characters_behavior = visible_characters_behavior 
	node_1.visible_characters = 0 
	var total_characters = node_1.get_total_character_count() 
	var tween = create_tween() 
	tween.tween_property(node_1, "visible_characters", total_characters, time) 
	times_that_was_played += 1
	tween.finished.connect(func(): is_playing = false)
