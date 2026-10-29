include <BOSL2/std.scad>
include <BOSL2/transforms.scad>
include <BOSL2/screws.scad>
use <BayonetConn/Bayonet_Lock_V2.scad>

// Module Naming 
// <CRATE SIZE><HOLE TYPE><PIECE NAME>

bumpOut = 5;

$fn = 100;

threadedInsertDiameter = 5.2;
threadedInsertDepth = 11;



module Plug(interiorDimensions, exteriorDimensions, plugDepth, extrudedDepth){
    difference(){
        prismoid(size1=interiorDimensions, size2=exteriorDimensions, h=plugDepth, rounding = 2, anchor = TOP);
        cyl(l = threadedInsertDepth, d = threadedInsertDiameter, anchor = TOP);
    }
}

// THIS SHIT BACKWARDS -> The taper is larger on the inside, not outside
module LargeStandardPlug(){
    frontWidth = 24.5;
    frontLength = 24.5;
    backWidth = 26.5;
    backLength = 26.5;
    depth = 12.5;
    width = 27.5;
    height = 2;
    union(){
        Plug(interiorDimensions=[backWidth,backLength], exteriorDimensions=[frontWidth,frontLength], plugDepth=depth, extrudedDepth=5);
        left(width/4)cyl(h = (height/2) - gap/2, r1 = 2, r2 = 1.5, anchor=BOT);
        right(width/4)cyl(h = (height/2) - gap/2, r1 = 2, r2 = 1.5, anchor=BOT);
    }
}

LargeStandardPlug();

/// BAYONET LOCK PARAMS
// What style of lock to produce, with the pin pointed inward ou outward?
pin_direction = "out"; //in or out?

//What to render
part_to_render = "lock"; //pin or lock?

//Render the mechanism with 2 to 6 locks / pins
number_of_pins = 4;

//Angular difference between shaft and lock
path_angle = 45; 

//Direction of the lock
turn_direction = "CW"; //CW or CCW?

//watch the difference between the numbers below, or your model will have holes in it. always remember that the pin size is a function of the diference between inner and outer diameters, as well as a function of the gap.
inner_radius = 6;
outer_radius = 13;

gap = 0.3; //only change this if you are confident on the precision of your printer

pin_radius = (outer_radius - inner_radius)/4.5; //Only change it if you are confident

//Height of the connector part
part_height = 10;

//Height of the connector part
conn_height = 3;

//Height of the lip part
lip_height = 5;

module LargeStandardWasher(){
    width = 27.5;
    length = 27.5;
    height = 2;
    difference(){
        cuboid(size=[width, length, height], rounding = 2, except = [TOP, BOT], anchor = BOT);
        up(height)screw("M4", head="flat",length=12, thread="none", anchor = "head_top");
        left(width/4)cyl(h = (height/2) + gap, r1 = 2 + gap, r2 = 1.5 + gap, anchor=BOT);
        right(width/4)cyl(h = (height/2) + gap, r1 = 2 + gap, r2 = 1.5 + gap, anchor=BOT);
    }
    up(height)
        Bayonet(part_to_render, pin_direction, number_of_pins, path_angle, turn_direction, inner_radius, outer_radius, part_height, conn_height, 0, gap = gap);   
}

module LargeStandardFitting(lip_texture=false){
    rotate([180,0,-path_angle]){
        Bayonet("pin", pin_direction, number_of_pins, path_angle, turn_direction, inner_radius, outer_radius, part_height, conn_height, lip_height, gap = gap, lip_texture=true);
    }
}

left(50){
    LargeStandardWasher();
    up(part_height)
    {
        LargeStandardFitting();
    }
}