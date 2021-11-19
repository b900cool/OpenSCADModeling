include <BOSL/constants.scad>
include <BOSL/transforms.scad>
include <../Models/HollowCylinder.scad>
include <../Models/PegboardHook.scad>
use <BOSL/masks.scad>

//Global Variables
Count = 2;
Rows = 1;

//Backplate Variables
depth = 5;
backHeight = 15;

resolution = 100;

filletSizeBack = 2;

// Mount variables
edgeToEdge = 91.5;
mountDiameter = 8;
mountDepth = 6;
mountPegDiameter = 5;
mountPegHeadDepth = 1.5;

centerToCenter = edgeToEdge + mountDiameter;

mountPegHeight = mountDepth - mountPegHeadDepth;



//Pegboard Variables
hookDiameter = 4;
hookLength = 7;
hookHeight = 9;
hookRadius = hookDiameter/2;
holeDiameter = 6;
holeRadius = holeDiameter/2;
holeSpacingEdgeToEdge = 19.4;
holeSpacing = holeSpacingEdgeToEdge + holeDiameter;
overlapRatio = .1;
totalBasketWidth = 120;

//Subtract hook diameter from these variables to avoid pegs overhanging the edge of the back
hookCount = ceil((totalBasketWidth - hookDiameter - filletSizeBack) / holeSpacing);
hooksWidth = (hookCount - 1) * (holeSpacing);

// Cacluate the difference between the total width of the back against the total width of the pegs on the back so that the pegs can be centered on the backing piece
excess = totalBasketWidth - hooksWidth;

//Hook Variables
hookStartX = excess/2;
hookY = 0;
hookZ = backHeight - (filletSizeBack + hookRadius);

//Backpiece size vector
backSize = [totalBasketWidth, depth, backHeight];
backSizeHalf = backSize/2;



// Construct the back piece
translate(backSizeHalf){
    fillet(fillet=filletSizeBack, size=backSize, $fn=resolution, edges = EDGES_ALL){
        cube(size = backSize, center=true); 
    }
}

// Create all of the hooks for the back piece
for (i = [0 : 1 : hookCount-1]){
    translate([hookStartX + (holeSpacing * i), hookY, hookZ])
        pegboardHook(hookDiameter, hookLength, hookHeight, resolution);
}

translate([totalBasketWidth/2 + centerToCenter/2,depth,backHeight/2]){
    rotate([-90,0,0]){
        union(){
            cylinder(h=mountPegHeight, d=mountPegDiameter, center=false, $fn=resolution);
            up(mountPegHeight){
                difference() {
                    cylinder(h=mountPegHeadDepth, d=mountDiameter, center=false, $fn=resolution);             
                    up(1.5) fillet_cylinder_mask(r=mountDiameter/1.5, fillet=4, $fn=resolution);
                }
            }
        }
    }
}

translate([totalBasketWidth/2 - centerToCenter/2,depth,backHeight/2]){
    rotate([-90,0,0]){
        union(){
            cylinder(h=mountPegHeight, d=mountPegDiameter, center=false, $fn=resolution);
            up(mountPegHeight){
                difference() {
                    cylinder(h=mountPegHeadDepth, d=mountDiameter, center=false, $fn=resolution);             
                    up(1.5) fillet_cylinder_mask(r=mountDiameter/1.5, fillet=4, $fn=resolution);
                }
            }
        }
           
    }
}
