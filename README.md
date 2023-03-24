# craftgd

# Godot Version:
 * Godot 4 Stable

# Status:
 * Unstable
 * Prototyping

# Information:
 Working on toward craft build with some simple first person view and sandbox world for test each components for able to handle entity components.

 Idea base on minecraft, shooter games, farming, open world and other prototype builds.

 Working toward module components to handle inventory, item, weapon, equipement, state machine and to handle entity nodes branches.

## Notes:
 * work in progress.

## Layout Entity:
	* CharacterBody3D (player)
		* Script
			*	inventory
			* equip inventory
		* Collision
		* skeleton mesh
		* animation player
		* animation tree 
	  * State Machine [Script]
			*	Idle [Script]
			*	Run [Script]
			*	Jump [Script]
		* Tool / Weapon / Handle [Script]
			*	Sword [Script]
		* Equip [Script]
			* Head [Script]
			* Chest [Script]
			* Foot [Script]
			* Hand [Script]
		* Skills [Script]?
			* regan [Script]
			* fireball [Script]

	Reason that Godot 4.0 any things can be editable that use class base that filter out components. They are subject to changes.

 There is video guide about the class_name and resource object.

* https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html
* https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html

# Design state machine:

	Work in progress. Thinking of state module system. One reason is to keep the script simple for logic system for movements.

	As well npc and mobs. Idea base on logic by GQuest idea.

# Design / Features / To Do List:

 * [ ] Build world with blocks and other types.
 * [ ] Simple combat / movements
	* [ ] fist
	* [ ] Knock out
	* [ ] Wall jump
	* [ ] Wall climb
	* [x] Grappling hook
 * [ ] prototype items
   * [x] Build tool to place blocks and delete (wip)
   * [x] Melee (wip)
   * [x] Simple Turret (wip)
   * [x] projectile (wip)
   * [ ] storage menu ( wip )
	   * [x] Chest
   * [ ] NPC menu ( n/a )
   * [ ] Interact ( wip )
     * [x] Chest Box
     * [x] Pick up auto
     * [ ] Pick up manual
	* [ ] Props
    * [ ] out of bounds ( n/a )
    * [ ] Damage area ( n/a )
    * [ ] Health area ( n/a )
    * [ ] Teleport ( n/a )

 * vehicle
	*	[x] simple car ( wip )
 * [ ] key binding
	*	[x] keyboard (wip / still need work on)
	* [ ] mouse ( n/a )
 * [ ] config
	 * [x] save and load (testing)
 * [x] main menu
	 * [x] Host
	 * [x] Join
	 * [x] Port
	 * [x] IP Address
	 * [x] upnp (not tested)
 * [ ] Lobby (wip)
	 * [x] Chat Message
	 * [x] Player List
				- [x] kick
				- [ ] pm
	 * [x] start game (simple load map and players)
	 * [ ] game settings
	 * [ ] options
 * [ ] Network (wip)
   * [ ] Headless server and host server for what ever need to config it.
   * [ ] server (wip)
     * [x] handle disconnect
     * [x] handle connect
   * [ ] client (wip)
     * [x] handle disconnect
     * [x] handle connect
  
 * [ ] Player
   * model
	   * male
	   * female
   * [x] Simple Capsule / Collision
   * [x] Melee weapon (wip)
   * [x] Hit scan weapon (wip)
   * [x] Build blocks ( n/a )
   * [x] Inventory UI
   * [x] Hot Bar
   * [ ] Build mode
 * Map
   * [x] Prototype Test01 (wip)
   * [ ] Training Area (wip)
   * [x] Prototype Quick Test (wip)
   * [x] Prototype Offline Test (wip)
   * [x] Vehicle Test Areas (wip)
   * [x] Ladder (wip)

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
 * puzzle_dependencies

# Bugs: 
 * Note this project is work in progress. It subject change in dev builds.
 * Host Input Pause when start game if clicked. Incorrect coding in auth pass ID.
 * Host HealthBar not reduce only client works.  Incorrect coding.

# Links:
 * https://www.youtube.com/watch?v=n8D3vEx7NAE
 * https://www.youtube.com/watch?v=ybya2TbHgSE
 * https://godotengine.org
 
# Credits:
 * First Person Shooter set up.
 	* https://www.youtube.com/@DevLogLogan 
 * Chart
   * https://github.com/nathanhoad/godot_puzzle_dependencies
 * Godot 4 - RPG Inventory System From Scratch
   * https://www.youtube.com/watch?v=V79YabQZC1s
 * Godot Class
   * https://www.youtube.com/watch?v=HbRFjTmcVJo
 * State Machine
	  * https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
		* https://gdscript.com/solutions/godot-state-machine/