function create_grid(obj, xIn, yIn, size) {
	if size < 1 { return undefined };
	var floorWidth = getFloorWidth(obj);
	var floorHeight = getFloorHeight(obj);
	if (!floorWidth || !floorWidth) {
		return undefined;
	}
	
	// Isometric grid, so rows change in array size 1,2,..,size,..,2,1
	// Same thing for columns^
	// Example with size = 4
	// rows = 7
	var rows = (size * 2) - 1;
	var gridArray = array_create(rows, noone) 
	var currentRowSize;
	
	for (var i = 0; i < rows; ++i) {
		// i = 0  currentRowSize = 1
		// i = 3  currentRowSize = 4
		// i = rows = 6  currentRowSize 1
		if (i < (rows / 2)) {
			currentRowSize = i + 1;
		}
		// i = 4  currentRowSize = 3
		// i = 5  currentRowSize = 2
		else {
			currentRowSize = rows - i;
		}
		
		var rowArray = array_create(currentRowSize, noone);
		for (var j = 0; j < currentRowSize; ++j) {
			// Write algorithm for where to create a floor tile
			// 1. Row index moves the sprite up and left (negative x and y)
			// 2. Each cell of the row moves it right (positive x)
			// ***Note: not exactly sprite length/height movement here
			// ***      Maybe try defining a tile length and width for the sprite
			//array_set(rowArray, j, instance_create_layer(Xin));
			var xDelta,yDelta;
			// If first half
			xDelta = (-i * (floorWidth / 2)) + (j * floorWidth);
			if (i > (rows / 2)) {
				xDelta += (i - floor(rows / 2)) * floorWidth;
			}
			yDelta = -i * (floorHeight / 2);
			array_set(rowArray, j, instance_create_layer(xIn + xDelta, yIn + yDelta, "Floor", obj));
		}
		
		array_set(gridArray, i, rowArray);
	}
	
	// Create an obj_square for each index of the array
	//for (var i = 0; i < rows; ++i) {
	//	for (var j = 0; j < columns; ++j) {
	//		var square = instance_create_layer(xIn + ((j + 0.5) * sprWidth), yIn + ((i + 0.5) * sprHeight), "Floor", obj);
	//		array_set(gridArray[i], j, square);
	//	}
	//}
	
	link_grid(gridArray, obj);
	wall_grid(gridArray, obj_wall);
	
	return gridArray;
}

function link_grid(gridArray, obj) {
	// Check for collision in each direction
	// if collision, get colliding object, that's your neighbor
	
	for (var i = 0; i < array_length(gridArray); ++i) {
		var row = array_get(gridArray, i);
		for (var j = 0; j < array_length(row); ++j) {
			var space = array_get(row, j);
			space.topLeftNeighbor = instance_position(space.x - (space.sprite_width / 2), space.y - (space.sprite_height / 2), obj);
			space.topRightNeighbor = instance_position(space.x + (space.sprite_width / 2), space.y - (space.sprite_height / 2), obj);
			space.bottomLeftNeighbor = instance_position(space.x - (space.sprite_width / 2), space.y + (space.sprite_height / 2), obj);
			space.bottomRightNeighbor = instance_position(space.x + (space.sprite_width / 2), space.y + (space.sprite_height / 2), obj);
		}
	}
}

enum wallDirection {
	topLeft = 0,
	topRight = 1,
	bottomLeft = 2,
	bottomRight = 3
}
	
function wall_grid(gridArray, wallObj) {
	// Go through every square
	for (var i = 0; i < array_length(gridArray); ++i) {
		var row = array_get(gridArray, i);
		for (var j = 0; j < array_length(row); ++j) {
			var space = array_get(row, j);
			
			for (var d = 0; d < 4; ++d) {
				switch d {
					case wallDirection.topLeft: {
						if (space.topLeftWall == noone) {
							var wallX = space.x - (space.sprite_width / 4);
							var wallY = space.y - (space.sprite_height / 6);
							var wallXScale = -1;
							space.topLeftWall = instance_create_layer(wallX, wallY, "Wall", wallObj, {
								image_xscale : wallXScale
							});
							if (space.topLeftNeighbor != noone) {
								// neighbor hasn't made a wall yet (cause they would've made ours for us)
								space.topLeftNeighbor.bottomRightWall = space.topLeftWall;
							}
						}
						break;
					}
					case wallDirection.topRight: {
						if (space.topRightWall == noone) {
							var wallX = space.x + (space.sprite_width / 4);
							var wallY = space.y - (space.sprite_height / 6);
							var wallXScale = 1;
							space.topRightWall = instance_create_layer(wallX, wallY, "Wall", wallObj, {
								image_xscale : wallXScale
							});
							if (space.topRightNeighbor != noone) {
								// neighbor hasn't made a wall yet (cause they would've made ours for us)
								space.topRightNeighbor.bottomLeftWall = space.topRightWall;
							}
						}
						break;
					}
					case wallDirection.bottomLeft: {
						if (space.bottomLeftWall == noone) {
							var wallX = space.x - (space.sprite_width / 4);
							var wallY = space.y + (space.sprite_height / 6);
							var wallXScale = 1;
							space.bottomLeftWall = instance_create_layer(wallX, wallY, "Wall", wallObj, {
								image_xscale : wallXScale
							});
							if (space.bottomLeftNeighbor != noone) {
								// neighbor hasn't made a wall yet (cause they would've made ours for us)
								space.bottomLeftNeighbor.topRightWall = space.bottomLeftWall;
							}
						}
						break;
					}
					case wallDirection.bottomRight: {
						if (space.bottomRightWall == noone) {
							var wallX = space.x + (space.sprite_width / 4);
							var wallY = space.y + (space.sprite_height / 6);
							var wallXScale = -1;
							space.bottomRightWall = instance_create_layer(wallX, wallY, "Wall", wallObj, {
								image_xscale : wallXScale
							});
							if (space.bottomRightNeighbor != noone) {
								// neighbor hasn't made a wall yet (cause they would've made ours for us)
								space.bottomRightNeighbor.topLeftWall = space.bottomRightWall;
							}
						}
						break;
					}
				}
			}
		}
	}
	
	// Check if I have a <direction>Wall
	// If so, skip
	// Otherwise, 
	  // Create the wall object 
	    // Coordinates of the wall depend on the <direction>
		  // Setup up a face width/length (could be useful elsewhere)
		  // Topleft: 
		  // Topright:
		  // Bottomleft:
		  // Bottomright:
		// image_xscale/image_yscale depends on the <direction>?
		  // Topleft: -1/
		  // Topright: (default) 1
		  // Bottomleft: (default) 1
		  // Bottomright: -1
	
}