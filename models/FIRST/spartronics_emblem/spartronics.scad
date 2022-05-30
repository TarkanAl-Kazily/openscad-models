/*
 * The Spartronics Emblem
 */
$fn=100;

// Import helmet SVG file, and adjust for centering and scale
module helmet(scale_factor, center=true) {
    translate([-3,1,0])
        scale(scale_factor)
        import("images/spartronics-helmet.svg", center=center, dpi=96);
}

// Draw outer cog teeth
module rounded_rectangle(length) {
    rounding = 2.5;
    minkowski() {
        offset(r=-rounding)
            intersection() {
                square([0.25*length, length], center=true);
                circle(d=length);
            }
        circle(r=rounding);
    }
}

// Outer shape, 2d
module outer_shape(diameter) {
    union() {
        for (i=[0:3]) {
            rotate([0, 0, i * 45])
                rounded_rectangle(diameter);
        }
        circle(d=0.87*diameter);
    }
}

// Gear with no logo
module gear_base(diameter, edge_thickness, center_thickness) {
    color("yellow") difference() {
        linear_extrude(height=edge_thickness, convexity=2) outer_shape(diameter);
        // Recess in outer shape to place logo
        translate([0,0,center_thickness/2])
            linear_extrude(height=edge_thickness)
            circle(d=diameter * 0.77);
    }

    // The blue background
    color("blue") translate([0,0, center_thickness/2])
        linear_extrude(height=center_thickness/2) circle(d=diameter * 0.8);
}

// Print curved text in Spartronics font (SF Transrobotics)
module curved_text(line, radius, spacing, reverse=false, center=true) {
    angle_step = (180 * spacing) / (radius * PI) * (reverse ? -1 : 1);
    rotate([0, 0, angle_step * (len(line) - 1) / 2 - 90]) {
        union() {
            for (i=[0:len(line) - 1]) {
                point = [-radius * cos(angle_step * i), radius * sin(angle_step * i), 0];
                translate(point)
                    rotate(-i*angle_step+(reverse ? -90 : 90))
                    text(line[i], halign="center", valign="center", size=8, font="SF TransRobotics");
            }
        }
    }
}

// Assemble the final spartronics emblem model
module spartronics_emblem() {
    // Tunale Parameters
    outer_diameter=75;
    outer_height=10;
    text_spacing=6.5;

    // Derived Parameters
    helmet_scale=0.40;
    text_radius=0.64 * (outer_diameter / 2);
    logo_height=outer_height * 0.8;
    base_height=outer_height * 0.5;

    // The main outline
    gear_base(outer_diameter, outer_height, base_height);

    color("yellow")
        translate([0,0,base_height])
        linear_extrude(height=logo_height-base_height)
        helmet(helmet_scale);

    color("yellow")
        translate([0,0,base_height])
        linear_extrude(height=logo_height-base_height)
        curved_text("SPARTRONICS", text_radius, text_spacing);

    color("yellow")
/*
        // Curved 4915 text
        rotate([0,0,180])
        translate([0,0,base_height])
        linear_extrude(height=logo_height-base_height)
        curved_text("4915", text_radius, text_spacing, reverse=true);
*/
//      Straight 4915 text
        translate([0,-22,base_height])
        linear_extrude(height=logo_height-base_height)
        text("4915", halign="center", valign="center", size=8, font="SF TransRobotics");
}

//rotate([45, 0, $t*360])
spartronics_emblem();
