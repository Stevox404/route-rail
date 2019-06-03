extends Node
class_name global

const dir = {
	N= Vector2(0, -1),
	S= Vector2(0, 1),
	E= Vector2(1, 0),
	W= Vector2(-1, 0),
	NE= Vector2(1, -1),
	NW= Vector2(-1, -1),
	SE= Vector2(1, 1),
	SW= Vector2(-1, 1),
}

static func get_game_node(scene_tree: SceneTree):
	#Use the get_tree() method
	var root = scene_tree.get_root()
	for child in root.get_children():
		if child.name == "Game":
			return child
	GDError.new("Root Game node not found!")

static func quit_game():
	Engine.get_main_loop().quit()

static func get_track_dir(track_name: String, curr_dir: Vector2) -> Vector2:
	var new_dir: Vector2
	match track_name:
		"TracksStraightV":
			if curr_dir.y == 1: #Going S
				new_dir = dir.S
			elif curr_dir.y == -1:
				new_dir = dir.N
		"TracksStraightH":
			if curr_dir.x == 1: #Going E
				new_dir = dir.E
			elif curr_dir.x == -1:
				new_dir = dir.W
		"TracksCurvedSE":
			if curr_dir.y == -1: #Going N
				new_dir = dir.E
			elif curr_dir.x == -1: #Going W
				new_dir = dir.S
		"TracksCurvedSW":
			if curr_dir.x == 1: #Going E
				new_dir = dir.S
			elif curr_dir.y == -1: #Going N
				new_dir = dir.W
		"TracksCurvedNE":
			if curr_dir.y == 1: #Going S
				new_dir = dir.E
			elif curr_dir.x == -1: #Going W
				new_dir = dir.N
		"TracksCurvedNW":
			if curr_dir.x == 1: #Going E
				new_dir = dir.N
			elif curr_dir.y == 1: #Going S
				new_dir = dir.W
#		_: new_dir =  dir.E
		_: new_dir =  Vector2()
		
#	print("Track: ",track_name, ". curr_dir: ",curr_dir, ". new_dir: ",new_dir)
	return new_dir



static func vector_angle(dir: Vector2):
	var x = dir.x
	var y = dir.y
	
	if x == 0: # special cases
        return 90 if (y > 0) else 0 if (y == 0) else 270
	elif (y == 0): # special cases
        return 0 if (x >= 0) else 180
	var ret = rad2deg(atan(y/x))
	if (x < 0 and y < 0): # quadrant Ⅲ
	    ret = 180 + ret
	elif (x < 0): # quadrant Ⅱ
	    ret = 180 + ret # it actually substracts
	elif (y < 0): # quadrant Ⅳ
	    ret = 270 + (90 + ret) # it actually substracts
	return ret