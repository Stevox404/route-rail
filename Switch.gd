tool

extends Button
enum straightExits {Vert, Hor}
enum curvedExits {SE, SW, NE, NW,}

export (straightExits) var dir1 = straightExits.Vert setget set_dir1
export (curvedExits) var dir2 = curvedExits.SE setget set_dir2
export (bool) var switched = false setget set_switched

onready var arrStraight = $ArrowStraight
onready var arrCurved = $ArrowCurved

var tilename = "TracksStraightV"

func _ready():
	connect("pressed", self, "handle_press")
	update_btn()

func set_dir1(val):
	dir1 = val
	update_btn()

func set_dir2(val):
	dir2 = val
	update_btn()

func set_switched(val):
	switched = val
	update_btn()

func update_btn():
	if !arrStraight or !arrCurved:
		return
	
	arrStraight.visible = !switched
	arrCurved.visible = switched
	
	if !switched:
		match dir1:
			straightExits.Vert:
				arrStraight.rotation_degrees = 0
				tilename = "TracksStraightV"
			straightExits.Hor:
				arrStraight.rotation_degrees = 90
				tilename = "TracksStraightH"
			_: 
				tilename = "TracksStraightV"
	else:
		match dir2:
			curvedExits.SE:
				arrCurved.rotation_degrees = 0
				tilename = "TracksCurvedSE"
			curvedExits.SW:
				arrCurved.rotation_degrees = 90
				tilename = "TracksCurvedSW"
			curvedExits.NW:
				arrCurved.rotation_degrees = 180
				tilename = "TracksCurvedNW"
			curvedExits.NE:
				arrCurved.rotation_degrees = 270
				tilename = "TracksCurvedNE"
			_:
				tilename = "TracksCurvedSE"

func handle_press():
	switched = !switched
	update_btn()