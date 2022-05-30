include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <neopixel.scad>;

eps=0.1;
$fn=40;

module grown_ring(r=0.5) {
    neopixel_led_12px_ring([], pixel_buffer=r);
}

module screw_holes() {
    // Ring variables
    inner_diameter = 36.25;
    annulus_width = 7.5;
    screw_hole_diameter = 3.25;
    screw_radial_offset = 0.60;
    screw_hole_centers = inner_diameter/2 + annulus_width - screw_radial_offset - screw_hole_diameter/2;
    union() {
        for (i = [0:3]) {
            rotate(45 + i * 90, [0, 0, 1])
            translate([screw_hole_centers, 0, -eps])
            linear_extrude(4+2*eps)
            circle(d=screw_hole_diameter);
        }
    }
}

z_offset=1.6;
module base_plate() {
    translate([0, 0, z_offset])
    rotate(45 + 360/12, [0, 0, 1])
    union() {
        linear_extrude(1)
        circle(d=60);

        translate([0, 0, -z_offset])
        linear_extrude(z_offset)
        square([58, 1], center=true);

        rotate(90, [0, 0, 1])
        translate([0, 0, -z_offset])
        linear_extrude(z_offset)
        square([58, 1.2], center=true);
    }
}

difference() {
    // Ring variables
    inner_diameter = 36.25;
    annulus_width = 7.5;

    base_plate();
    screw_holes();

    full_height = z_offset + 1;

    // LED 0 - full cut
    rotate(0, [0, 0, 1])
    translate([inner_diameter/2 + annulus_width/2, 0, 0])
    linear_extrude(full_height + eps)
    square([6, 6], center=true);

    // LED 1 - 0.15 mm thickness
    rotate(1*360/12, [0, 0, 1])
    translate([inner_diameter/2 + annulus_width/2, 0, 0]) {
        linear_extrude(full_height + eps - 0.3)
        square([6, 6], center=true);
    }
    // LED 2 - 0.30 mm thickness
    rotate(2*360/12, [0, 0, 1])
    translate([inner_diameter/2 + annulus_width/2, 0, 0]) {
        linear_extrude(full_height + eps - 0.50)
        square([6, 6], center=true);
    }
    // LED 3 - one d=2.0 mm hole
    rotate(3*360/12, [0, 0, 1])
    translate([inner_diameter/2 + annulus_width/2, 0, 0]) {
        linear_extrude(full_height+eps)
        circle(d=2);
    }
    // LED 4 - ???
    rotate(4*360/12, [0, 0, 1])
    translate([inner_diameter/2 + annulus_width/2, 0, 0]) {
        linear_extrude(full_height + eps)
        circle(d=3);
    }
    // LED 5 - ???
    rotate(5*360/12, [0, 0, 1])
    translate([inner_diameter/2 + annulus_width/2, 0, 0]) {
        linear_extrude(full_height + eps)
        circle(d=4);
    }
    // LED 6 - ???
    rotate(6*360/12, [0, 0, 1])
    translate([inner_diameter/2 + annulus_width/2, 0, 0]) {
        linear_extrude(full_height + eps)
        circle(d=5);
    }
    // LED 7 - ???
    rotate(7*360/12, [0, 0, 1])
    translate([inner_diameter/2 + annulus_width/2, 0, 0]) {
        linear_extrude(full_height + eps)
        circle(d=6);
    }
    // LED 8 - two d=2.0 mm hole
    rotate(8*360/12, [0, 0, 1])
    translate([inner_diameter/2 + annulus_width/2, 0, 0]) {
        linear_extrude(full_height+eps,convexity=2)
        grid2d(spacing=3.5, cols=2, rows=1)
        circle(d=2.0);
    }
    // LED 9 - four d=2.0 mm holes
    rotate(9*360/12, [0, 0, 1])
    translate([inner_diameter/2 + annulus_width/2, 0, 0]) {
        linear_extrude(full_height+eps,convexity=2)
        grid2d(spacing=3.5, cols=2, rows=2)
        circle(d=2.0);
    }
    // LED 10 - an x-slot
    rotate(10*360/12, [0, 0, 1])
    translate([inner_diameter/2 + annulus_width/2, 0, 0]) {
        linear_extrude(full_height+eps)
        union() {
            hull() {
                translate([1.75, 1.75, 0])
                circle(r=0.60);
                translate([-1.75, -1.75, 0])
                circle(r=0.60);
            }
            hull() {
                translate([1.75, -1.75, 0])
                circle(r=0.60);
                translate([-1.75, 1.75, 0])
                circle(r=0.60);
            }
        }
    }
    // LED 11 - three verticle slots
    rotate(11*360/12, [0, 0, 1])
    translate([inner_diameter/2 + annulus_width/2, 0, 0]) {
        linear_extrude(full_height+eps)
        union() {
        for (i=[-1:1]) {
        translate([0, i*2.25, 0])
        hull() {
            translate([2.0, 0, 0])
            circle(r=0.60);
            translate([-2.0, 0, 0])
            circle(r=0.60);
        }
        }
    }
    }
}

%translate([0, 0, -z_offset - eps])
neopixel_led_12px_ring([], 0);
