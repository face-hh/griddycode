/*
Shader from Godot Shaders - the free shader library.
godotshaders.com/shader/god-rays

Feel free to use, improve and change this shader according to your needs
and consider sharing the modified result on godotshaders.com.
*/

shader_type canvas_item;

uniform float angle = -0.125;
uniform float position = 0.06;
uniform float spread : hint_range(0.0, 1.0) = 0.565;
uniform float cutoff : hint_range(-1.0, 1.0) = 0.15;
uniform float falloff : hint_range(0.0, 1.0) = 0.12;
uniform float edge_fade : hint_range(0.0, 1.0) = 0.185;

uniform float speed = 1.055;
uniform float ray1_density = 8.0;
uniform float ray2_density = 30.0;
uniform float ray2_intensity : hint_range(0.0, 1.0) = 0.17;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform vec4 color : source_color = vec4(1.0, 0.9, 0.65, 0.3);

uniform bool hdr = true;
uniform float seed = 5.0;

// Random and noise functions from Book of Shader's chapter on Noise.
float random(vec2 _uv) {
    return fract(sin(dot(_uv.xy,
                         vec2(12.9898, 78.233))) *
        43758.5453123);
}

float noise (in vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));


    // Smooth Interpolation

    // Cubic Hermine Curve. Same as SmoothStep()
    vec2 u = f * f * (3.0-2.0 * f);

    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

mat2 rotate(float _angle){
    return mat2(vec2(cos(_angle), -sin(_angle)),
                vec2(sin(_angle), cos(_angle)));
}

vec4 screen(vec4 base, vec4 blend){
	return 1.0 - (1.0 - base) * (1.0 - blend);
}

void fragment()
{

	// Rotate, skew and move the UVs
	vec2 transformed_uv = ( rotate(angle) * (UV - position) )  / ( (UV.y + spread) - (UV.y * spread) );

	// Animate the ray according the new transformed UVs
	vec2 ray1 = vec2(transformed_uv.x * ray1_density + sin(TIME * 0.1 * speed) * (ray1_density * 0.2) + seed, 1.0);
	vec2 ray2 = vec2(transformed_uv.x * ray2_density + sin(TIME * 0.2 * speed) * (ray1_density * 0.2) + seed, 1.0);

	// Cut off the ray's edges
	float cut = step(cutoff, transformed_uv.x) * step(cutoff, 1.0 - transformed_uv.x);
	ray1 *= cut;
	ray2 *= cut;

	// Apply the noise pattern (i.e. create the rays)
	float rays;

	if (hdr){
		// This is not really HDR, but check this to not clamp the two merged rays making
		// their values go over 1.0. Can make for some nice effect
		rays = noise(ray1) + (noise(ray2) * ray2_intensity);
	}
	else{
		 rays = clamp(noise(ray1) + (noise(ray2) * ray2_intensity), 0., 1.);
	}

	// Fade out edges
	rays *= smoothstep(0.0, falloff, (1.0 - UV.y)); // Bottom
	rays *= smoothstep(0.0 + cutoff, edge_fade + cutoff, transformed_uv.x); // Left
	rays *= smoothstep(0.0 + cutoff, edge_fade + cutoff, 1.0 - transformed_uv.x); // Right

	// Color to the rays
	vec3 shine = vec3(rays) * color.rgb;

	// Try different blending modes for a nicer effect. "Screen" is included in the code,
	// but take a look at https://godotshaders.com/snippet/blending-modes/ for more.
	// With "Screen" blend mode:
	shine = screen(texture(SCREEN_TEXTURE, SCREEN_UV), vec4(color)).rgb;

	COLOR = vec4(shine, rays * color.a);
}
