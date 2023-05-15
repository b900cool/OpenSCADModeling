include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <../Models/HollowCylinder.scad>
use <../Models/PegboardHook.scad>
use <../Models/ParametricRings.scad>
use <BOSL/masks.scad>


//Global Variables
Count = 2;
Rows = 1;

//Cylinder Variables
diameter = 49;
height = 15;
thickness = 16;
resolution = 100;

filletSize = 2;
filletSizeBack = 2;
holeChamferSize = 3;

//Cylider Base Variables
BaseHeight = 0;

//Backplate Variables
depth = 5;
backHeight = 20;

//Pegboard Variables
hookDiameter = 4;
hookLength = 7;
hookHeight = 10;
hookRadius = hookDiameter/2;
holeDiameter = 6;
holeRadius = holeDiameter/2;
holeSpacingEdgeToEdge = 19;
holeSpacing = holeSpacingEdgeToEdge + holeRadius;
overlapRatio = .1;
totalBasketWidth = ((diameter+(thickness*2)) * Count) - ((thickness * overlapRatio) * ((Count-1)));

//Subtract hook diameter from these variables to avoid pegs overhanging the edge of the back
hookCount = ceil((totalBasketWidth - hookDiameter - filletSizeBack) / holeSpacing);
hooksWidth = (hookCount - 1) * (holeSpacing);

// Cacluate the difference between the total width of the back against the total width of the pegs on the back so that the pegs can be centered on the backing piece
excess = totalBasketWidth - hooksWidth;

//Hook Variables
hookStartX = excess/2;
hookY = 0;
hookZ = (backHeight + BaseHeight) - (filletSizeBack + 1 + hookRadius);

//Backpiece size vector
backSize = [totalBasketWidth, depth, backHeight + BaseHeight];
backSizeHalf = backSize/2;

// Create Circles
// Translate to start at X = 0, y = depth
translate([0,depth,0]){
    parametricRings(Count, Rows, diameter, height, thickness, overlapRatio, filletSize, holeChamferSize);
}

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




