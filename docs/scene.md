

 * https://www.youtube.com/shorts/1qGteNvmavI

```
func save(id):
  var pack_scene = PackedScene.new()
  pack_scene.pack(get_tree().get_current_scene())
  ResourceSave.save("res://save"+str(id)+".tscn", pack_scene)

func loadsave(id)
  get_tree().change_scene("res://save"+str(id)+".tscn")
```

need to use 
```
@export #to save data
```