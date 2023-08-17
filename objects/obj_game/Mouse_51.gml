var squareClicked = instance_position(mouse_x, mouse_y, obj_square);
if (squareClicked != noone) {
	instance_destroy(squareClicked);
}