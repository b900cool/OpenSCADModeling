use <../Models/ParametricRings.scad>
use <SlatwallHook.scad>

include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/masks.scad>

$fn = 50;

ringDiameter = 21;
ringCount = 1;
ringRows = 1;
ringThickness = 5;
ringOverlapRatio = .15;
ringFilletSize = 1;
ringHeight = 5;
ringHoleChamferSize = 1;

totalWidth = ((ringDiameter+(ringThickness*2)) * ringCount) - ((ringThickness * ringOverlapRatio) * ((ringCount-1)));

backFilletSize = 2;
backDepth = 5;
backHeight = 10;
baseHeight = 2;
backSize = [totalWidth, backDepth, backHeight + baseHeight];

translate([totalWidth - backFilletSize, -8, backHeight - backFilletSize]){
    rotate([0,0,90]){
        SlatwallHook(width = totalWidth-backFilletSize*2);
    }
}

// Construct the back piece
translate(backSize/2){
    fillet(fillet=backFilletSize, size=backSize, edges = EDGES_ALL){
        cube(size = backSize, center=true); 
    }
}

// Create Circles
up(backFilletSize){ 
    back(backDepth-(ringThickness*ringOverlapRatio)){
        parametricRings(ringCount, ringRows, ringDiameter, ringHeight, ringThickness, ringOverlapRatio, ringFilletSize, ringHoleChamferSize);
    }
}
