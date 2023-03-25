// Part for the base of my DSO311
//
//

// Configurable parameters - units in mm

/* [Outer Box Dimensions] */
width = 66.25;
height = 16.85;
depth = 2.54;

side_tab_width = 71.55;
side_tab_height = 8.25;

top_tab_width = 13.15;
top_tab_height = 22.15;

sep = 33.46;

hole_width = 23.15;
hole_height = 10.0;
hole_top_offset = 4.0;
hole_left_offset = 4.0;

$fn=50;

module main() {
    difference() {
        union() {
          translate([0, height/2, 0])
          cube([width, height, depth], center = true);

          translate([0, side_tab_height/2, 0])
          cube([side_tab_width, side_tab_height, depth], center = true);

          translate([sep/2 + top_tab_width / 2, height/2, 0])
          cube([top_tab_width, top_tab_height, depth], center = true);

          translate([-sep/2 - top_tab_width / 2, height/2, 0])
          cube([top_tab_width, top_tab_height, depth], center = true);
        }

        translate([hole_left_offset - width / 2 + hole_width / 2, height/2, 0])
        cube([hole_width, hole_height, depth + 1], center = true);
    }
}

main();
