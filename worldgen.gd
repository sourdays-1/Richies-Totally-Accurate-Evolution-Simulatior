extends TileMapLayer

const size : int = 500
const biomes : Array = [
	[0, 0, 1, 12, 2, 2, 3, 3, 4, 4],
	[0, 0, 1, 12, 2, 2, 3, 3, 4, 4],
	[12, 12, 1, 12, 2, 2, 6, 6, 7, 7],
	[12, 12, 12, 12, 8, 8, 6, 6, 7, 7],
	[12, 13, 13, 8, 8, 8, 6, 6, 7, 7],
	[12, 13, 13, 8, 8, 8, 6, 6, 7, 7],
	[9, 9, 13, 8, 8, 8, 6, 6, 7, 7],
	[9, 9, 13, 13, 13, 13, 13, 13, 7, 7],
	[9, 9, 9, 9, 9, 13, 13, 13, 10, 10],
	[11, 11, 11, 11, 11, 11, 11, 13, 10, 10]
]
var seed : int
var fnl := FastNoiseLite.new()
var temp := FastNoiseLite.new()
var rain := FastNoiseLite.new()
var waterLevel = 0.44
var sandLevel = 0.48
var forestLevel = 0.61

func _ready() -> void:
	seed = randi()
	fnl.seed = seed
	fnl.noise_type = FastNoiseLite.TYPE_PERLIN
	fnl.fractal_type = FastNoiseLite.FRACTAL_FBM
	fnl.frequency = 0.02
	
	temp.seed = seed+1
	temp.noise_type = FastNoiseLite.TYPE_PERLIN
	temp.fractal_type = FastNoiseLite.FRACTAL_FBM
	temp.frequency = 0.008
	
	rain.seed = seed+2
	rain.noise_type = FastNoiseLite.TYPE_PERLIN
	rain.fractal_type = FastNoiseLite.FRACTAL_FBM
	rain.frequency = 0.015
	
	print("Seed for terrain generation is %s" % fnl.seed)
	generateMap()

func generateMap() -> void:
	clear()
	for x in size:
		for y in size:
			var noiseVal := (fnl.get_noise_2d(x, y) + 1.0) / 2.0
			var tempVal : int = (((temp.get_noise_2d(x, y) + 1.0) / 2.0) * 10.0) - 1
			var rainVal : int = (((rain.get_noise_2d(x, y) + 1.0) / 2.0) * 10.0) - 1
			var landType : int
			var biome : int = biomes[tempVal][rainVal]
			
			if noiseVal < waterLevel:
				landType = 0
			elif noiseVal < sandLevel:
				landType = 3
			elif noiseVal < forestLevel:
				landType = 1
			else:
				landType = 2
			
			
			set_cell(Vector2i(x, y), 0, Vector2i(landType, biome))
	print("Terrain Generation finished with seed %s" % seed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('dev_regen_terrain'):
		seed = randi()
		fnl.seed = seed
		temp.seed = seed+1
		rain.seed = seed+2
		generateMap()
