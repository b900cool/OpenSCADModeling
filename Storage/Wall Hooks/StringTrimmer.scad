include<BOSL/transforms.scad>;
include<BOSL/masks.scad>;

$fn = 50;
filletSize = 3;

motorBodyWidth = 92;
bodyWith = 56;
armHeight = 95;
motorCylinderHeight = 50;
backPlateDepth = 25;
armSize = 10;
motorSphereRadius = 46;
motorOffset = 15;

screwHoleSize = 4;
screwHeadSize = 9;
screwHeadDepth = 5;


backPlate = [motorBodyWidth + armSize*2, backPlateDepth, armHeight];
hookBase = [motorBodyWidth + armSize*2, motorBodyWidth + armSize*2, armHeight];
cutout = [60, (motorBodyWidth + armSize*2)/2 + 1, armHeight];

difference(){
    union(){
        back(motorBodyWidth/2 + backPlateDepth/2)
        fillet(size=hookBase, fillet=filletSize, edges = EDGES_ALL - EDGES_FRONT){
            cube(backPlate, center=true);
        }

        difference(){
            fillet(size=hookBase, fillet=filletSize){
                cube(hookBase, center=true);
            }
            down(motorOffset - 5){
            up(motorCylinderHeight/2)
            cylinder(h=motorCylinderHeight + motorOffset, d=motorBodyWidth, center=true);
            
            sphere(r=motorSphereRadius);
            }
            forward(cutout[1]/2)
            cube(cutout, center=true);
        }
    }
    back(motorBodyWidth/2 - 1)
    rotate([-90,0,0]){
        back(10)
        screw(screwHeadSize, screwHoleSize, screwHeadDepth, 30);
        forward(40)
        screw(screwHeadSize, screwHoleSize, screwHeadDepth, 30);
    }
}
module screw(headDiameter, screwDiameter, headDepth, screwLength){
    union(){
        cylinder(r1=headDiameter/2, r2=screwDiameter/2, h=headDepth);
        cylinder(d=screwDiameter, h=screwLength);
    }
}
