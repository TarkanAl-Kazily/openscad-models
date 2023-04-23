// OpenSCAD model for a side panel riser for the Behringer Eurorack rack
//
// Author: Tarkan Al-Kazily

// Design notes:
// Trapezoid with adjustable height

/* [Dimensions] */
base = 120.0; // mm
height = 75.0;
width = 15.0;
panel_width = 0.9; // for screwing on
angle = 30.0; // degrees

module main() {
    linear_extrude(width)
    side();
}

module side() {
    union() {
        translate([0, -height, 0])
        square([base, height], false);

        polygon([[0,0], [base, 0], [0, tan(angle) * base]]);
    }
}

module walls() {

    difference() {
        side();

        offset(-panel_width)
        side();
    }

}


main();
