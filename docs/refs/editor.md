

# Information:
  Editor tool has real time update.

  Note if the scene is not update. It required reopen the scene to make chanages.

```
@tool #top line
extends Node

func _ready():
  if Engine.is_editor_hint(): #run editor
    return

func _process(_delta):
  if Engine.is_editor_hint(): #run editor
    return

func _physics_process(_delta): #run editor
  if Engine.is_editor_hint():
    return
```

# Links:
 * https://docs.godotengine.org/en/stable/tutorials/plugins/running_code_in_the_editor.html
 * https://www.youtube.com/watch?v=TVM3YFewiB8