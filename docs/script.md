# Information:
 Scripting can be easy depend what part need to code correctly.

## preset funcs:
```
func _ready():
func _unhandled_input(_event):
func _physics_process(_delta):
func _process(delta):
func _enter_tree():
```





```godot
@export var foo:bool = false # editor param
```

```godot
@onready var bar:bool = false # loaded ???
```

```
@onready var path = $"../../.." # up path
```

```
@onready var path = $"." #current node path
```