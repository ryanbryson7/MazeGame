for (var i = 0; i < array_length(grid); ++i) {
	var row = array_get(grid, i);
	for (var j = 0; j < array_length(row); ++j) {
		var space = array_get(row, j);
		if (instance_exists(space)) {
			instance_destroy(space);
		}
	}
}