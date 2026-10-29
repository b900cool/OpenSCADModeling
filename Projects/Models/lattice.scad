include <BOSL/transforms.scad>

module lattice(width=100, depth=100, height=20, latticeThickness=3, widthCompartments=3, depthCompartments=3){

    trueWidth = width - (widthCompartments-1 * latticeThickness);
    trueDepth = depth - (depthCompartments-1 * latticeThickness);

    latticeWidthSize = [latticeThickness, depth, height];
    latticeDepthSize = [width, latticeThickness, height];

    for (i = [1:widthCompartments-1]){
        right(trueWidth/widthCompartments * i){
            cube(latticeWidthSize);
        }
    }
    for (i = [1:depthCompartments-1]){
        back(trueDepth/depthCompartments * i){
            cube(latticeDepthSize);
        }
    }
}

lattice();