//instance_create_layer(mouse_x, mouse_y, "Floor", obj_square);

var squareClicked = instance_position(mouse_x, mouse_y, obj_square);
if (squareClicked != noone) {
	with (squareClicked) {
		if (topLeftNeighbor != noone) {
			topLeftNeighbor.image_index++;
		}
		if (topRightNeighbor != noone) {
			topRightNeighbor.image_index++;
		}
		if (bottomLeftNeighbor != noone) {
			bottomLeftNeighbor.image_index++;
		}
		if (bottomRightNeighbor != noone) {
			bottomRightNeighbor.image_index++;
		}
	}
}