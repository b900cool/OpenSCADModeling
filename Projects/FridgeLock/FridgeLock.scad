include <BOSL/constants.scad>
use <BOSL/masks.scad>

screwCutoutWidth = 25;

slotWidth = 2.5;

pillarOffsetWidth = 9;
pillarOffsetDepth = 50;

pillarDiameter = 5;
pillarHeight = 7;
pillarResolution = 100;

frontHeight = 14;
backHeight = 12;

chamferSize = 1;

frontDepthExtra = 10;

backDepth = 20;
frontDepth = pillarOffsetDepth + frontDepthExtra;

width = 50;
depth = backDepth + slotWidth + frontDepth;
height = 10;

baseSize = [width, depth, height];
frontSize = [width, frontDepth, frontHeight];
backSize = [width, backDepth, backHeight];
screwCutoutSize = [screwCutoutWidth, backDepth, backHeight];

//Base cube
translate(baseSize/2){
    chamfer(chamfer=chamferSize, size=baseSize, edges=EDGES_ALL - EDGES_TOP){
        cube(size=baseSize, center=true);
    }
}

//Translate to work above base cube
translate([0,0,height]){
    //Front height cube
    difference(){
        translate(frontSize/2){
            chamfer(chamfer=chamferSize, size=frontSize, edges= EDGES_ALL - EDGES_BOTTOM){
                cube(size=frontSize, center=true);
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
            translate(backSize/2){
                chamfer(chamfer=chamferSize, size=backSize, edges= EDGES_ALL - EDGES_BOTTOM){
                cube(size=backSize, center=true);
                }
            }
            translate([screwCutoutWidth/2, 0, 0]){
                cube(screwCutoutSize, false);
            }   
        }
    }
}