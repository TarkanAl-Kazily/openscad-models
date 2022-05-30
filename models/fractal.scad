$fn=50;
$fs=0.01;
$fa=0.01;
$t=0.01;

width=0.1;

//           _
// Classic _| |_ segment fractal
module segment(depth, start, end) {
    //echo(depth=depth, start=start, end=end);
    length = norm(end - start);
    unit_vec = (end-start) / length;
    unit_perp = [-unit_vec[1], unit_vec[0]];
    if (depth > 0) {
        p0 = start;
        p1 = unit_vec * length/3 + p0;
        p2 = unit_perp * length/3 + p1;
        p3 = unit_vec * length/3 + p2;
        p4 = -unit_perp * length/3 + p3;
        p5 = end;
        segment(depth-1, p0, p1);
        segment(depth-1, p1, p2);
        segment(depth-1, p2, p3);
        segment(depth-1, p3, p4);
        segment(depth-1, p4, p5);
    } else {
        polygon([start, end, end + width * unit_perp, start + width * unit_perp]);
    }
}

module line(start, end) {
    length = norm(end - start);
    unit_vec = (end-start) / length;
    unit_perp = [-unit_vec[1], unit_vec[0]];
    polygon([start, end, end + width * unit_perp, start + width * unit_perp]);
}

// Change of base formula
function log_5(x) = log(x) / log(5);

function segment_fraction(string) = pow(1/3, log_5(len(string)+1));

function box_string(depth) = ( depth == 0 ? "" : str(box_string(depth-1), "L", box_string(depth-1), "R", box_string(depth-1), "R", box_string(depth-1), "L", box_string(depth-1)));

//segment(2, [0,0], [100,0]);

module draw_fractal(string, idx, p0, p1) {
    if (idx == 0) {
        length = norm(p1 - p0);
        unit_vec = (p1-p0) / length;
        segment_length = segment_fraction(string) * length;
        next = p0 + segment_length * unit_vec;
        line(p0, next);
        draw_fractal(string, 1, p0, next);
    } else if (idx <= len(string)) {
        c = string[idx - 1];
        next_L = p1 + [-(p1 - p0)[1], (p1 - p0)[0]];
        next_R = p1 + [(p1 - p0)[1], -(p1 - p0)[0]];
        if (c == "L") {
            line(p1, next_L);
            draw_fractal(string, idx + 1, p1, next_L);
        } else if (c == "R") {
            line(p1, next_R);
            draw_fractal(string, idx + 1, p1, next_R);
        }
    }
}

echo(box_string(1));
//5 is too much for draw_fractal(box_string(5), 0, [0, 0], [100, 0]);
segment(10, [0, 0], [100, 0]);
