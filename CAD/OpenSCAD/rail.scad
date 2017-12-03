//include <MCAD/units.scad>
//include <MCAD/boxes.scad>


x = 10;
y = 10;
z = 10;


rail_x = 5;
rail_y = 7;

gap_x = x-rail_x;
gap_y = y-rail_y;



color("red",0.4)
cube([x,y,z]);

color("green",0.4)
translate([0,0,0])cube([rail_x,rail_y,z]);



