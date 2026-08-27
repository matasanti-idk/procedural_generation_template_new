extends Control
@onready var panel: Panel = $Panel
@onready var label: Label = $Label
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var note: Button = $note
@onready var warning_panel: Panel = $"warning panel"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel.visible = !visible
	warning_panel.visible = !visible
	if Globaldata.security_force_reset:
		return
	if Globaldata.file_warning:
		panel.visible = !visible
		v_box_container.visible = !visible
		note.visible = !visible
		label.visible = !visible
		warning_panel.visible = visible
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_make_world_pressed() -> void:
	get_tree().change_scene_to_file("res://procedural_generation_template/pmg.tscn")#its recommened to use the UID 


func _on_continue_pressed() -> void:
	if Globaldata.can_they_continue == false:
		print_rich("[color=red]ERROR user tried to contine with corrupted file data or empty file data cannot continue[/color]")
		return
	Globaldata.did_they_continue = true
	get_tree().change_scene_to_file("res://procedural_generation_template/pmg.tscn")
	

func _on_force_reset_seed_pressed() -> void:
	panel.visible = visible
	v_box_container.visible = !visible
	note.visible = !visible
	label.visible = !visible
	


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_n_reset_pressed() -> void:
	panel.visible = !visible
	v_box_container.visible = visible
	note.visible = visible
	label.visible = visible

func _on_y_reset_pressed() -> void:
	panel.visible = !visible
	v_box_container.visible = visible
	note.visible = visible
	label.visible = visible
	FileData.force_reset()


func _on_button_pressed() -> void:
	Globaldata.file_warning = false
	panel.visible = visible
	v_box_container.visible = visible
	note.visible = visible
	label.visible = visible
	warning_panel.visible = !visible
	
