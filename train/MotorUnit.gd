extends Sprite

signal has_stopped
onready var switch_area2d = $SwitchArea2D

var map: TileMap
var timer = Timer.new()
var dir = global.dir.E
var rot_offset
var next_pos: Vector2
var switch

func _ready():
	map = get_parent().map
	dir = get_parent().dir
	rot_offset = rotation_degrees
	next_pos = global_position
	switch_area2d.connect("area_entered", self, "_on_switch_area2d_area_entered")
	switch_area2d.connect("area_exited", self, "_on_switch_area2d_area_exited")
	get_parent().connect("has_stopped_moving", self, "stop_moving")
	add_child(timer)
	timer.wait_time = .4
	timer.connect("timeout", self, "move")
	timer.start()
	$AnimationPlayer.play("move")

func move():
	var tile_pos = map.world_to_map(global_position)
	var tile_name
	var overlapping_areas = switch_area2d.get_overlapping_areas()
	var switch
	if overlapping_areas.size() > 0:
		switch = overlapping_areas[0].get_parent()
	if switch:
		tile_name = switch.tilename
	else:
		tile_name = map.tile_set.tile_get_name(map.get_cellv(tile_pos))
	#get the direction the track we're on is moving
	dir = global.get_track_dir(tile_name, dir)
	if dir.x == 0 and dir.y == 0:
		emit_signal("has_stopped")
	var angle = global.vector_angle(dir)
	rotation_degrees = angle + rot_offset
	var next_tile = tile_pos + dir
	next_pos = map.map_to_world(next_tile) + map.cell_size/2

func stop_moving(reason: int):
	timer.stop()
	#play explode anim
	if String(name).begins_with("Cab"):
		global_position += Vector2(10,10) * dir
		randomize()
		var val = randi()%30 + 30
		if randi()%2 == 1:
			rotate(deg2rad(val))
		else:
			rotate(deg2rad(-val))

func _physics_process(delta):
	if global_position != next_pos:
		global_position = lerp(global_position, next_pos, .2)