
use <zcube.scad>;
use <bolts.scad>;

$fn = 64;

width = 14;
length = 100;
thickness = 8;
slide = 20;

module magnet(h=8,d=5) {
	cylinder_outer(h, d/2, 32);
}

module multihull() {
	union() {
		for (i = [0:1:$children-2])
			hull() {
				children(i);
				children(i+1);
			}
	}
}

module bar(outset=15) {
	translate([0, 0, -thickness/2]) difference() {
		union() {
			multihull() {
				cylinder(d=width, h=thickness);
				translate([slide, 0, 0]) cylinder(d=width, h=thickness);
				translate([slide, width/4, 0]) zcube([width/2, width/2, thickness]);
				translate([length, width/4, 0]) zcube([width/2, width/2, thickness]);
				translate([length, 0, 0]) cylinder(d=width, h=thickness);
				translate([length+outset, outset, 0]) cylinder(d=width, h=thickness);
			}
			
			for (i = [40:30:length]) {
				translate([i, 0, 0]) {
					cylinder(d=width, h=thickness);
				}
			}
		}
		
		hull() {
			hole(3, depth=thickness, inset=0);
			translate([slide, 0, 0]) hole(3, depth=thickness, inset=0);
		}
		
		//translate([0, width/2, 0]) zcube([20, 4, thickness]);
		
		for (i = [40:30:length]) {
			translate([i, 0, 0]) {
				magnet();
			}
		}
	}
}

bar();