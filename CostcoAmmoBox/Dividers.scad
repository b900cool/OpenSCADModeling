include <BOSL/constants.scad>
include <BOSL/transforms.scad>
use <BOSL/masks.scad>
use <AmmoBoxModel.scad>
use <../Models/lattice.scad>

floorWidth = 235;
floorDepth = 100;

ceilingWidth = 245;
ceilingDepth = 110;

height = 146;

widthDiff = ceilingWidth - floorWidth;
depthDiff = ceilingDepth - floorDepth;

dividerThickness = 3;

compartmentCountWidth = 4;
compartmentCountDepth = 2;

limitHeight = true;
heightLimit = 90;

floorSize = [floorWidth, floorDepth, 0.001];
ceilingSize = [ceilingWidth, ceilingDepth, 0.001];

if($preview){
    ammoBoxModel(baseSize=[floorWidth, floorDepth], topSize=[ceilingWidth, ceilingDepth], height = height);
}

if(limitHeight){
    difference(){
        drawDividers();
        translate([-widthDiff/2, -depthDiff/2, heightLimit]){
            cube(ceilingSize + [0,0,height-heightLimit]);
        }
    }
    
}
else{
    drawDividers();
}

module drawDividers() {
    intersection(){
        #ammoBoxInterior(baseSize=[floorWidth, floorDepth], topSize=[ceilingWidth, ceilingDepth], height = height);
        translate([-widthDiff/2, -depthDiff/2, 0]){
            lattice(width=ceilingWidth, depth=ceilingDepth, height=height, widthCompartments=2, depthCompartments=2);
        }
    }
}
