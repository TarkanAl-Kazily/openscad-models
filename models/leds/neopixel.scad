/*
 * Neopixel LED Library
 *
 * Includes modules for
 *  - a single square LED
 *  - square LED on a PCB breakout
 *  - a 12 pixel ring
 *  - a helper function to make new neopixel rings
 */

// Small positive value constant
eps=0.1;

$fn=50;

module neopixel_led(center=false, color="silver") {
    // The square neopixel - https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf
    // Values in mm
    square_width = 5.0;
    square_height = 5.0;

    full_height = 2.8;
    pcb_height = 1.4;
    led_height = full_height-pcb_height;

    translate(center ? [-square_width/2, -square_height/2, 0] : [0, 0, 0])
    union() {
        color("white")
            linear_extrude(led_height)
            square([square_width, square_height]);

        %color(color)
            translate([square_width/2, square_height/2, led_height-0.1])
            linear_extrude(0.1 + eps)
            circle(d=0.9*square_width);
    }
}

module neopixel_led_breakoff(color="silver") {
    // https://www.amazon.com/gp/product/B01DC0J0WS
    // Values in mm
    pcb_diameter = 10;
    pcb_height = 1.4;
    union() {
        color("lavender")
            linear_extrude(pcb_height)
            circle(d=pcb_diameter);

        translate([0, 0, pcb_height])
            neopixel_led(center=true, color=color);
    }
}

module annulus(inner_diameter, annulus_width) {
    difference() {
        offset(annulus_width)
        circle(d=inner_diameter);
        circle(d=inner_diameter);
    }
}

module neopixel_led_general_ring(inner_diameter, annulus_width, pcb_height, num_leds, colors, pixel_buffer) {
    // Generic neopixel ring
    // Construct annulus pcb
    linear_extrude(pcb_height, convexity=2)
    annulus(inner_diameter, annulus_width);
    // Add the neopixels
    for (i = [0:num_leds-1]) {
        rotate(i * 360/num_leds, [0, 0, 1])
        translate([inner_diameter/2 + annulus_width/2, 0, pcb_height])
        minkowski() {
            neopixel_led(center=true, color=i < len(colors) ? colors[i] : "silver");
            sphere(r=pixel_buffer);
        }
    }
}

module neopixel_led_12px_ring(colors, pixel_buffer=0) {
    // Our 12 led ring
    // Values in mm
    inner_diameter = 36.25;
    annulus_width = 7.5;
    pcb_height = 1.6;
    num_leds = 12;
    module screw_holes() {
        screw_hole_diameter = 2.25;
        screw_radial_offset = 0.5;
        screw_hole_centers = inner_diameter/2 + annulus_width - screw_radial_offset - screw_hole_diameter/2;
        union() {
            for (i = [0:3]) {
                rotate(45 + i * 90, [0, 0, 1])
                translate([screw_hole_centers, 0, -eps])
                linear_extrude(pcb_height + 2*eps)
                circle(d=screw_hole_diameter);
            }
        }
    }

    difference() {
        neopixel_led_general_ring(inner_diameter, annulus_width, pcb_height, num_leds, colors, pixel_buffer);
        screw_holes();
    }
}

neopixel_led_12px_ring(["royalblue", "yellow",
"royalblue", "yellow",
"royalblue", "yellow",
"royalblue", "yellow",
"royalblue", "yellow",
"royalblue", "yellow"]);

translate([-10,0,0])
    neopixel_led(center=true, color="red");

translate([10,0,0])
    neopixel_led(center=true, color="green");

neopixel_led_breakoff(color="royalblue");
