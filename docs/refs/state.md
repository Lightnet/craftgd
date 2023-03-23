# Information:
 * note some information is outdate but base on logic


# Links: 
 * https://github.com/GDQuest/godot-2d-space-game/blob/master/project/Libraries/StateMachine/StateMachine.gd
 * https://github.com/ryash072007/State-Machine-Godot-4
 * https://godottutorials.com/courses/pong-gdscript-series/pong-gdscript-tutorial-04/
 * https://www.youtube.com/watch?v=Ty4wZL7pDME
 * https://github.com/GDQuest/godot-demos/tree/master/2018/04-24-finite-state-machine
 * https://www.reddit.com/r/godot/comments/10hm1np/state_machines_learned_how_and_im_never_going_back/
 * https://www.youtube.com/watch?v=BNU8xNRk_oU
 * 
 * 
 * 
 * https://github.com/GDQuest/godot-demos/tree/master/2018/04-24-finite-state-machine

```
@onready var states = node


func _ready():
  states.init(self)

fun _unhandled_input(event)->void:
  states.input(event)


fun _physics_process(delta:float)->void:
  state.physics_process(delta)
```

```
enum{
  IDLE,
  MOVE,
}

var state = IDLE
```

```
func _process(delta)
  match state:
    IDLE:
      pass
    MOVE:
      pass
```