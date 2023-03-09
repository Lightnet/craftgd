extends VehicleBody3D

# https://www.youtube.com/watch?v=zXLpitpFC6E

#var max_rpm = 500
var max_rpm = 200
var max_torque = 150

#func _ready():
	#pass # Replace with function body.
#func _process(delta):
	#pass

func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("right","left") * 0.4, 5 * delta)
	#engine_force = Input.get_axis("back","forward") * 100
	var acceleration = Input.get_axis("back","forward")
	var rpm = abs($rear_left_wheel.get_rpm())
	$rear_left_wheel.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	
	rpm = abs($rear_right_wheel.get_rpm())
	$rear_right_wheel.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	
	
	pass
