enum compass {
	right = 0,
	up = 90,
	left = 180,
	down = 270
}

function mazeRecurStart(grid){
	// Choose a random starting square
	var startObject = getStart(grid) //TODO: modify this somehow to prevent trying squares that have been removed
	mazeRecurNew(startObject); //TODO, MAKE NEW RECUR, just use a cell's neighbors, don't grid or indexes :)
	addStartFinish(grid);
}

function mazeRecurNew(startObject) {
	with (startObject) {
		visited = true;
		var indexArray = [0, 1, 2, 3];
		var neighborArray = [topLeftNeighbor, topRightNeighbor, bottomLeftNeighbor, bottomRightNeighbor];
		var wallArray = [topLeftWall, topRightWall, bottomLeftWall, bottomRightWall];
		indexArray = array_shuffle(indexArray);

		for (var i = 0; i < 4; ++i) {
			if (neighborArray[indexArray[i]] != noone && instance_exists(neighborArray[indexArray[i]]) && !neighborArray[indexArray[i]].visited) {
				instance_destroy(wallArray[indexArray[i]]);
				mazeRecurNew(neighborArray[indexArray[i]]);
			}
		}
	}
}

function mazeRecur(grid, row, column, maxRows, maxColumns, delay) {
	// Skip if out of bounds
	if (row < 0 || row >= maxRows || column < 0 || column >= maxColumns) {
		return;	
	}
	
	// Skip if already visited
	if (array_get(grid[row], column).visited) {
		return;
	}
	
	// Set square to visited
	array_get(grid[row], column).visited = true;
	
	// Remove my wall
	if (prevDirection) {
		breakWall(grid, row, column, prevDirection, maxRows, maxColumns);
	}
	
	// Choose a direction to go 
	var directions = [compass.right, compass.up, compass.left, compass.down];
	directions = array_shuffle(directions);
	var nextDirection; //TODO: Just set nextRow/nextColumn to simplify switch statement
	
	for (var i = 0; i < 4; ++i) {
		nextDirection = directions[i];
		switch (nextDirection) {
			case compass.right:
				//breakWall(grid, row, column, nextDirection, maxRows, maxColumns);
				mazeRecur(grid, row, column + 1, compass.left, maxRows, maxColumns, delay);
			break;
			
			case compass.up:
				//breakWall(grid, row, column, nextDirection, maxRows, maxColumns);
				mazeRecur(grid, row - 1, column, compass.down, maxRows, maxColumns, delay);
			break;
			
			case compass.left:
				//breakWall(grid, row, column, nextDirection, maxRows, maxColumns);
				mazeRecur(grid, row, column - 1, compass.right, maxRows, maxColumns, delay);
			break;
			
			case compass.down:
				//breakWall(grid, row, column, nextDirection, maxRows, maxColumns);
				mazeRecur(grid, row + 1, column, compass.up, maxRows, maxColumns, delay);
			break;
		}
	}
	with (array_get(grid[row], column)) {
		alarm[0] = alarm[0] + 60;
	}
}

function breakWall(grid, row, column, wallDirection, maxRows, maxColumns) {
	var nextRow = row;
	var nextColumn = column;
	switch (wallDirection) {
			case compass.right:
				nextColumn++;
			break;
			
			case compass.up:
				nextRow--;
			break;
			
			case compass.left:
				nextColumn--;
			break;
			
			case compass.down:
				nextRow++;
			break;
	}
	// Don't break wall if out of bounds
	if (nextRow < 0 || nextRow >= maxRows || nextColumn < 0 || nextColumn >= maxColumns) {
		return;	
	}
	
	// Destroy wall
	var square = array_get(grid[row],column)
	//destroyWall(square,wallDirection);
	//switch (wallDirection) {
		
	//		case compass.right:
				
	//		break;
			
	//		case compass.up:
	//			instance_destroy(square.top_wall);
	//		break;
			
	//		case compass.left:
	//			instance_destroy(square.left_wall);
	//		break;
			
	//		case compass.down:
	//			instance_destroy(square.bottom_wall);
	//		break;
	//}
}
	
function getStart(grid) {
	//TODO: update grid to remove squares that don't exist, 
	// otherwise getting a start randomly can take multiple tries
	// To be fair: it didn't take a noticeable time to get one randomly
	
	var startRow = irandom_range(0, array_length(grid) - 1);
	var startColumn = irandom_range(0, array_length(array_get(grid, startRow)) - 1);
	var startObject = array_get(array_get(grid, startRow), startColumn);	
	
	if startObject == noone || !instance_exists(startObject) { return getStart(grid); }
	else { return startObject; }
}
	
function addStartFinish(grid) {
	startSquare = getRandomEdgeSquare(grid);
	endSquare = getRandomEdgeSquare(grid);
	// One day this shouldn't be how this is done, but it's good enough today
	while (startSquare == endSquare) {
		endSquare = getRandomEdgeSquare(grid);
	}
	
	startSquare.image_index++;
	
	endSquare.image_index--;
	endSquare.isFinish = true;
}

function getRandomEdgeSquare(grid) { 
	var row = irandom_range(0, array_length(grid) - 1);
	var rowLength = array_length(array_get(grid, row))
	var column;
	var isLeft = irandom_range(0, 1);
	
	if (isLeft == 0) {
		column = 0;
	}
	else if (isLeft == 1) {
		column = rowLength - 1;
	}
	
	return array_get(array_get(grid, row), column);
}