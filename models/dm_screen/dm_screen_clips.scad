/*
 * Basic clips to place on top of my DM screen.
 *
 * Author: Tarkan Al-Kazily - tarkan.alkazily (at) gmail.com
 */

// Configurable parameters

/* [Dimensions] */
screen_thickness = 1.0; // mm
nub_thickness = 0.5;
intersect = 0.30;
wall_thickness = 2.0;
clip_width = 20.0;
clip_height = 22.5;
angle = 140;
axis_x_offset = 10.0;


$fn=50;

/* [Render Controls] */
RENDER_CLIP = true;
RENDER_ANGLE = true;

if (RENDER_CLIP) {
    clip();
}

if (RENDER_ANGLE) {
    translate([50, 0, 0]) {
        angle();
    }
}

/*
 * Modules
 */
module clip() {
    union() {
        _overhang();

        for (i = [0:2]) {
            translate([clip_width * (i+1) / 4, clip_height * 0.75, wall_thickness]) {
                sphere(r=nub_thickness + intersect);
            }
        }
    }
}

module angle() {
    union() {
        translate([axis_x_offset, 0, -wall_thickness - nub_thickness / 2 - screen_thickness / 2])
        _overhang();

        rotate(a = angle, v = [0, 1, 0]) {
            translate([axis_x_offset, 0, -wall_thickness - nub_thickness / 2 - screen_thickness / 2])
            _overhang();
        }

        rotate(a = 90 + angle / 2, v = [0, 1, 0]) {
            translate([0, wall_thickness / 2, 2.0 * wall_thickness])
            cube([axis_x_offset * 2.2, wall_thickness, 2.1 * wall_thickness + nub_thickness + screen_thickness], center=true);
        }
    }
}

module _overhang() {
    union() {
        cube([clip_width, wall_thickness, 2 * wall_thickness + screen_thickness + nub_thickness]);
        cube([clip_width, clip_height, wall_thickness], center=false);
        translate([0, 0, wall_thickness + screen_thickness + nub_thickness]) {
            cube([clip_width, clip_height, wall_thickness], center=false);
        }
    }

}
