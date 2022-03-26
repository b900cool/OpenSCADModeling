use<BOSL/masks.scad>
use<BOSL/transforms.scad>
include<BOSL/constants.scad>

$fn=30;

fillet = 1.5;

sensorWidth = 67;
sensorDepth = 41;
sensorHeight = 21;

sensor = [sensorWidth, sensorDepth, sensorHeight];

shadeThickness = 2;

shadeBase = [sensorWidth + shadeThickness, sensorDepth, sensorHeight + shadeThickness*2];
shade = [sensorWidth + shadeThickness, sensorDepth/2, sensorHeight + shadeThickness*2];

cylinderDiameter = 7;
cylinderHeight = sensorHeight + shadeThickness*2;

difference(){
    fillet(fillet, shadeBase, edges = EDGES_ALL - EDGES_BACK){
        cube(shadeBase, center = true);
    }
    
    right(shadeThickness/2)back(shadeThickness)
        cube(sensor, center = true);
    
    forward(sensorDepth/2 - shadeThickness/2) right(sensorWidth/2 - shadeThickness*2)cube([30, shadeThickness, sensorHeight], center = true);
    
    back(sensorDepth/2 - shadeThickness/2 - cylinderDiameter/2 - shadeThickness + 2)
    right(sensorWidth/2 - cylinderDiameter/2 - 2)
    #cylinder(d=cylinderDiameter, h=cylinderHeight, center=true);
    forward(sensorDepth/2 - shadeThickness/2 - cylinderDiameter/2 - 4)
    left(sensorWidth/2 - cylinderDiameter/2 - shadeThickness - 2)
    #cylinder(d=cylinderDiameter, h=cylinderHeight, center=true);
}

back(sensorDepth/1.35){
    difference(){
        fillet(fillet, shadeBase, edges = EDGES_ALL - EDGES_FRONT){
            cube(shade, center=true);
        }
        right(shadeThickness/2)
            cube(sensor, center = true);
        rotate([0,0,-16]){
            back(sensorDepth/2)cube(sensor + [100,0,shadeThickness*2], center = true);
        }
        
    }
}
