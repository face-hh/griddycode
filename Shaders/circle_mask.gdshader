shader_type canvas_item;

uniform float circle_size : hint_range(0.0, 1.0) = 0.4;
uniform float ratio_width = 1.0;
uniform float ratio_height = 1.0;

void fragment() {
	float ratio = ratio_width / ratio_height;
	float dist = distance(vec2(0.5, 0.5), vec2(mix(0.5, UV.x, ratio), UV.y));
	vec4 orig_color = texture(TEXTURE, UV);
	COLOR.rgb = orig_color.rgb;
	COLOR.a = (1.0 - step(circle_size, dist)) * orig_color.a;
}