include <./utils.scad>

include <./screw.scad>
include <./x-cart.scad>
include <./bed-cart.scad>
include <./bearing-holder.scad>

$fn=50;

screw_d = 2*in/16;
screw_r = screw_d/2;

*bed_belt_idler();

*rod_socket();

projection(cut=true)
xcart();



module rod_socket(){

  radius = 10;
  height = 25;
  screw_d = 2*in/16;

  d1 = 5;
  d2 = 8;
  $fn=10;

  
  difference(){
    %cylinder(r=radius,h=height,center=true);
    union(){
      %cylinder(r=d1/2,h=height/2);
      %tz(-height/4)
      cylinder(r=d2/2,h=height/2,center=true);

      union(){
        screw();

        rz(90)
        screw();
      }
      mirror(K)
      union(){
        screw();

        rz(90)
        screw();
      }

    }
  }
  module screw(){
    tz(height/4)
    ry(90)
    cylinder(r=screw_d/2,h=2*radius,center=true);
  }
  *test();

  module test(){


      D1 = (110/100)*d1;
      D2 = (104/100)*d2;

      *cylinder(r=D1/2,h=height/2);

      shape(D2);

      module shape(d=4){
        difference(){
          cblock((d+3)*IJ+5*K,cy=true);
          cylinder(r=d/2,h=5,$fn=50);
        }
      }
  }


}


//CubePoints = [
//  [  0,  0,  0 ],  //0
//  [ 10,  0,  0 ],  //1
//  [ 10,  7,  0 ],  //2
//  [  0,  7,  0 ],  //3
//  [  0,  0,  5 ],  //4
//  [ 10,  0,  5 ],  //5
//  [ 10,  7,  5 ],  //6
//  [  0,  7,  5 ]]; //7
//  
//CubeFaces = [
//  [0,1,2,3],  // bottom
//  [4,5,1,0],  // front
//  [7,6,5,4],  // top
//  [5,6,2,1],  // right
//  [6,7,3,2],  // back
//  [7,4,0,3]]; // left
//  
//*polyhedron( CubePoints, CubeFaces);

//fillet();
//
//function rotation(c,angle) = [
//  [,,],
//  [,,],
//  [,,]
//];
//
//module fillet(
//  A = O  ,
//  B = 10*K ,
//  r = 1   ,
//  angle = 90   ,
//  u = K+J
//){
//
//  v = B-A;
//
//  c  = v/sqrt(v*v);
//  c1 = c[0];
//  c2 = c[1];
//  c3 = c[2];
//
//  
//
//  echo(c);
//
//  p2 = A+r*d/sqrt(d*d);
//
//
//
//  cube(10);
//
//
//}









  
