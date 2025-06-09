shader_type canvas_item;

void fragment() {
	vec2 zoomed_uv = (UV - 0.5) * 1.25 + 0.5;
    vec2 shifted_uv = zoomed_uv + vec2(0.0, 0.1 * sin(TIME * 2.0));
    COLOR = texture(TEXTURE, shifted_uv);
}
