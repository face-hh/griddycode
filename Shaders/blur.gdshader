shader_type canvas_item;

uniform float blur_strength : hint_range(0, 10);

void fragment() {
    vec4 sum = vec4(0.0);
    vec2 tex_size = vec2(textureSize(TEXTURE, 0));
    int radius = int(blur_strength);

    for(int y = -radius; y <= radius; y++) {
        for(int x = -radius; x <= radius; x++) {
            vec2 offset = vec2(float(x), float(y)) / tex_size;
            sum += texture(TEXTURE, UV + offset);
        }
    }

    COLOR = sum / ((2.0 * float(radius) + 1.0) * (2.0 * float(radius) + 1.0));
}