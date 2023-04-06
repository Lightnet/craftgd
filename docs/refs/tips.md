

# Information:
  Simple tips to remember for easy for access node tree.


* https://docs.godotengine.org/en/stable/classes/class_scenetree.html#class-scenetree-method-call-group
  Simple call by using tree and group.

```
# group, func, args.
get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
```
  Need to set up group tag in scene from node.

  Need to match script func to pass args.




## await time out:
```
await get_tree().create_timer(time).timeout
```

# Collision:
 * bug when the melee inside collision that will not trigger damage.
