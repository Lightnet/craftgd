extends Area3D

# https://www.youtube.com/watch?v=HDPGtOrH67I
# https://godotengine.org/qa/136003/keyword-translation-doesnt-because-variable-should-instead

var dir = Vector3()
var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#150
	#position -= transform.basis.x * 10 * delta
	#position -= transform.basis.z * 10 * delta
	if dir != Vector3.ZERO:
		position -= dir * 10 * delta
	pass


func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= damage
		#body.take_damage(25)
		pass
	queue_free()
	pass # Replace with function body.


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
