extends Node2D
# so the goal is to use 3 noise layer the i have is using predfkeys and we DgenIDs
# to get 3 tiles 

#for addictional noise layers you may want you just have to use this template and re-name them
#@export var noise_text: NoiseTexture2D
#for _ready()
#noise = noise_text
#noise.noise.seed = seeds
#for world_generation()
#var noise_value: float = noise.noise.get_noise_2d(x, y)
#func noise_layer_check(noise_num: float, x: int, y: int, prefix: String):
	#var ID_num: String = ""
	#if #:
	#	ID_num = "1"
	#elif # && temp_num < #:
	#	ID_num = "2"
	#elif # && temp_num < #:
	#	ID_num = "3"
	#elif # && temp_num < #:
	#	ID_num = "4"
	#else:
	#	pass
		#fallback error we will spawn error tiles
	#return prefix + ID_num
	#for place_tiles()
	#tile_data = noise_check(noise_value, x, y, prefix)


@export var temp_noise_text: NoiseTexture2D
@export var elevation_noise_text: NoiseTexture2D
@export var height_noise_text: NoiseTexture2D
@onready var layer_0: TileMapLayer = $layer_0


const source_id = 0
var width: int = 500
var length: int = 500
var rng = RandomNumberGenerator.new()
var water_range: float = 0.4343
var land_range: float = 0.54343
var temp_noise
var elevation_noise
var height_noise
var seeds = 0
var cells_set: int = 0
var cells_water_set: int = 0
var cells_sand_set: int = 0
var cells_land_set: int = 0

func _ready() -> void:
	print_rich("tiles keys: ","[color=green]", GlobalIdLib.tiles_dictionary.keys(),"[/color]")
	temp_noise = temp_noise_text
	elevation_noise = elevation_noise_text
	height_noise = height_noise_text
	
	seed_generator()
	
	temp_noise.noise.seed = seeds
	elevation_noise.noise.seed = seeds
	height_noise.noise.seed = seeds
	world_generation()
	FileData.save_to_file()
	pass

func seed_generator() -> void:
	print(Globaldata.seeds_list)
	if Globaldata.did_they_continue and Globaldata.can_they_continue:
		FileData.load_from_file()
		seeds = Globaldata.seeds_list[0]
		print(Globaldata.seeds_list)
		print(seeds)
		print_rich("[color=green] was able to load seed from file successfuly[/color]")
		return
	seeds = rng.randi_range(-999999999, 999999999)
	Globaldata.seeds_list.append(seeds)
	print(Globaldata.seeds_list)
	print(seeds)
	
func world_generation() -> void:
	for x in width:
		for y in length:
			var temp_value: float = temp_noise.noise.get_noise_2d(x,y)
			var height_value: float = height_noise.noise.get_noise_2d(x, y)
			var elevation_value: float = elevation_noise.noise.get_noise_2d(x, y)
			var ID: String = ""
			if height_value > land_range:
				ID = "1"
				place_tiles(temp_value,elevation_value,x,y,ID)
				cells_land_set += 1
				cells_set += 1
			elif height_value < water_range:
				ID = "3"
				place_tiles(temp_value,elevation_value,x,y,ID)
				cells_water_set += 1
				cells_set += 1
			else:
				ID = "2"
				place_tiles(temp_value,elevation_value,x,y,ID)
				cells_sand_set += 1
				cells_set += 1
	print_rich("[color=green]Passed Procedrucarl Generation: [/color]", "map size ",width*length,)
	print_rich("[color=yellow]Total cells set: [/color]", cells_set)
	print_rich("[color=yellow]Layer cell count: [/color]", layer_0.get_used_cells().size())
	print_rich("[color=yellow]land cell placed: [/color]", cells_land_set, "[color=yellow] sand cell placed: [/color]", cells_sand_set, "[color=yellow] water cell placed: [/color]", cells_water_set)
	print_rich("layer visable: ", "[color=yellow]",layer_0.visible,"[/color]")
			
			

func temp_check(temp_num: float, x: int, y: int, prefix: String):
	var ID_num: String = ""
	if 0.858:
		ID_num = "1"
	elif 0.703 && temp_num < 0.859:
		ID_num = "2"
	elif 0.568 && temp_num < 0.704:
		ID_num = "3"
	elif 0.458 && temp_num < 0.569:
		ID_num = "4"
	else:
		pass
		#fallback error we will spawn error tiles
		print_rich('[color=red] ERROR out of bounds noise value could not process in "temp_check" Stirng ID generated was[/color]',prefix)
	return prefix + ID_num
func elevation_check(elevatiom_num: float, x: int, y: int, prefix: String):
	var ID_num: String = ""
	if 0.858:
		ID_num = "1"
	elif 0.703 && elevatiom_num < 0.859:
		ID_num = "2"
	elif 0.568 && elevatiom_num < 0.704:
		ID_num = "3"
	elif 0.458 && elevatiom_num < 0.569:
		ID_num = "4"
	else:
		ID_num = "4"
		#fallback error we will spawn error tiles
		print_rich('[color=red] ERROR out of bounds noise value could not process in "elevation_check" Stirng ID generated was [/color]',prefix)
	return prefix + ID_num
	#to add a parameter for noise_value insert noise_value:float,
	#example: 
	#before- place_tiles(temp_value:float, el_value:float, x:int, y: int, prefix: String) -> void:
	#after- place_tiles(noise_value:float, temp_value:float, el_value:float, x:int, y: int, prefix: String) -> void:
func place_tiles(temp_value:float, el_value:float, x:int, y: int, prefix: String) -> void:
	var tile_data
	tile_data = temp_check(temp_value, x, y, prefix)
	tile_data = elevation_check(el_value, x, y, tile_data)
	#place for tile_data expansion
	#print(tile_data)
	var atls_cord = GlobalIdLib.tiles_dictionary.get(tile_data)
	#print(atls_cord)
	layer_0.set_cell(Vector2i(x,y),source_id,atls_cord)
