include <BOSL/constants.scad>
include <BOSL/transforms.scad>
use <BOSL/masks.scad>


resolution = 100;

diameter = 200;
height = 6;
filletSize = 50;

holeSpacing = 85.6;

screwDiameter = 6;
screwHeadDiameter = 10;

difference(){
    difference(){
        cylinder(d=diameter, h=height, center=false);
        up(height) fillet_cylinder_mask(r=diameter/2, fillet = filletSize, $fn = resolution);
    }

    translate([0,-holeSpacing/2, -(height-2)]){
        union(){
            cylinder(d=screwDiameter, h=height, center=false);
            up(height) cylinder(d=screwHeadDiameter, h=height, center=false);
            
        }
    }
    
    translate([0,holeSpacing/2, -(height-2)]){
        union(){
            cylinder(d=screwDiameter, h=height, center=false);
            up(height) cylinder(d=screwHeadDiameter, h=height, center=false);
            
        }
    }
}