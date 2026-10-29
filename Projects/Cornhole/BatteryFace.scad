include <BOSL/masks.scad>

resolution = 50;

switchWidth = 19.1;
switchDepth = 25;
switchHeight = 12.7;

switch = [switchWidth, switchDepth, switchHeight];

levelWidth = 53;
levelDepth = 15;
levelHeight = 19;

level = [levelWidth, levelDepth, levelHeight];

plugDiameter = 12.3;
plugDepth = 25;

plugSpacing = 10;

totalPlugFaceWidth = switchWidth + levelWidth + plugDiameter + (plugSpacing * 4);

plugFaceDepth = 20;
plugFaceHeight = 28;

overhangSize = 10;
overhangDepth = 5;
chamferSize = overhangDepth/2;

plugFace = [totalPlugFaceWidth, plugFaceDepth, plugFaceHeight];
plugFaceOverhang = plugFace + [overhangSize, overhangDepth - plugFaceDepth, overhangSize];


// PLUG FACE

rotate([0,0,90]){
    difference(){
        union(){
            translate([0,plugFaceDepth/2 - overhangDepth/2,0]){
                fillet(fillet=chamferSize, size=plugFaceOverhang, $fn=resolution, edges=EDGES_BACK + EDGES_TOP + EDGES_BOTTOM - EDGES_FRONT){
                    cube(plugFaceOverhang, center=true);
                }
            }
            fillet(fillet=plugFaceHeight/2, size=plugFace, $fn=resolution, edges=EDGES_RIGHT + EDGES_LEFT - EDGES_BACK - EDGES_FRONT){
                cube(plugFace, center=true);
            }
        }
        translate([totalPlugFaceWidth/2 - levelWidth - switchWidth/2 - plugSpacing*2,-(switchDepth/2 - plugFaceDepth/2),0]){
            cube(switch, center=true);
        }
        
        translate([-totalPlugFaceWidth/2 + plugDiameter/2 + plugSpacing,-(plugDepth/2 - plugFaceDepth/2),0]){
            rotate([90,0,0]){
                cylinder(d=plugDiameter, h=plugDepth, center=true, $fn=resolution);
            }
        }
        
        translate([totalPlugFaceWidth/2 - levelWidth/2 - plugSpacing,-(levelDepth/2 - plugFaceDepth/2),0]){
            cube(level, center=true);
        }
    }
}
