shader_type canvas_item;

uniform float radius: hint_range(0., 1.) = 1;
uniform bool animate = false;
uniform float square_scale: hint_range(0., 1.) = 0.1;

void fragment() {
    float sc = square_scale + square_scale/2.;
    float r = square_scale + (1. - radius) * (square_scale/2.);

    float scax = 1. - square_scale;

    float dx;
    float dy;
    float d;
    float a;

    if (UV.x < square_scale && UV.y > scax) {
        dx = square_scale - UV.x;
        dy = scax - UV.y;
        d = sqrt(pow(dx, 2.) + pow(dy, 2.));
        a = asin(d);

        if (a > r) {
            if (!animate) {
                COLOR.a = 0.;
            } else if (a > sc * sin(3.14 * fract(TIME))) {
                COLOR.a = 0.;
            }
        }
    }

    if (UV.x < square_scale && UV.y < square_scale) {
        dx = square_scale - UV.x;
        dy = square_scale - UV.y;
        d = sqrt(pow(dx, 2.) + pow(dy, 2.));
        a = asin(d);

        if (a > r) {
            if (!animate) {
                COLOR.a = 0.;
            } else if (a > sc * sin(3.14 * fract(TIME))) {
                COLOR.a = 0.;
            }
        }
    }

    if (UV.x > scax && UV.y < square_scale) {
        dx = scax - UV.x;
        dy = square_scale - UV.y;
        d = sqrt(pow(dx, 2.) + pow(dy, 2.));
        a = asin(d);

        if (a > r) {
            if (!animate) {
                COLOR.a = 0.;
            } else if (a > sc * sin(3.14 * fract(TIME))) {
                COLOR.a = 0.;
            }
        }
    }

    if (UV.x > scax && UV.y > scax) {
        dx = scax - UV.x;
        dy = scax - UV.y;
        d = sqrt(pow(dx, 2.) + pow(dy, 2.));
        a = asin(d);

        if (a > r) {
            if (!animate) {
                COLOR.a = 0.;
            } else if (a > sc * sin(3.14 * fract(TIME))) {
                COLOR.a = 0.;
            }
        }
    }
}