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

#static func get_track_dir(track_name: String, curr_dir: Vector2) -> Vector2:
#	var new_dir: Vector2
#	match track_name:
#		"TracksStraightV":
#			if curr_dir.y != 0:
#				new_dir = Vector2(0, curr_dir.y) # N | S
#			else:
#				new_dir = dir.NORTH
#		"TracksStraightH":
#			if curr_dir.x != 0:
#				new_dir = Vector2(curr_dir.x, 0) # E | W
#			else:
#				new_dir = dir.EAST
#		"TracksCurvedSE":
#			if curr_dir.x == -1:
#				new_dir = Vector2(-1, 1) # SW
#			elif curr_dir.y == -1:
#				new_dir = Vector2(1, -1) # NE
#			if curr_dir == new_dir:
#				new_dir = Vector2(max(curr_dir.x, 0), max(curr_dir.y, 0))
#		"TracksCurvedSW":
#			new_dir = Vector2(0,1)
##			if curr_dir.x == 1:
##				new_dir = Vector2(1, 1) # SE
##			elif curr_dir.y == -1:
##				new_dir = Vector2(-1, -1) # NW
##			if curr_dir == new_dir:
##				new_dir = Vector2(min(curr_dir.x, 0), max(curr_dir.y, 0))
#		"TracksCurvedNE":
#			if curr_dir.x == -1:
#				new_dir = Vector2(-1, -1) # NW
#			elif curr_dir.y == 1:
#				new_dir = Vector2(1, 1) # SE
#			if curr_dir == new_dir:
#				new_dir = Vector2(max(curr_dir.x, 0), min(curr_dir.y, 0))
#		"TracksCurvedNW":
#			if curr_dir.x == 1:
#				new_dir = Vector2(1, -1) # NE
#			elif curr_dir.y == 1:
#				new_dir = Vector2(-1, 1) # SW
#			if curr_dir == new_dir:
#				new_dir = Vector2(min(curr_dir.x, 0), min(curr_dir.y, 0))
#		_: new_dir =  dir.EAST
#
##	print("Track: ",track_name, ". curr_dir: ",curr_dir, ". new_dir: ",new_dir)
#	return new_dir


static func get_track_dir(track_name: String, curr_dir: Vector2) -> Vector2:
	var new_dir: Vector2
	match track_name:
		"TracksStraightV":
			if curr_dir.y == 1: #Going S
				new_dir = dir.S
			else:
				new_dir = dir.N
		"TracksStraightH":
			if curr_dir.x == 1: #Going E
				new_dir = dir.E
			else:
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
		_: new_dir =  dir.E
		
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