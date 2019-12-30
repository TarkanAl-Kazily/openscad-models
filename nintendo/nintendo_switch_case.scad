include <nintendo_switch_constants.scad>;
use <nintendo_switch_card.scad>;

$fn=50;
eps = 0.1;
y_separation = 3.0;
x_separation = 10;

hollow_height = height+2.5;
hollow_width = width+2.5;
hollow_depth = depth+2.0;

extrude_depth = 7.0;

r=3.0;

x_num=1;
y_num=3;

outer_spacing=3.5;
outer_length=2*outer_spacing + x_num * (height+x_separation);
outer_width=2*outer_spacing + y_num * (width+y_separation);

rail_offset = 4;
rail_thickness = 2.0;
tol=0.15;


module base_outline(dim, r) {
    hull() {
        translate([r,r,0]) circle(r);
        translate([dim[0]-r,r,0]) circle(r);
        translate([dim[0]-r,dim[1]-r,0]) circle(r);
        translate([r,dim[1]-r,0]) circle(r);
    }
}

module rail_attachment(offset, length, thickness) {
    slot_diameter = thickness;
    slot_offset = offset;
    union() {
        rotate([180, 0, 0])
        difference() {
            translate([slot_offset, 0, 0])
            square([length - 2 * slot_offset, 2*thickness+eps]);

            *translate([slot_offset, 0.8*thickness, 0])
            circle(r=1);
            *translate([length - slot_offset, 0.8*thickness, 0])
            circle(r=1);
        }
        hull() {
            translate([slot_offset, 0, 0])
                circle(d=slot_diameter);

            translate([length - slot_offset, 0, 0])
                circle(d=slot_diameter);
        }
    }
}

module case() {
difference() {
    union() {
        linear_extrude(extrude_depth)
        base_outline([outer_length, outer_width], r);

        translate([0, 0, -rail_thickness])
        rotate([-90, 0, 0])
        linear_extrude(outer_width, convexity=2)
        offset(r=-tol)
        rail_attachment(rail_offset, outer_length, rail_thickness);

    }

    translate([0, 0, extrude_depth-rail_thickness])
    rotate([-90, 0, 0])
    linear_extrude(outer_width, convexity=2)
    offset(r=tol)
    rail_attachment(rail_offset, outer_length, rail_thickness);
    

    for (x=[0:x_num-1]) {
        for (y=[0:y_num-1]) {
            factor = 0.05;
            x_pos=outer_spacing + x_separation/2 + x*(height + x_separation) - height * factor/2;
            y_pos=outer_spacing + y_separation/2 + y*(width + y_separation) - width * factor/2;
            translate([x_pos, y_pos, 0.35]) scale([1 + factor, 1 + factor, 2])
                    base_form();

            cylinder_radius=3.5;
            new_x_pos=outer_spacing + x_separation/2 + x*(height + x_separation) - height*factor/2;
            new_y_pos=outer_spacing + y_separation/2 + width/2.0 + y*(width + y_separation);
            translate([new_x_pos,new_y_pos, 0.35])
            hull() {
                translate([0, -1.5, 0])
                cylinder(r1=cylinder_radius, r2=cylinder_radius, h=hollow_depth);

                translate([0, 1.5, 0])
                cylinder(r1=cylinder_radius, r2=cylinder_radius, h=hollow_depth);
            }

            new2_x_pos=outer_spacing + x_separation/2 + x*(height + x_separation) + height*(1 + factor/2);
            new2_y_pos=outer_spacing + y_separation/2 + width/2.0 + y*(width + y_separation);
            translate([new2_x_pos,new2_y_pos, 0.35])
            hull() {
                translate([0, -1.5, 0])
                cylinder(r1=cylinder_radius, r2=cylinder_radius, h=hollow_depth);

                translate([0, 1.5, 0])
                cylinder(r1=cylinder_radius, r2=cylinder_radius, h=hollow_depth);
            }
        }
    }
}
}

case();
*translate([0, 0, extrude_depth])
case();

for (x=[0:x_num-1]) {
    for (y=[0:y_num-1]) {
        x_pos=outer_spacing + x_separation/2 + x*(height + x_separation);
        y_pos=outer_spacing + y_separation/2 + y*(width + y_separation);
        %translate([x_pos, y_pos, 0.35])
            cartridge("Blah", "blah");
    }
}
