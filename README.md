# craftgd

# Godot Version:
 * Godot 4 Stable

# Status:
 * Unstable
 * Prototyping

# Information:
 Working on toward craft build with some simple first person view.

 Will have some element of shooter, farming, buildings and other prototype builds.

 Idea base on minecraft, shooter games, open world and other things.

 Working on sandbox world.

# Design Plans:
 * [ ] Build world with blocks and other types.
 * [ ] Simple combat / movements
  * [ ] fist
	* [ ] knock out
	* [ ] wall jump
	* [ ] wall climb
	* [x] grappling hook

	* [ ] prototype items
		* [x] build tool to place blocks and delete (wip)
		* [x] melee (wip)
		* [x] projectile (wip)
		* [ ] storage menu ( n/a )
		* [ ] npc menu ( n/a )
		* [ ] interact ( n/a )
	* props
		* [ ] out of bounds ( n/a )
		* [ ] damage area ( n/a )
		* [ ] health area ( n/a )
		* [ ] teleport ( n/a )

 * vehicle
	*	[x] simple car ( wip )

# Features / To Do List:
 - [ ] key binding
	-	[x] keyboard (wip / still need work on)
	- [ ] mouse ( n/a )
 - [ ] config
	 - [x] save and load (testing)
 - [x] main menu
 		- [x] Host
		- [x] Join
		- [x] Port
		- [x] IP Address
		- [x] upnp (not tested)
 - [ ] Lobby (wip)
 		- [x] Chat Message
		- [x] Player List
				- [x] kick
				- [ ] pm
		- [x] start game (simple load map and players)
		- [ ] game settings
		- [ ] options
 - [ ] Network (wip)
	- [ ] server (wip)
	  - [x] handle disconnect
	  - [x] handle connect
	- [ ] client (wip)
	  - [x] handle disconnect
	  - [x] handle connect
  
 * Player
	* [x] Simple Capsule
	* [x] Melee weapon (wip)
	* [x] Hit scan weapon (wip)
	* [x] Build blocks ( n/a )
	* [ ] Inventory UI
	* [ ] Hot Bar
	* [ ] Build mode
 * Map
	* [x] Prototype Test01 (wip)
	* [ ] Training Area (wip)
	* [x] Prototype Quick Test (wip)
	* [x] Prototype Offline Test (wip)
	* [x] Vehicle Test Areas (wip)

# To Do List:
 * Player model
 * Buildings
 * Headless server and host server for what ever need to config it.

# Server Headless:
	Host and Headless server are both easy and hard. Required some setup permission to for hosting, players voting. As well game modes types.

	Still required admin login to able to kick player or ban them.

## Design plans:
	* One area need for is handling the multiple servers connecting to each other for multiple hub network.
	* 

# Add ons:
 * panku_console
 * kenney_ui_audio
 * kenney_prototype_textures
 * kenney_particle_pack
 * dialogue_manager
 * 


# Bugs: 
 * Note this project is work in progress. It subject change in dev builds.
 * Host Input Pause when start game if clicked.
 * Host HealthBar not reduce only client works.

# Links:
 * https://www.youtube.com/watch?v=n8D3vEx7NAE
 * https://www.youtube.com/watch?v=ybya2TbHgSE
 * https://godotengine.org
 
# Credits:
 * https://www.youtube.com/@DevLogLogan FPS set up.
