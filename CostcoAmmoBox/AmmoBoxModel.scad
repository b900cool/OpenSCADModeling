include <BOSL/transforms.scad>

module ammoBoxModel(baseSize=[235, 100], topSize=[245, 110], height = 146, wallThickness = 2){

    widthDiff = topSize[0] - baseSize[0];
    depthDiff = topSize[1] - baseSize[1];

    ceilingSize = concat(topSize, 0.001);
    floorSize = concat(baseSize, 0.001);

    difference(){
        down(wallThickness){
            translate([-wallThickness, -wallThickness, 0]){
                hull() {
                    translate([-widthDiff/2,-depthDiff/2,height + wallThickness]){
                        cube(size=ceilingSize + [wallThickness*2, wallThickness*2, 0]);
                    }
                    cube(size=floorSize  + [wallThickness*2, wallThickness*2, 0]);
                }
            }
        }
        
        hull() {
            translate([-widthDiff/2,-depthDiff/2,height]){
                cube(size=ceilingSize);
            }
            cube(size=floorSize);
        }
        
    }
}

module ammoBoxInterior(baseSize=[235, 100], topSize=[245, 110], height = 146, wallThickness = 2){

    widthDiff = topSize[0] - baseSize[0];
    depthDiff = topSize[1] - baseSize[1];

    ceilingSize = concat(topSize, 0.001);
    floorSize = concat(baseSize, 0.001);

    hull() {
        translate([-widthDiff/2,-depthDiff/2,height]){
            cube(size=ceilingSize);
        }
        cube(size=floorSize);
    }

}