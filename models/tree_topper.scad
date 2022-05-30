// A christmas tree topper

$fn=50;

module shape(scale) {
    polygon([[scale*5, scale*0], [scale*2, scale*2],
             [scale*0, scale*5], [scale*-2, scale*2],
             [scale*-5, scale*0], [scale*-2, scale*-2],
             [scale*0, scale*-5], [scale*2, scale*-2]]);
}

module base(scale, wall_width) {
    difference() {
        shape(scale);
        offset(r=-wall_width) {
            shape(scale);
        }
    }
}

/*
rotate(-190) {
translate([0, 0, 30]) {
    linear_extrude(height=20, twist=110, scale=0.05) {
        difference() {
            base(1.0);
            base(0.7);
        }
    }
}
}
*/

rotate(-90) {
translate([0, 0, 40]) {
    linear_extrude(height=10, twist=30, slices=20, scale=0.0) {
        shape(4.0*0.2);
    }
}
}


translate([0, 0, 0]) {
    linear_extrude(height=40, twist=90, slices=50, scale=0.2) {
        base(4.0, 3.0);
    }
}

/*
linear_extrude(height=10, twist=80, scale=0.666) {
    difference() {
        base(3.0);
        base(2.7);
    }
}
*/
