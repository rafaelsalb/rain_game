shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float intensity = 0.5 + 0.25 * cos(TIME);
	COLOR = COLOR * vec4(1.0, 0.0, 0.5, intensity);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
