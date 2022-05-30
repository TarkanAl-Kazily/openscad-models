/*
 * A basic test print of an X with a circle in the center
 */
$fn=50;

linear_extrude(height=15)
minkowski() {
    union() {
        square([10, 90], center=true);
        rotate([0,0,90])
            square([10, 90], center=true);
        circle(d=25);
    }

    circle(r=1);
}
