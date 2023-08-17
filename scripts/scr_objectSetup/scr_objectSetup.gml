function getFloorHeight(obj){
	var spr = object_get_sprite(obj);
	var sprHeight = sprite_get_height(spr);
	var sprWidth = sprite_get_width(spr);
	if (!sprHeight || !sprWidth) {
		return undefined;
	}
	return (sprHeight - 16); //Just make depth a global, no way to get it without having an object created
}

function getFloorWidth(obj) {
	var spr = object_get_sprite(obj);
	var sprHeight = sprite_get_height(spr);
	var sprWidth = sprite_get_width(spr);
	if (!sprHeight || !sprWidth) {
		return undefined;
	}
	return sprWidth;
}