
# Notes:
 * subject to change or way it set up


 * https://www.youtube.com/watch?v=WtCqkYxQBDE 3.x
  * time 42.47
```
var hit = node.get_collider()
if hit.has_method('server_apply_damage'):
  if Network.is_server:
    hit.rpc('apply_damage', 1)
  else
    hit.rpx_id(1, 'server_apply_damage', 1)
```
 * https://www.youtube.com/watch?v=bK41GF5sTf4
  * Godot 4's New Networking Nodes


