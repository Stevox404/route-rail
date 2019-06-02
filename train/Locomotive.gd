extends Node

var map: TileMap

func _enter_tree():
	map = get_parent()
	if map == null or !(map is TileMap):
		GDError.new("Locomotive must be child of TileMap!", true)