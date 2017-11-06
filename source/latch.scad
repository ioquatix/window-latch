
use <zcube.scad>;
use <bolts.scad>;

width = 42;
height = 14;
thickness = 4;

diameter = 4;

// Make a hole. The diameter is the size of the screw (e.g. 3 for M3). Depth is how far the hole should go for the thread, and inset is how far out there should be a hole for the head to go.
module bolt_mount(diameter=3, depth=6, inset=10) {
	cylinder_outer(depth, diameter/2);
	translate([0, 0, depth]) cylinder_outer(inset, diameter, 32);
}

module bracket(spacing=32) {
	difference() {
		zcube([width, height, 4]);
		translate([-spacing/2, 0, 0]) countersunk_hole(4, depth=thickness);
		translate([spacing/2, 0, 0]) countersunk_hole(4, depth=thickness);
	}
}

module latch(diameter=3) {
	difference() {
		union() {
			bracket()
			translate([0, -height/2, diameter]) rotate(90, [-1, 0, 0]) cylinder_outer(height, diameter, 32);
			zcube([height, height, height]);
		}
		
		zcube([height, 6, height]);
		translate([0, -height/2, height/2]) rotate(90, [-1, 0, 0]) countersunk_bolt(diameter, depth=height, nut_offset=0, shaft_length=0);
	}
}

render() base();