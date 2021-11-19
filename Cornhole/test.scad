include <BOSL/masks.scad>

resolution = 50;





screwHeadDiameter = 5;
screwHeadHeight = 5;
screwThreadDiameter = 2.8;
screwThreadHeight = 20;

batteryWidth = 145;
batteryDepth = 86;
batteryHeight = 28;

screwBaseWidth = 10;
screwBaseDepth = 10;
screwBaseHeight = 6;

screwBase = [screwBaseWidth, screwBaseDepth, screwBaseHeight];

portWallHeight = 4;
portWallDifference = batteryHeight - portWallHeight;

battery = [batteryWidth, batteryDepth, batteryHeight];

batteryWallThickness = 6;

batteryWallCube = battery + ([batteryWallThickness,batteryWallThickness,batteryWallThickness] * 2);

topCutCube = (batteryWallCube - [0,0,batteryHeight + batteryWallThickness]);

portCutCube = [batteryWallThickness, batteryDepth, portWallDifference];


difference(){
    fillet(fillet = 2, size=screwBase, $fn=resolution, edges=EDGES_ALL - EDGES_BOTTOM - EDGES_BACK){
        cube(screwBase, center=true);
    }
    translate([0,0,-screwThreadHeight]){
        screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter, resolution);
    }
}


module screw(headHeight, headDiameter, threadHeight, threadDiameter, res){
    translate([0,0,threadHeight]){
        cylinder(d=headDiameter, h=headHeight, $fn=res);
    }
    cylinder(d=threadDiameter, h=threadHeight, $fn=res);
}
