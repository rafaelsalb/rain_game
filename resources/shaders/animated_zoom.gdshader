shader_type canvas_item;

uniform float scaling_factor = 1.0f;

void fragment() {
	vec2 delta = vec2(cos(TIME), sin(TIME)) / scaling_factor;
	COLOR = texture(TEXTURE, UV + delta);
}
