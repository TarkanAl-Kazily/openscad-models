
use <equilateral.scad>

thickness=1.5;
dim=20;
$fn=100;

module red_triangle() {
    color("red")
        linear_extrude(height=thickness)
        difference() {
            equilateral(dim);

            offset(r=-thickness)
                equilateral(dim);
        }
}

module white_circle() {
    color("white")
        linear_extrude(height=thickness)
        difference() {
            circle(d=dim);

            offset(r=-thickness)
                circle(d=dim);
        }
}

module blue_square() {
    color("blue")
        linear_extrude(height=thickness)
        difference() {
            square(dim * sin(60));

            offset(r=-thickness)
                square(dim * sin(60));
        }
}

rotate([90, 0, 0])
red_triangle();

translate([dim/4, thickness + 0.25, thickness + 1.0])
white_circle();

translate([0, 2*thickness + 0.25, 0])
rotate([45, 0, 0])
blue_square();
