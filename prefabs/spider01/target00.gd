extends Marker3D

var points = [
	Vector3(0,-0.225,-6.0),
	Vector3(0,-0.225,6.0),
	Vector3(6,0,6.0),
]
var count = 0
var pathmax = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print("count: ",count," DIS: ", position.distance_to(points[count]))
	if floor(position.distance_to(points[count])) <= 0:
		count+=1
		if count > pathmax:
			count = 0
	var dir = (points[count] - position).normalized()
	dir = dir * 0.1
	translate(dir)
	pass
