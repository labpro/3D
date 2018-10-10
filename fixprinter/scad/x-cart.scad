
module xcart(){
  screw_dist = 48;
  
  bear_size = [50,16,1];
  bear_dist = 47;
  
  box_size = [70,83,1];
  gap = 30*(I+J);

  difference(){
    cube(box_size,center=true);
    holes();
  }

  module holes(){
  
    translate(+J*bear_dist/2)
    cube(bear_size,center=true);
  
    translate(-J*bear_dist/2)
    cube(bear_size,center=true);

    a = +I*screw_dist/2;
    b = -I*screw_dist/2;
    c = +I*30+36.5*J;
    d = -I*30+36.5*J;
    e = +I*30-36.5*J;
    f = -I*30-36.5*J;

    echo(a);
    echo(b);
    echo(c);
    echo(d);
    echo(e);
    echo(f);
  
    translate(a)
    cylinder(r=screw_r,h=1,center=true);
  
    translate(b)
    cylinder(r=screw_r,h=1,center=true);

    translate(c)
    cylinder(r=screw_r,h=1,center=true);
  
    translate(d)
    cylinder(r=screw_r,h=1,center=true);
  
    translate(e)
    cylinder(r=screw_r,h=1,center=true);
  
    translate(f)
    cylinder(r=screw_r,h=1,center=true);

    cylinder(r=screw_r,h=1,center=true);
  
  }
}

