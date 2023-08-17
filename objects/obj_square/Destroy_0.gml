// Go through every neighbor
  // If they don't exist, destroy the wall
  
for (var i = 0; i < 4; ++i) {
	switch i {
		case wallDirection.topLeft: {
			if (!instance_exists(topLeftNeighbor)) {
				instance_destroy(topLeftWall);
			}
			break;
		}
		case wallDirection.topRight: {
			if (!instance_exists(topRightNeighbor)) {
				instance_destroy(topRightWall);
			}
			break;
		}
		case wallDirection.bottomLeft: {
			if (!instance_exists(bottomLeftNeighbor)) {
				instance_destroy(bottomLeftWall);
			}
			break;
		}
		case wallDirection.bottomRight: {
			if (!instance_exists(bottomRightNeighbor)) {
				instance_destroy(bottomRightWall);
			}
			break;
		}
	}
}