shader_type canvas_item;

uniform vec2 offset = vec2(0.0f, 0.0f);
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap_anisotropic, repeat_disable;

void fragment() {
	vec4 offset_texture = texture(screen_texture, UV + offset);
	COLOR = offset_texture;
}
