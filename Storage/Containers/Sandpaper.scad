include <BOSL/constants.scad>
include <BOSL/transforms.scad>

sandpaperWidth = 140;
sandpaperLength = 115;

buffer = 5;
boxDepth = 20;

wallThickness = 2;



module sandpaperUnit(sandpaperWidth, sandpaperLength, buffer, boxDepth, wallThickness, gritText){

    textExtrude = 2;
    textBuffer = [3, 3, 3];

    sandpaperSize = [sandpaperWidth+buffer, sandpaperLength+buffer, boxDepth];

    boxSize = sandpaperSize + [wallThickness, wallThickness*2, wallThickness*2];

    difference() {
        cube(size = boxSize, center=true);

        right(wallThickness/2)
            cube(size = sandpaperSize, center=true);

        right(boxSize[0]/2+boxSize[1]/4)
            #cylinder(h=boxSize[2], d=boxSize[1], center=true, $fn=50);

    }

    difference(){
        translate([boxSize[0]/2,boxSize[1]/2,boxSize[2]/2])
            rotate([0,180,0])
                linear_extrude(boxSize[2])
                    polygon([[0,0],[0,boxSize[2]],[boxSize[2]*1.5,0]]);

        translate([boxSize[0]/2-textExtrude, boxSize[1]/2, -boxSize[2]/2 + textBuffer[0]/2])
        rotate([90,0,90])    
            linear_extrude(textExtrude)
                resize([boxSize[2], boxSize[2], textExtrude] - textBuffer)
                text(gritText);

        translate([boxSize[0]/2-boxSize[2]*1.5,boxSize[1]/2+boxSize[2],0])
        rotate([90,0,0])
            linear_extrude(boxSize[2])
                polygon([[0,boxSize[2]/2],[0,-boxSize[2]/2],[boxSize[2]*1.25,0]]);
    }
    
}

sandpaperUnit(sandpaperWidth = sandpaperWidth, sandpaperLength = sandpaperLength, buffer = buffer, boxDepth = boxDepth, wallThickness = wallThickness, gritText = "200");