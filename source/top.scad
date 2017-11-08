
use <zcube.scad>;
use <bolts.scad>;

$fn = 64;

width = 44;

height = 14;
thickness = 4;

diameter = 4;

module bracket(spacing=32) {
	difference() {
		hull() {
			zcube([width, height, 4]);
			zcube([20, height, 10]);
		}
		translate([-spacing/2, 0, 0]) countersunk_hole(4, depth=thickness);
		translate([spacing/2, 0, 0]) countersunk_hole(4, depth=thickness);
	}
}

module top(latch_width=20, gap=8.2, outset=22) {
	difference() {
		union() {
			bracket();
			
			//translate([0, -height/2, diameter]) rotate(90, [-1, 0, 0]) cylinder_outer(height, diameter, 32);
			zcube([latch_width, height, outset/2+thickness]);
			translate([-latch_width/2, 0, outset/2+thickness]) rotate(90, [0, 1, 0]) cylinder(d=height, h=latch_width);
		}
		
		translate([0, 0, thickness+4]) zcube([gap, height, latch_width]);
		translate([-latch_width/2, 0, outset/2+thickness]) rotate(90, [0, 1, 0]) countersunk_bolt(3, depth=latch_width, nut_offset=0, shaft_length=0);
		
		translate([0, 0, outset/2+thickness]) rotate(90, [0, 1, 0]) {
			#cylinder(d=7.2,h=gap+0.4*2, center=true);
		}
	}
}

render() top();