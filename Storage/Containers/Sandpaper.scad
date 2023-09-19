include <BOSL/constants.scad>
include <BOSL/transforms.scad>

sandpaperWidth = 140;
sandpaperLength = 115;

buffer = 5;
boxDepth = 20;

wallThickness = 2;



module sandpaperUnit(sandpaperWidth, sandpaperLength, buffer, boxDepth, wallThickness){

    sandpaperSize = [sandpaperWidth+buffer, sandpaperLength+buffer, boxDepth];

    boxSize = sandpaperSize + [wallThickness, wallThickness*2, wallThickness*2];

    difference() {
        cube(size = boxSize, center=true);

        left(wallThickness/2)
            cube(size = sandpaperSize, center=true);
    }
}

sandpaperUnit(sandpaperWidth = sandpaperWidth, sandpaperLength = sandpaperLength, buffer = buffer, boxDepth = boxDepth, wallThickness = wallThickness);