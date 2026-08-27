extends Node
var land_cords_x = []
var land_cords_y = []
var seeds_list = []
var can_they_continue: bool = false
var did_they_continue: bool = false
var tsv: int = 0
var dat: int = 0
var dat_int_pass: int = 2# for ever dat you use to check you what if you file have espesfic data add 1 + number
var file_warning: bool = false
var security_force_reset: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_notes()
	dat_check()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func check_tsv():
	if tsv != 2 or  security_force_reset != true:
		print(security_force_reset)
		print_rich("[color=red]ERROR accured during 2 step verifacation of seed in TSV check file data system unless file was forced reseted[/color]")
	else:
		print_rich("[color=green]Passed TSV verifacation[/color]")
		can_they_continue = true

func dat_check():
	if security_force_reset:
		return
		print_rich("[color=green]Passed DAT verifacation[/color]")
		print_rich("[color=green]Passed Force Reset verifacation[/color]")
	if dat != dat_int_pass:
		file_warning = true
		return
	print_rich("[color=green]Passed DAT verifacation[/color]")
func start_notes():
	print("#-------------------------------------------------------------------------------------------------------------------------------------------")
	print("hello this is a template for Procedural map generation MIT licence")
	print("In this template their are pre-made fetures like save file system, world generation, documention, templates for expantions and data warrings")
	print("all buttons that change scene are in readedble text which is recommend to switch to their UID if you change the folder location")
	print("its highly recommend to check out the code to see the expantion templates provided as well to see possible risks of not do properly")
	print('to have access to more information of the feature provided and how they work you can click on "notes" to see')
	print("this template is provided as bare bone for user customisaion and a higher quility code than most tutorials")
	print('if you ever get stuck a basic force close feature is added press " Ctrl + Windows + Shift + Esc "')
	print('enjoy!!(to turn this comments off at the start of program go to "globaldata.gd" and remove "start_notes()" inside the "_ready()")')
	print("#-------------------------------------------------------------------------------------------------------------------------------------------")
	print("")
