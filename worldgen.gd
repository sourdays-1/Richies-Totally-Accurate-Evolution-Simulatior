extends TileMapLayer

const size : int = 150
var fnl := FastNoiseLite.new()

func _ready() -> void:
	fnl.seed = randi_range(1, 10000000)
	fnl.noise_type = FastNoiseLite.TYPE_PERLIN
	fnl.fractal_type = FastNoiseLite.FRACTAL_FBM
	print(fnl.seed)
	generateMap()

func generateMap() -> void:
	clear()
	for x in size:
		for y in size:
			var noiseVal := fnl.get_noise_2d(x, y)
			if noiseVal < 0.14:
				set_cell(Vector2i(x, y), 0, Vector2i(1, 1))
			else:
				set_cell(Vector2i(x, y), 0, Vector2i(4, 2))
