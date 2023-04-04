extends NavigationRegion3D
# https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_using_navigationmeshes.html

func update_navigation_mesh():
	print("UPDATE NAV MESH")
	
	# use bake and update function of region
	var on_thread: bool = true
	bake_navigation_mesh(on_thread)
	
	await bake_finished 
	print("FINISHED")
	
	# or use the NavigationMeshGenerator Singleton
	#var _navigationmesh: NavigationMesh = navigation_mesh
	#var _navigationmesh: NavigationMesh = get_navigation_mesh()

	#NavigationMeshGenerator.bake(_navigationmesh, self)
	# remove old resource first to trigger a full update
	
	#navigation_mesh = null
	#navigation_mesh = _navigationmesh
	#set_navigation_mesh(null)
	#set_navigation_mesh(_navigationmesh)
	
	# or use NavigationServer API to update region with prepared navigation mesh
	#var region_rid: RID = get_region_rid()
	#NavigationServer3D.region_set_navigation_mesh(region_rid, navigation_mesh)
	
