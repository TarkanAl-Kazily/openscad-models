/*
 * A basic organizer print of a box with four box inserts.
 *
 * Author: Tarkan Al-Kazily - tarkan.alkazily (at) gmail.com
 */

// Configurable parameters

/* [Outer Box Dimensions] */
outer_x = 10.0; // width
outer_y = 10.0; // depth
outer_z = 5.0;  // height


/* [Insert Boxes Coordinate] */
// Defines the 2d coordinate the four inserts meet at in the box
insert_intersect_x = 5.0; 
insert_intersect_y = 5.0; 

/* [Other Constants] */
WALL_THICKNESS = 0.1;
INSERT_SPACING = 0.050;

/* [Render Controls] */
RENDER_OUTER_BOX = true;
RENDER_INSERTS = true;
RENDER_JUST_FIRST_INSERT = false;

/*
 * Declarations
 */
if (RENDER_OUTER_BOX) {
    outer_box();
}

if (RENDER_INSERTS) {
    inserts();
}


/*
 * Modules
 */
module _box(x, y, z) {
    difference() {
        cube([x, y, z], center=false);
        translate([WALL_THICKNESS, WALL_THICKNESS, WALL_THICKNESS]) {
            cube([x - 2 * WALL_THICKNESS, y - 2 * WALL_THICKNESS, z], center=false);
        }
    }
}

module outer_box() {
    _box(outer_x, outer_y, outer_z);
}

module inserts() {
    for (i = [0:1], j = [0:1]) {
        // Calculate the needed outer dimension of the insert
        delta_x = i == 0 ? insert_intersect_x : outer_x - insert_intersect_x;
        x = delta_x - WALL_THICKNESS - INSERT_SPACING - INSERT_SPACING / 2;

        delta_y = i == 0 ? insert_intersect_y : outer_y - insert_intersect_y;
        y = delta_y - WALL_THICKNESS - INSERT_SPACING - INSERT_SPACING / 2;

        z = outer_z - WALL_THICKNESS - INSERT_SPACING;

        translate_x = i == 0 ? WALL_THICKNESS + INSERT_SPACING : insert_intersect_x + INSERT_SPACING / 2;
        translate_y = j == 0 ? WALL_THICKNESS + INSERT_SPACING : insert_intersect_y + INSERT_SPACING / 2;

        if (!RENDER_JUST_FIRST_INSERT || (i == 0 && j == 0)) {
            translate([translate_x, translate_y, WALL_THICKNESS]) {
                _box(x, y, z);
            }
        }
    }
}
