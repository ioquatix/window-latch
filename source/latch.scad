
use <bottom.scad>;
use <top.scad>;
use <bar.scad>;

translate([24, 8, 0]) bottom();
translate([-24, 8, 0]) top();
translate([-50, -8, 4]) bar();
