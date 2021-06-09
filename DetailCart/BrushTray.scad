include <../Libs/BOSL-master/constants.scad>
use <../Libs/BOSL-master/masks.scad>
use <../Models/BevelSquare.scad>

testFit = false;

testFitWallSize = 6;

width = 146;
depth = 58;
height = 64;

resolution = 100;

filletSize = 5;

cubeSize = [width, depth, height];

brushValues = [[10.4, 11.5, 22.4], [10.4, 11.5, 22.4], [8,9,17.7], [8,9,17.7], [7.9,8.7,14.8], [7.9,8.7,14.8]];
brushValuesLen = len(brushValues);

brushBuffer = 4;

brushGreatestValues = [for(i = [0:brushValuesLen-1]) brushValues[i][2]];
brushGreatestValue = max(brushGreatestValues);
    
extraDepthOffset = brushGreatestValue + brushBuffer*2;
extraDepth = depth - extraDepthOffset - filletSize * 2;




difference(){
    if(!testFit){
        translate([width/2, depth/2, height/2]){
            fillet(fillet=5, size=[width+.001, depth, height], edges=EDGES_TOP, $fn=resolution){
                cube(size=cubeSize, center=true);
            }
        }
    } else{
        
        difference(){
            cube([width, depth, testFitWallSize]);
            translate([testFitWallSize/2, testFitWallSize/2, 0]){
                cube([width - testFitWallSize, depth - testFitWallSize, testFitWallSize]);
            }
        }
    }

    // Brush holes
    for(i = [0:brushValuesLen-1]){
        
        brushVector=brushValues[i];
        
        lowerDiameter = brushVector[0];
        upperDiameter = brushVector[1];
        largestDiameter = brushVector[2];
        
        centerOffset = (brushGreatestValue - largestDiameter)/2;
        
        summativeOffset =  i-1 < 0 ? 0 : addUpTo(i-1, brushVector);
        
        brushOffset = largestDiameter/2 + brushBuffer;
        
        translate([brushOffset + summativeOffset + (brushBuffer*i), brushOffset + centerOffset, 0]){

             cylinder(height, d1=lowerDiameter, d2=upperDiameter, $fn=resolution, center=false); 
             translate([0,0,height]){
                    fillet_hole_mask(d=lowerDiameter, fillet=3, $fn = resolution);
                }
            
        }
    }
    translate([filletSize*2,extraDepthOffset,0]){
        bevelSquare(width - filletSize*4, extraDepth, height+.1, filletSize, resolution);
    }
    
}

translate([-10,0,0]){
    
}
function addUpTo(n, vector, sum=0) = ( n<=0 ? brushGreatestValues[n] : sum + brushGreatestValues[n] + addUpTo(n-1, vector, sum) );