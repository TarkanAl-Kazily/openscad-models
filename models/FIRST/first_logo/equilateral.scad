
module equilateral(side, center=false) {
    zero = [0, 0, 0];
    shift = [-side/2, -(side / 2) * tan(30), 0];
    translate(center ? shift : zero) {
        polygon([[0, 0], [side, 0], [side/2, side * sin(60)]]);
    }
}

equilateral(10);

color("green")
translate([0, 0, -5])
equilateral(20);

color("red")
translate([0, 0, 5])
equilateral(5, center=true);
