
use <bolts.scad>;

width = 14;
length = 80;
thickness = 6;

module bar() {
	difference() {
		hull() {
			cylinder(d=14, h=thickness);
			translate([length, 0, 0]) cylinder(d=14, h=thickness);
		}
		
		hole(3, depth=thickness, inset=0);
		
		for (i = [20:20:length]) {
			translate([i, 0, 0]) hull() {
				hole(4, depth=thickness, inset=0);
				translate([-2, -10, 0]) hole(6, depth=thickness, inset=0);
			}
		}
	}
}