shader_type canvas_item;

void fragment() {
	COLOR = vec4(COLOR.rgb, 0.5 + 0.5 * cos(TIME));
}
