include <./utils.scad>

include <./x-cart.scad>
include <./bed-cart.scad>
include <./lm8uu-holder.scad>

$fn=10;

screw_d = 2*in/16;
screw_r = screw_d/2;

*projection(cut=true)
bedcart();

lm8uu_holder();
