
use <zcube.scad>;
use <bolts.scad>;

$fn = 64;

width = 14;
length = 100;
thickness = 8;
slide = 20;
dilate = 2;

module bevel() {
	cylinder(d1=dilate,d2=0);
	mirror([0, 0, 1]) cylinder(d1=dilate,d2=0);
}

module magnet(h=8,d=5) {
	cylinder_outer(h, d/2, 32, radial_error=0);
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
		translate([0, 0, dilate/2]) minkowski() {
			union() {
				multihull() {
					cylinder(d=width-dilate, h=thickness-dilate);
					translate([slide, 0, 0]) cylinder(d=width-dilate, h=thickness-dilate);
					//translate([slide, width/4, 0]) zcube([width/2, width/2, thickness]);
					//translate([length, width/4, 0]) zcube([width/2, width/2, thickness]);
					translate([length, 0, 0]) cylinder(d=width-dilate, h=thickness-dilate);
					translate([length+outset, outset, 0]) cylinder(d=width-dilate, h=thickness-dilate);
				}
				
				for (i = [20:40:length]) {
					hull() {
						translate([i, 0, 0]) cylinder(d=width-dilate, h=thickness-dilate);
						translate([i, -outset, 0]) cylinder(d=width-dilate, h=thickness-dilate);
					}
				}
			}
			
			bevel();
		}
		
		// Cut out a notch to make it easier to slide down?
		// translate([-width/2, width/2, 0]) rotate(45, [0, 0, 1]) zcube([sqrt(width*width*2)/2, sqrt(width*width*2)/2, width]);
		
		hull() {
			hole(3, depth=thickness, inset=0);
			translate([slide, 0, 0]) hole(3, depth=thickness, inset=0);
		}
		
		//translate([0, width/2, 0]) zcube([20, 4, thickness]);
		
		for (i = [20:40:length]) {
			translate([i, -outset, 0]) magnet();
		}
	}
}


bar();