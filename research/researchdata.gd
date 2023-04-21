extends Resource
class_name ResearchData

@export var name: String = ""
@export_multiline var description: String = ""
@export var points: int = 0
@export var cost: int = 0
@export var level: int = 0
@export var texture:AtlasTexture
@export var requires:Array[ResearchData]
