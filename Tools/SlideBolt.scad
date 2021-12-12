use<nutsnbolts\files\Threading.scad>
include<BOSL\transforms.scad>

headDiameter = 30;
headHeight = 10;

boltDiameter = 20;
boltPitch = 3;
boltWindings = 4;
boltAngle = 75;
boltFill = true;

union(){
    up(10)threading(pitch = boltPitch, d=boltDiameter, windings=boltWindings, full=boltFill); 
    cylinder(d=headDiameter, h=headHeight, $fn=6);
} 