class_name CardData
var name: String
var data_name: String
var scene_path: String
var power: int
var description: String

func _init(name: String, data_name: String, scene_path: String, power: int, description: String) -> void:
	self.name = name
	self.data_name = data_name
	self.scene_path = scene_path
	self.power = power
	self.description = description
