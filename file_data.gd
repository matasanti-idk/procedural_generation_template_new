extends Node

var data
var ssdata
const SAVE_PATH = "user://file.data"
const SECCURITY_PATH = "user://file_security.data"#you can rename it if you want or add more files
#WARNING#
#------------------
#warning this is not in Json its in binary if you mess with the file direclty you will currupt it 
# and will have to force reset the file lossing any data you saved in the file
#-----------------
#"data": data,
#its recomended to pass data that you want to save
#in a global script to make it temporealy persistent and save 
#if data.has("data"):
	#location of data = data.get("data", [])#note the [] can be anything depening on your data type
		#print(#location of data)
#its recomened to use a gloabla data to then pull from it to use in a desired script
#if not data.is_empty():
		#print("player has data!")
#else:
	#print("they cannot continue") you can change data to make sure if data you wanted to save is there
#note if you want to add color text use this template
#print_rich("[color=coloryouwant] text [/color]")
#if you want to have color parts in a line and normal part use this
#print_rich("[color=coloryouwant] text",data you dont want colored," [/color]")

func _ready() -> void:
	load_from_file()#do not mess with
	_continue()#do not mess with
	Globaldata.check_tsv()



func save_to_file():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		data = {
			"seeds": Globaldata.seeds_list,
			#add data that you want to store here
		}
		file.store_var(data)
		file.flush()
		file.close() # Forces the data onto the hard drive immediately
		print_rich("[color=green]Saved successfully to:[/color] ", ProjectSettings.globalize_path(SAVE_PATH))
	else:
		print_rich("[color=red]Save Failed: Could not open file path.[/color]")




func load_from_file():
	if not FileAccess.file_exists(SAVE_PATH):#check for any data in file
		print_rich("[color=red]No save file found at start.[/color]")
		SSF_CHECK()
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		data = file.get_var()
	if data is not Dictionary:
		Globaldata.security_force_reset = false
		return
			# Only update if the key exists in the file
	if data.has("seeds"):
			Globaldata.dat += 1
			Globaldata.dat += 1# recommended to add this to every type of data you want to check if its in file
			Globaldata.seeds_list = data.get("seeds", [])
			print(Globaldata)
			print_rich("[color=green]Loaded successfully![/color]")
			Globaldata.tsv += 1
			print(Globaldata.seeds_list)


func _continue():
	if not Globaldata.seeds_list.is_empty():
			print("player has seed!")
			Globaldata.tsv += 1
	else:
		print_rich("[color=red]they cannot continue[/color]")



func force_reset():
	SSF_CHECK()#recommened to not mess the code here
	if not FileAccess.file_exists(SAVE_PATH):#check for any data in file
		print_rich("[color=red]No save file found at start.[/color]")
		return
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		data = file.get_var()
		if data is not Dictionary:
			print_rich("[color=red]could not access data file[/color]")
			return 
	
	file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		data = null
		file.store_var(data)
		file.flush()
		file.close() # Forces the data onto the hard drive immediately
		print_rich("[color=red] currputed file [/color]", data)
		print_rich("[color=green] file was reseted to null successfully [/color]", data)
		print_rich("[color=green]updated file successfully to:[/color] ", ProjectSettings.globalize_path(SAVE_PATH))
		SSF_WRITE(true)
		DirAccess.remove_absolute(SAVE_PATH)

func SSF_CHECK():
	print_rich("[color=green]SSF_check[/color]")
	var ssfile = FileAccess.open(SECCURITY_PATH, FileAccess.READ) 
	if ssfile:
		ssdata = ssfile.get_var()
	if ssdata is not Dictionary:
		print(ssdata," is not dictionary")
		return
	if ssdata.has("Force_reset"):
		Globaldata.security_force_reset = ssdata.get("Force_reset")
		#print(Globaldata.security_force_reset)
		print_rich("[color=green]force_reset was executed[/color]")
		
func SSF_WRITE(FR: bool):
	var ssfile = FileAccess.open(SECCURITY_PATH, FileAccess.WRITE)
	if ssfile:
		ssdata = {
			"Force_reset": FR,
			#add data that you want to store here
		}
		print(ssdata)
		ssfile.store_var(ssdata)
		ssfile.flush()
		ssfile.close()
