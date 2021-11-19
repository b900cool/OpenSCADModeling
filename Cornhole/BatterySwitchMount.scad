include <BOSL/masks.scad>

caseTop = false;

resolution = 50;





screwHeadDiameter = 5.6;
screwHeadHeight = 5;
screwThreadDiameter = 2.7;
screwThreadHeight = 20;

batteryWidth = 146;
batteryDepth = 87;
batteryHeight = 28.5;

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

if(!caseTop){
    // BATTERY CASE
    difference(){
        
        
        fillet(fillet = 2, size=batteryWallCube, $fn=resolution, edges=EDGES_ALL - EDGES_BOTTOM - EDGES_TOP){
            cube(batteryWallCube, center=true);
        }
        cube(battery, center=true);
        
        translate([0,0,batteryHeight/2 + batteryWallThickness/2]){
            cube(topCutCube, center=true);
        }
        
        translate([-(batteryWidth/2 + batteryWallThickness/2),0,portWallHeight/2]){
            cube(portCutCube, center=true);
        }
        
        translate([batteryWidth/2 + batteryWallThickness/2, batteryDepth/2 + batteryWallThickness/2, batteryHeight/2 - screwThreadHeight]){
            screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter, resolution);
        }
        
        translate([-(batteryWidth/2 + batteryWallThickness/2), batteryDepth/2 + batteryWallThickness/2, batteryHeight/2 - screwThreadHeight]){
            screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter, resolution);
        }
        
        translate([batteryWidth/2 + batteryWallThickness/2, -(batteryDepth/2 + batteryWallThickness/2), batteryHeight/2 - screwThreadHeight]){
            screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter, resolution);
        }
        
        translate([-(batteryWidth/2 + batteryWallThickness/2), -(batteryDepth/2 + batteryWallThickness/2), batteryHeight/2 - screwThreadHeight]){
            screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter, resolution);
        }
        
    }

    translate([batteryWidth/2 - 10, batteryDepth/2 + screwBaseDepth, -batteryHeight/2] + ([batteryWallThickness,batteryWallThickness,0] - screwBase/2)){
        difference(){
            fillet(fillet = 2, size=screwBase, $fn=resolution, edges=EDGES_ALL - EDGES_BOTTOM - EDGES_FRONT){
                cube(screwBase, center=true);
            }
            translate([0,0,-screwThreadHeight]){
                screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter * 1.2, resolution);
            }
        }
    }


    translate([-batteryWidth/2 + 10, batteryDepth/2 + screwBaseDepth, -batteryHeight/2] + ([batteryWallThickness,batteryWallThickness,0] - screwBase/2)){
        difference(){
            fillet(fillet = 2, size=screwBase, $fn=resolution, edges=EDGES_ALL - EDGES_BOTTOM - EDGES_FRONT){
                cube(screwBase, center=true);
            }
            translate([0,0,-screwThreadHeight]){
                screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter * 1.2, resolution);
            }
        }
    }

    translate([batteryWidth/2 - 10, -batteryDepth/2 - screwBaseDepth, -batteryHeight/2] - ([batteryWallThickness,batteryWallThickness,batteryWallThickness] - screwBase/2)){
        difference(){
            fillet(fillet = 2, size=screwBase, $fn=resolution, edges=EDGES_ALL - EDGES_BOTTOM - EDGES_BACK){
                cube(screwBase, center=true);
            }
            translate([0,0,-screwThreadHeight]){
                screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter * 1.2, resolution);
            }
        }
    }

    translate([-batteryWidth/2 + 10, -batteryDepth/2 - screwBaseDepth, -batteryHeight/2] - ([batteryWallThickness,batteryWallThickness,batteryWallThickness] - screwBase/2)){
        difference(){
            fillet(fillet = 2, size=screwBase, $fn=resolution, edges=EDGES_ALL - EDGES_BOTTOM - EDGES_BACK){
                cube(screwBase, center=true);
            }
            translate([0,0,-screwThreadHeight]){
                screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter * 1.2, resolution);
            }
        }
    }
}


if(caseTop){
    //CASE TOP
    translate([0, batteryWidth, 0]){
        difference(){
            fillet(fillet = 2, size=topCutCube, $fn=resolution, edges=EDGES_ALL - EDGES_BOTTOM){
                cube(topCutCube, center=true);
            }
        
                
            
            
            translate([batteryWidth/2 + batteryWallThickness/2, batteryDepth/2 + batteryWallThickness/2, -screwThreadHeight - screwHeadHeight/4]){
                screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter * 1.2, resolution);
            }
            
            translate([-(batteryWidth/2 + batteryWallThickness/2), batteryDepth/2 + batteryWallThickness/2, -screwThreadHeight - screwHeadHeight/4]){
                screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter * 1.2, resolution);
            }
            
            translate([batteryWidth/2 + batteryWallThickness/2, -(batteryDepth/2 + batteryWallThickness/2), -screwThreadHeight - screwHeadHeight/4]){
                screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter * 1.2, resolution);
            }
            
            translate([-(batteryWidth/2 + batteryWallThickness/2), -(batteryDepth/2 + batteryWallThickness/2), -screwThreadHeight - screwHeadHeight/4]){
                screw(screwHeadHeight, screwHeadDiameter, screwThreadHeight, screwThreadDiameter * 1.2, resolution);
            }
        }
        
    }
}




module screw(headHeight, headDiameter, threadHeight, threadDiameter, res){
    translate([0,0,threadHeight]){
        cylinder(d=headDiameter, h=headHeight, $fn=res);
    }
    cylinder(d=threadDiameter, h=threadHeight, $fn=res);
}
