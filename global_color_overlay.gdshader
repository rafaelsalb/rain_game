shader_type canvas_item;

uniform vec4 color: source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

void vertex() {
	// Called for every vertex the material is visible on.
	//COLOR = COLOR * color;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = screen_color * color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
