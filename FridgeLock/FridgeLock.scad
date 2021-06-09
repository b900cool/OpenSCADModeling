include <../Libs/BOSL-master/constants.scad>
use <../Libs/BOSL-master/masks.scad>

screwWidth = 25;

slotWidth = 2.5;

pillarOffsetWidth = 9;
pillarOffsetDepth = 50;

pillarDiameter = 5;
pillarHeight = 7;
pillarResolution = 100;

frontHeight = 14;
backHeight = 12;

frontDepthExtra = 10;

backDepth = 20;
frontDepth = pillarOffsetDepth + frontDepthExtra;

width = 50;
depth = backDepth + slotWidth + frontDepth;
height = 10;

//Base cube
translate([width/2, depth/2, height/2]){
    chamfer(chamfer=1, size=[width, depth, height], edges=EDGES_ALL - EDGES_TOP){
        cube(size=[width, depth, height], center=true);
    }
}

//Translate to work above base cube
translate([0,0,height]){
    //Front height cube
    difference(){
        translate([width/2, frontDepth/2, frontHeight/2]){
            chamfer(chamfer=1, size=[width, frontDepth, frontHeight], edges= EDGES_ALL - EDGES_BOTTOM){
                cube(size=[width, frontDepth, frontHeight], center=true);
            }
        }
        
        translate([pillarOffsetWidth,(frontDepthExtra + pillarDiameter/2),frontHeight - pillarHeight/2]){
            cylinder(d=pillarDiameter, h=pillarHeight, $fn=pillarResolution, center=true);
        }
        translate([width - pillarOffsetWidth,(frontDepthExtra + pillarDiameter/2),frontHeight - pillarHeight/2]){
            cylinder(d=pillarDiameter, h=pillarHeight, $fn=pillarResolution, center=true);
        }
    }
    //Behind slot
    translate([0, frontDepth + slotWidth, 0]){
        difference(){
            translate([width/2, backDepth/2, backHeight/2]){
                chamfer(chamfer=1, size=[width, backDepth, backHeight], edges= EDGES_ALL - EDGES_BOTTOM){
                cube(size=[width, backDepth, backHeight], center=true);
                }
            }
            translate([width/2, screwWidth/2, screwWidth/2]){
                cube(screwWidth, true);
            }   
        }
    }
}