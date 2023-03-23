# Boilerplate class to get full autocompletion and type checks for the `player` when coding the player's states.
# Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.
extends State
class_name PlayerState

# Typed reference to the player node.
var player: Player

func _ready() -> void:
	# The states are children of the `Player` node so their `_ready()` callback will execute first.
	# That's why we wait for the `owner` to be ready first.
	#yield(owner, "ready")
	await owner.ready
	# The `as` keyword casts the `owner` variable to the `Player` type.
	# If the `owner` is not a `Player`, we'll get `null`.
	player = owner as Player
	# This check will tell us if we inadvertently assign a derived state script
	# in a scene other than `Player.tscn`, which would be unintended. This can
	# help prevent some bugs that are difficult to understand.
	assert(player != null)

func enter(_msg := {}) -> void:
	#player.velocity = Vector3.ZERO
	pass

func physics_update(_delta: float) -> void:
	#if not player.is_on_floor():
		#state_machine.transition_to("Air")
		#return

	#if Input.is_action_just_pressed("jump"):
		#state_machine.transition_to("Air", {do_jump = true})
	#elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		#state_machine.transition_to("Run")
	pass
