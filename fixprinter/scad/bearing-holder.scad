module bearing_holder(

  length              = 25      ,

  wall_thick          = 3       ,

  screw_hole_diameter = (115/100)*3*in/32 ,
  screw_hole_length   = 3*in/16 ,

  screw_head_diameter = (118/100)*3*in/16 ,
  screw_head_length   = (120/100)*1*in/16 ,

  screw_resolution    = 20      ,
  screw_type          = "conic" ,
  screw_quantity      = 2       ,

  base_x              = 6       ,

  ){

  bearing_size = 16*IJ+length*K;
  size         = bearing_size+wall_thick*(2*I+J+2*K);
  base_size    = 
    base_x*I+
    (length+2*wall_thick)*J+
    screw_hole_length*K;

  
  difference(){
    holder();
    cutoff();
  }
  
  module cutoff(){
    size = (60/100)*length*J + bearing_size*I*I+10*wall_thick*K;
    ty(wall_thick+length/2)
    cblock(size,cy=true);
  }

  module holder(){
    rx(-90)
    rz(180)
    difference(){
      cblock(size);
      ty(bearing_size*J/2)
      bearing();
    }
    module bearing(){
      tz(wall_thick)
      cblock(bearing_size,cy=true);
      cylinder(r=(80/100)*bearing_size*I/2,h=size*K,$fn=50);
    }
    d = (size+base_size)*I/2;
    tx(+d)
    base();
    tx(-d)
    base();
  }
  module base(){
    difference(){
      cblock(base_size);

      ty(base_size*J/2)
      screw(screw_type,n=screw_quantity,$fn=screw_resolution);

    }
    module screw(type="hole"){
      union(){
        if(type == "conic"){
          union(){
            cylinder(
              r=screw_hole_diameter/2,
              h=screw_hole_length);
              tz(screw_hole_length-screw_head_length)
            cylinder(
            r1=screw_hole_diameter/2,
            r2=screw_head_diameter/2,
            h=screw_head_length);
          }
        }
        else if(type == "squared"){
          union(){
            cylinder(
              r=screw_hole_diameter/2,
              h=screw_hole_length);
              tz(screw_hole_length-screw_head_length)
            cylinder(
            r=screw_head_diameter/2,
            h=screw_head_length);
          }
        }
        else {
          cylinder(
            r=screw_hole_diameter/2,
            h=screw_hole_length);
        }
      }
    }
  }

}
