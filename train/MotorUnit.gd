extends Sprite

onready var switch_area2d = $SwitchArea2D

var map: TileMap
var timer = Timer.new()
var dir = global.dir.E
var rot_offset
var next_pos: Vector2
var switch

func _ready():
	map = get_parent().map
	rot_offset = rotation_degrees
	next_pos = global_position
	switch_area2d.connect("area_entered", self, "_on_switch_area2d_area_entered")
	switch_area2d.connect("area_exited", self, "_on_switch_area2d_area_exited")
	add_child(timer)
	timer.wait_time = .3
	timer.connect("timeout", self, "move")
	timer.start()

func move():
	var tile_pos = map.world_to_map(global_position)
	var tile_name
	if switch:
		tile_name = switch.tilename
	else:
		tile_name = map.tile_set.tile_get_name(map.get_cellv(tile_pos))
	print(tile_name)
	#get the direction the track we're on is moving
	dir = global.get_track_dir(tile_name, dir)
	print(dir)
	var angle = global.vector_angle(dir)
	rotation_degrees = angle + rot_offset
	var next_tile = tile_pos + dir
	next_pos = map.map_to_world(next_tile) + map.cell_size/2

func _on_switch_area2d_area_entered(area: Area2D):
	var parent = area.get_parent()
	if parent.name == "Switch":
		switch = parent

func _on_switch_area2d_area_exited(area: Area2D):
	var parent = area.get_parent()
	if switch == parent:
		switch = null

func _physics_process(delta):
	if global_position != next_pos:
		global_position = lerp(global_position, next_pos, .2)