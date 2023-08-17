if (drawIndex >= array_length(drawQueue)) {
	return;
}

if (array_get(drawQueue, drawIndex).object_index == obj_square) {
	with (array_get(drawQueue, drawIndex)) {
		image_index++;
	}
}
else if (array_get(drawQueue, drawIndex).object_index == obj_wall) {
	instance_destroy(array_get(drawQueue, drawIndex));
}
drawIndex++;

if drawIndex < array_length(drawQueue) {
	alarm[0] = drawSpeed;
}