shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0); // 0 = no dissolve, 1 = full dissolve
uniform vec4 fade_color : source_color = vec4(0.0, 0.0, 0.0, 1.0); // dissolve to black
uniform float noise_scale = 8.0;

float rand(vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    float noise = rand(FRAGCOORD.xy / noise_scale);
    float threshold = smoothstep(0.0, 1.0, progress);
    float alpha = step(noise, threshold);
    COLOR = fade_color;
    COLOR.a *= alpha;
}
