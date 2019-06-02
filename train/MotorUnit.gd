extends Sprite

var map: TileMap
var timer = Timer.new()
var dir = global.dir.E
var rot_offset

func _ready():
	map = get_parent().map
	rot_offset = rotation_degrees
	add_child(timer)
	timer.wait_time = .2
	timer.connect("timeout", self, "move")
	timer.start()

func move():
	var tile_pos = map.world_to_map(global_position)
	var tile_name = map.tile_set.tile_get_name(map.get_cellv(tile_pos))
	#get the direction the track we're on is moving
	dir = global.get_track_dir(tile_name, dir)
	var angle = global.vector_angle(dir)
	rotation_degrees = angle + rot_offset
	var next_tile = tile_pos + dir
	var next_pos = map.map_to_world(next_tile) + map.cell_size/2
	global_position = next_pos