module bedcart(){
  paper_x = 216;
  screw_dist = 209;

  shaft_dist = 170;

  box_size = 216*(I+J)+K;

  bearing_size = 16*I+25*J+K;

  bearing_dist = 70;
  
  translate((paper_x-box_size*I)*I/2+10*J+box_size/2-K)
  difference(){
    cube(box_size,center=true);
    union(){
      cutoffs();
      bearing();
      holes();
    }
  }

  module cutoffs(){

    i = [1,0];
    j = [0,1];


    mirror(J)
    shape1();
    shape1();

    mirror(I)
    shape2();
    shape2();

    module shape1(){

      x = shaft_dist/2;
      y = box_size*J/2;
  
      p = [

        -x*i/2-y*j,
        -(50/100)*y*j,
        +x*i/2-y*j,

      ];

      tz(-0.5)
      linear_extrude(1)
      polygon(p);
    }

    module shape2(){

      sd = shaft_dist/2;
      bs = box_size*J/2;
  
      p = [

        -bs*i+1*in*j/2,
        -sd*i,
        -bs*i-1*in*j/2,

      ];

      tz(-0.5)
      linear_extrude(1)
      polygon(p);
    }

  }

  module bearing(){

    a = shaft_dist*I/2+bearing_dist*J/2;

    set();
    mirror(J)
    set();

    module set(){
      translate(+a)
      cube(bearing_size,center=true);

      translate(-a)
      cube(bearing_size,center=true);
    }

  }

  module holes(){
    a = (+I+J)*screw_dist/2;
    b = (-I+J)*screw_dist/2;
    c = (+I-J)*screw_dist/2;
    d = (-I-J)*screw_dist/2;
    translate(a)
    cylinder(r=screw_r,h=1,center=true);
  
    translate(b)
    cylinder(r=screw_r,h=1,center=true);

    translate(c)
    cylinder(r=screw_r,h=1,center=true);
  
    translate(d)
    cylinder(r=screw_r,h=1,center=true);

    e = 1*in/2;
    ty(+e)
    cylinder(r=screw_r,h=1,center=true);
    
    ty(-e)
    cylinder(r=screw_r,h=1,center=true);

    cylinder(r=screw_r,h=1,center=true);


    mirror(I)
    bearing_holes();

    mirror(J)
    bearing_holes();

    mirror(I)
    mirror(J)
    bearing_holes();

    bearing_holes();
    module bearing_holes(){
      gap = (box_size*I-shaft_dist-bearing_size*I)/2;

      translate((-gap/2+box_size*I/2)*I+bearing_dist*J/2)
      cylinder(r=screw_r,h=1,center=true);

      translate((-3*gap/2-bearing_size*I+box_size*I/2)*I+bearing_dist*J/2)
      cylinder(r=screw_r,h=1,center=true);
    }
  }

}

module bed_belt_idler(){
  
  height = 4+13*in/16+6;


}
