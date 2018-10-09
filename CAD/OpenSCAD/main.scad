I = [1,0,0];
J = [0,1,0];
K = [0,0,1];

i = [1,0];
j = [0,1];

in = 25.4;
$fn = 10;

screw_d = 2*in/16;
screw_r = screw_d/2;
screw_dist = 48;

bear_size = [50,16,1];
bear_dist = 47;

box_size = [70,83,1];
gap = 30*(I+J);

projection(cut=true)
translate(gap+(box_size*I*I+box_size*J*J)/2)
rotate(90*K)
difference(){
  cube(box_size,center=true);
  holes();
}

module holes(){

  translate(+J*bear_dist/2)
  cube(bear_size,center=true);

  translate(-J*bear_dist/2)
  cube(bear_size,center=true);

  translate(+I*screw_dist/2)
  cylinder(r=screw_r,h=1,center=true);

  translate(-I*screw_dist/2)
  cylinder(r=screw_r,h=1,center=true);

  translate(-I*30+36.5*J)
  cylinder(r=screw_r,h=1,center=true);

  translate(+I*30+36.5*J)
  cylinder(r=screw_r,h=1,center=true);

  translate(+I*30-36.5*J)
  cylinder(r=screw_r,h=1,center=true);

  translate(-I*30-36.5*J)
  cylinder(r=screw_r,h=1,center=true);

}
