include <./utils.scad>

include <./x-cart.scad>
include <./bed-cart.scad>
include <./bearing-holder.scad>

$fn=10;

screw_d = 2*in/16;
screw_r = screw_d/2;

*projection(cut=true)
bedcart();

bearing_holder();
