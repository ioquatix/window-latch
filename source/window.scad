
use <base.scad>;
use <latch.scad>;
use <bar.scad>;

base();
translate([0, 21, -6]) {
	latch();
	
	translate([0, 3, 7]) rotate(90, [0, -1, 0]) rotate(90, [1, 0, 0]) bar();
}