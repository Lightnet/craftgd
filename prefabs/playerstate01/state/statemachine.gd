# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
extends Node
class_name StateMachine

# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
#@export var initial_state := NodePath()
@export var initial_state: NodePath

# The current active state. At the start of the game, we get the `initial_state`.
@onready var state: State = get_node(initial_state)

# https://www.reddit.com/r/godot/comments/116w06s/godot_4_how_to_use_await_instead_yield/
func _ready() -> void:
	#yield(owner, "ready") #3.5
	#await [owner, "ready"]
	await owner.ready #4.0 ?
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		#print("STATE NAME: ", child.name)
		child.state_machine = self
	#print(">> STATE NAME: ", state.name)
	state.enter()

# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	#print("UPDATE???")
	#print("state: ", state)
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not has_node(target_state_name):
		return

	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
