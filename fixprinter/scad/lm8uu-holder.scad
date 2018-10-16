module lm8uu_holder(n=1){

  length = 25;
  bearing_size = 16*IJ+length*K;
  wall_thick = 3;
  base_x = 6;
  base_y = 4;

  size      = bearing_size+wall_thick*(2*I+J);
  base_size = base_x*I+base_y*J+(length+2*wall_thick)*K;

  
  holder();

  module holder(){
    %tz(wall_thick)
    union(){
      difference(){
        cblock(size);
        cblock(bearing_size);
      }
      tz(length)
      cover();
      tz(-wall_thick)
      cover();
    }
    base();
    module cover(){
      csize = size*I*I+size*J*J+wall_thick*K;

        difference(){
          cblock(csize);
          ty(bearing_size*J/2)
          cylinder(
            r=(75/100)*bearing_size*I/2,
            h=wall_thick,
            $fn=50);
        }

    }
    module base(){


      //tx(wall_thick+size*I/2)
      shape();
      module shape(){
        difference(){
          %cblock(base_size);
        }
      }
      module screw(){
        tz(base_size*K/2)
        rx(-90)
        cylinder(r=screw_r,h=base_y);
      }
    }
  }


}
