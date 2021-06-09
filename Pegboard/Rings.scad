include <../Libs/BOSL-master/constants.scad>
include <../Libs/BOSL-master/transforms.scad>
include <../Models/HollowCylinder.scad>
include <../Models/PegboardHook.scad>
use <../Libs/BOSL-master/masks.scad>

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
totalBasketWidth = diameter * Count - (thickness*overlapRatio * Count-2);

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
translate([diameter/2,diameter/2 + depth,0]){
    for (i = [0 : 1 : Count - 1])
    {
        for(j = [0 : 1 : Rows - 1])
        {   
            // Translate each ring in a row by a diameter - a fraction of the thickness to provide some overlap between rings
            translateX = (i * diameter) - ((thickness*overlapRatio) * i);
            
            // Translate each ring in a column by a diameter - a fraction of the thickness to provide some overlap between rings. Add one to j to get the overlap with the back piece
            translateY = (j * diameter) - ((thickness*overlapRatio) * j + 1);
            
            translate([translateX, translateY, 0]){
                hollowCylinder(diameter, height, thickness, resolution, filletSize, holeChamferSize);
                cylinder(d=diameter, h=BaseHeight);
            }
        }

    }
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




