use <spartronics.scad>

//
// Parameters and main module
//

inner_loop_diameter = 5; // Diameter of hole in ornament loop
loop_height = 5;       // Thickness of loop for hanging

$fn = 50;

spartronics_ornament();

//
// Implementation
//

module spartronics_ornament() {
    union() {
        spartronics_emblem();
        translate([0, 40, 0])
        ornament_loop();
    }
}

module ornament_loop() {
    difference() {
        cylinder(h=loop_height, d=inner_loop_diameter + 5); //, center=true);
        cylinder(h=loop_height, d=inner_loop_diameter); //, center=true);
    }
}
