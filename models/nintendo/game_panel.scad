// Showcase of Nintendo Labo Font
//
// Units in mm
$fn=100;

tft_display_diagonal = 40;
tft_display_side = sin(45) * tft_display_diagonal;

// Vertical layout of regions
top_tft_spacing = 5; // from top of panel to tft
bottom_tft_spacing = 5; // from bottom of tft to top of buttons
bottom_button_spacing = 25; // from bottom of buttons to bottom of panel

// Horizontal layout of regions
left_tft_spacing = 13;
right_tft_spacing = 13;

button_horiz_separation = 12;
button_vert_separation = 4;
button_diameter=8;
button_region = button_diameter + button_vert_separation;

a_button_left_separation = left_tft_spacing + tft_display_side - button_horiz_separation + 2;
a_button_bottom_separation= bottom_button_spacing;

panel_width = left_tft_spacing + tft_display_side + right_tft_spacing;
panel_height = top_tft_spacing + tft_display_side + bottom_tft_spacing + button_region + bottom_button_spacing;

panel_rounding=0.7;
tft_hole_rounding=0.5;

module labo_symbol(symbol) {
    text(symbol, 5, "Labo Symbols:style=Regular", halign="center", valign="center");
}

module tft_cutout() {
    offset(r=tft_hole_rounding)
    square([tft_display_side, tft_display_side]);
}

module buttons() {
    circle(d=button_diameter);
    translate([button_horiz_separation, button_vert_separation, 0])
    circle(d=button_diameter);
}

module button_labels() {
    labo_symbol("A");
    translate([button_horiz_separation, button_vert_separation, 0])
    labo_symbol("B");
}

color("silver")
linear_extrude(0.63)
difference() {
    offset(r=panel_rounding)
    square([panel_width, panel_height]);

    translate([left_tft_spacing, panel_height - top_tft_spacing - tft_display_side, 0])
    tft_cutout();

    translate([a_button_left_separation, a_button_bottom_separation, 0])
    offset(r=0.5)
    buttons();
}


%color("red")
translate([a_button_left_separation, a_button_bottom_separation, 0])
difference() {
linear_extrude(2)
buttons();

translate([0, 0, 1.1])
linear_extrude(1,convexity=4)
button_labels();
}
