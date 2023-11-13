keyLeft = keyboard_check(vk_left) || keyboard_check(ord("A"));
keyRight = keyboard_check(vk_right) || keyboard_check(ord("D"));
keyUp = keyboard_check(vk_up) || keyboard_check(ord("W"));
keyDown = keyboard_check(vk_down) || keyboard_check(ord("S"));

inputDirection = point_direction(0, 0, keyRight - keyLeft, keyDown - keyUp);
inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp != 0);

speed = inputMagnitude * current_speed;
direction = inputDirection;
vspeed /= 2;


// Note to self (make sure sprites have propr collision masks (precise)
var wall = instance_place(x + hspeed, y, obj_wall);
if (wall != noone) {
	if (hspeed > 0) {
		for (var i = 1; i <= hspeed; ++i) {
			if (instance_place(x + i, y, obj_wall)) {
				x = x + i - 1;
				break;
			}
		}
	}
	if (hspeed < 0) {
		for (var i = -1; i >= hspeed; --i) {
			if (instance_place(x + i, y, obj_wall)) {
				x = x + i + 1;
				break;
			}
		}
	}
	hspeed = 0;
}

wall = instance_place(x, y + vspeed, obj_wall);
if (wall != noone) {
	if (vspeed > 0) {
		for (var i = 1; i <= vspeed; ++i) {
			if (instance_place(x, y + i, obj_wall)) {
				y = y + i - 1;
				break;
			}
		}
	}
	if (vspeed < 0) {
		for (var i = -1; i >= vspeed; --i) {
			if (instance_place(x, y + i, obj_wall)) {
				y = y + i + 1;
				break;
			}
		}
	}
	vspeed = 0;
}