
use <bottom.scad>;
use <top.scad>;
use <bar.scad>;

use <zcube.scad>;

bottom();

render() translate([0, 21, -6]) {
	top();
	
	translate([0, 0, 12]) {
		// Locked position
		rotate(-90, [1, 0, 0]) translate([0, -3, -21+5]) 
		
		rotate(-90, [0, 1, 0]) bar();
	}
}

translate([0, 21+50, -6-7-4]) {
	color("green") zcube([100, 100, 4]);
}

translate([0, 21+50, (-6-7)+30]) {
	color("green") zcube([100, 100, 4]);
}