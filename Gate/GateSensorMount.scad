include <BOSL/masks.scad>
include <BOSL/transforms.scad>

$fn = 100;
chamfer = 1;

width = 50;
depth = 50;
height = 25;

sensorWidth = 22;
sensorDepth = 32;
sensorHeight = 4;

screwDiameter = 4;
screwHeadDiameter = 8;
screwHeadDepth = 5;

channelWidth = sensorWidth/3;
channelDepth = (depth - sensorDepth) /2;
channelHeight = sensorHeight;

screwEdgeOffset = chamfer + screwHeadDiameter/2;

channel = [channelWidth, channelDepth, channelHeight];
sensor = [sensorWidth, sensorDepth, sensorHeight];
block = [width, depth, height];

echo(channel);

difference(){
    chamfer(chamfer, block){
        cube(block, center = true);
    }
    up(height/2-sensorHeight/2) {
        cube(sensor, center=true);
        back(sensorDepth/2 + channelDepth/2){
            right(sensorWidth/3){
                cube(channel, center=true);
            }
        }
    }
    
    forward(depth/2 - screwEdgeOffset){
        left(width/2 - screwEdgeOffset){
            union(){
                cylinder(h=height, d=screwDiameter, center=true);
                up(height/2 - screwHeadDepth/2)cylinder(h=screwHeadDepth, d=screwHeadDiameter, center=true);
            }
        }
    }
    
    back(depth/2 - screwEdgeOffset){
        left(width/2 - screwEdgeOffset){
            union(){
                cylinder(h=height, d=screwDiameter, center=true);
                up(height/2 - screwHeadDepth/2)cylinder(h=screwHeadDepth, d=screwHeadDiameter, center=true);
            }
        }
    }
    
    forward(depth/2 - screwEdgeOffset){
        right(width/2 - screwEdgeOffset){
            union(){
                cylinder(h=height, d=screwDiameter, center=true);
                up(height/2 - screwHeadDepth/2)cylinder(h=screwHeadDepth, d=screwHeadDiameter, center=true);
            }
        }
    }
    
    back(depth/2 - screwEdgeOffset){
        right(width/2 - screwEdgeOffset){
            union(){
                cylinder(h=height, d=screwDiameter, center=true);
                up(height/2 - screwHeadDepth/2)cylinder(h=screwHeadDepth, d=screwHeadDiameter, center=true);
            }
        }
    }
    
}


