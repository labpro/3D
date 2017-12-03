
R = 8;
H = 10;

union()
{
    cube([24,8,H]);
    translate([12,R,0])cylinder(r=12,h=H);
}
