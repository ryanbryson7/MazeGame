if (maze != undefined) {
	instance_destroy(maze);
	layer_destroy_instances("Floor");
}

maze = instance_create_layer(mouse_x, mouse_y, "Floor", obj_maze);