global.maze_height = (32 * global.gridSize) + 20;
global.maze_width = 64 * global.gridSize;

cameraBuffer = 1000;

room_width = global.maze_width + (cameraBuffer * 2);
room_height = global.maze_height + (cameraBuffer * 2);

grid = create_grid(obj_square, room_width / 2, room_height - cameraBuffer, global.gridSize);

mazeRecurStart(grid);