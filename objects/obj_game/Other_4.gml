if (room = Room1) {
	// Setup room size
	room_width = global.maze_width + 4;
	room_height = global.maze_height + 2;

	// Setup camera
	view_camera[0] = camera_create_view(0, 0, room_width, room_height);
}
