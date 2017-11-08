
use <zcube.scad>;
use <bolts.scad>;

$fn = 64;

width = 44;
height = 14;
thickness = 4;
diameter = 4;

module magnet(h=3,d=5) {
	cylinder_outer(h, d/2, 32);
}

module bracket(spacing=30) {
	difference() {
		zcube([width, height, thickness]);
		translate([0, 0, 2]) zcube([16, height, 2]);
		translate([-spacing/2, 0, 0]) countersunk_hole(5, depth=thickness);
		translate([ spacing/2, 0, 0]) countersunk_hole(5, depth=thickness);
	}
}

module side(height=height, thickness=thickness, diameter=8) {
	translate([thickness/2, 0, 0]) hull() {
		zcube([thickness, height, thickness]);
		translate([diameter/2+thickness/2, 6, 0]) cylinder_inner(thickness, diameter);
	}
}

module bottom(latch_width=20, gap=8.2, outset=10, offset=6, inset=2) {
	difference() {
		union() {
			bracket();
			
			hull() {
				zcube([latch_width, height, thickness]);
				translate([-latch_width/2, offset, outset/2+thickness]) rotate(90, [0, 1, 0]) cylinder(d=height, h=latch_width);
			}
		}
		
		translate([0, 0, thickness-inset]) zcube([gap, height+offset*2, latch_width]);
		
		translate([0, height/2, 0]) rotate(-60, [1, 0, 0]) translate([0, -height/2, 0]) zcube([gap, height*2, latch_width]);
		
		translate([-latch_width/2, offset, outset/2+thickness]) rotate(90, [0, 1, 0]) hole(3, depth=latch_width, nut_offset=0, shaft_length=0);
		
		translate([gap/2, offset, outset/2+thickness]) rotate(90, [0, 1, 0]) {
			magnet();
		}
		
		translate([-gap/2, offset, outset/2+thickness]) rotate(90, [0, 1, 0]) {
			mirror([0, 0, 1]) magnet();
		}
	}
}

bottom();