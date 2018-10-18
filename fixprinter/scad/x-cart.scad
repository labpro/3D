
module xcart(){

  size = 64*I+81*J/2+7*K;

  screw_hole_diameter = (115/100)*3*in/32 ;
  screw_hole_diameter = (25/100)*3*in/32 ;

  part();
  mirror(J)
  part();
  module part(){
    difference(){
      cblock(size);
      union(){

        hole();
        mirror(I)
        hole();
      }
    }
  }

  module hole(){

    A = 31*I/2 + 47*J/2;


    translate(A+14*J)
    cylinder(r=screw_hole_diameter/2,h=7,$fn=10);
    translate(A-14*J)
    cylinder(r=screw_hole_diameter/2,h=7,$fn=10);

    r = 0.5;
    translate(24*I)
    cylinder(r=r,h=7,$fn=10);

    translate(-24*I)
    cylinder(r=r,h=7,$fn=10);

  }





}

