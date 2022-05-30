// Nintendo Switch Game Cartridge

include <nintendo_switch_constants.scad>;
my_text = "The Legend of Fejka";
$fn=50;

// A rounded box of the appropriate dimensions (height, width, depth)
module base_form() {
    linear_extrude(depth) {
        hull() {
            for (x=[radius:height-2*radius:height-radius]) {
                for (y=[radius:width-2*radius:width-radius]) {
                    echo(x=x, y=y);
                    translate([x, y, 0.0])
                        circle(radius);
                }
            }
        }
    }
}

/*
color("red", 1.0)
base_form();
*/

module cartridge(line1, line2) {
    difference() {
        base_form();
        translate([0.05 * height, 0.05 * width, depth-1]) {
            scale(v=[0.8, 0.9, 1]) {
                base_form();
            }
        }

        translate([0.0, 0.0, -epsilon]) {
            cube(size=[height + epsilon, 1, 1.0 + epsilon]);
        }

        translate([0.4 * height, 2.0, -epsilon]) {
            cube(size=[0.6 * height+epsilon, 3.5, 1.0 + epsilon]);
        }

        start = 3.0;
        for (i = [1:4]) {
            y = start + 3.5 * i;
            translate([0.4 * height, y, -epsilon]) {
                cube(size=[0.6 * height + epsilon, 2.5, 1.0 + epsilon]);
            }
        }

        translate([0.9 * height, width / 2.0, 0.9*depth]) {
            linear_extrude(height=1.0) {
                polygon([[2.0, 0.0], [0.0, 2.0], [0.0, -2.0]]);
            }
        }

    }

    %translate([0.20 * height, 0.5 * width, depth - 1]) {
        scale(v=[0.5, 0.5, 1.0]) {
            rotate(a=[0,0,90]){
                linear_extrude(height=1) {
                    text("Nentandu", size=6, halign="center");
                }
            }
        }
    }



    %translate([0.40 * height, 0.5 * width, depth - 1]) {
        scale(v=[0.5, 0.5, 1.0]) {
            rotate(a=[0,0,90]){
                linear_extrude(height=1) {
                    multiline(line1, line2);
                }
            }
        }
    }

}

module multiline(line1, line2) {
    text(line1, size=5, halign="center");
    translate([0.0, -7.0, 0.0]) {
        text(line2, size=6, halign="center");
    }
}

//multiline("The Legend", "of Fejka");

cartridge("The Legend", "of Fejka");
