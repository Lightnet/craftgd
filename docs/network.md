# Links: 
 * https://docs.godotengine.org/en/stable/tutorials/networking/high_level_multiplayer.html
 * https://docs.godotengine.org/en/latest/classes/class_enetmultiplayerpeer.html#class-enetmultiplayerpeer
 * 
 * 


Initializing as a server, listening on the given port, with a given maximum number of peers:
```gd
var peer = NetworkedMultiplayerENet.new()
peer.create_server(SERVER_PORT, MAX_PLAYERS)
get_tree().network_peer = peer
```
Initializing as a client, connecting to a given IP and port:
```
var peer = NetworkedMultiplayerENet.new()
peer.create_client(SERVER_IP, SERVER_PORT)
get_tree().network_peer = peer
```


Get the previously set network peer:
```
get_tree().get_network_peer()1
```
Checking whether the tree is initialized as a server or client:
```
get_tree().is_network_server()
```
Terminating the networking feature:
```
get_tree().network_peer = null
```

Server and Clients:
```
network_peer_connected(int id)
network_peer_disconnected(int id)
```


## RPC
To communicate between peers, the easiest way is to use RPCs (remote procedure calls). This is implemented as a set of functions in Node:
```
rpc("function_name", <optional_args>)

rpc_id(<peer_id>,"function_name", <optional_args>)

rpc_unreliable("function_name", <optional_args>)

rpc_unreliable_id(<peer_id>, "function_name", <optional_args>)
```

## Back to lobby:

```py
# Typical lobby implementation; imagine this being in /root/lobby.

extends Node

# Connect all functions

func _ready():
    get_tree().network_peer_connected.connect(_player_connected)
    get_tree().network_peer_disconnected.connect(_player_disconnected)
    get_tree().connected_to_server.connect(_connected_ok)
    get_tree().connection_failed.connect(_connected_fail)
    get_tree().server_disconnected.connect(_server_disconnected)

# Player info, associate ID to data
var player_info = {}
# Info we send to other players
var my_info = { name = "Johnson Magenta", favorite_color = Color8(255, 0, 255) }

func _player_connected(id):
    # Called on both clients and server when a peer connects. Send my info to it.
    rpc_id(id, "register_player", my_info)

func _player_disconnected(id):
    player_info.erase(id) # Erase player from info.

func _connected_ok():
    pass # Only called on clients, not server. Will go unused; not useful here.

func _server_disconnected():
    pass # Server kicked us; show error and abort.

func _connected_fail():
    pass # Could not even connect to server; abort.

remote func register_player(info):
    # Get the id of the RPC sender.
    var id = get_tree().get_rpc_sender_id()
    # Store the info
    player_info[id] = info

    # Call function to update lobby UI here
```




 * https://godotengine.org/article/godot-4-0-sets-sail/?ref=upstract.com
```py
@rpc("any_peer","call_local")
func _request_action(dir, shoot_request)-> void:
    if not multiplayer.is_server():
        return
    var id = multiplayer.get_remote_sender_id()
```


```
```
