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

    up(boxDepth/2 + wallThickness)
    union(){
        difference() {
            cube(size = boxSize, center=true);

            right(wallThickness/2)
                cube(size = sandpaperSize, center=true);

            right(boxSize[0]/2+(boxSize[1]/2)/8)
                #resize([boxSize[1]/1.75, sandpaperSize[1]/1.25, boxSize[2]])
                    cylinder(h=boxSize[2], d=boxSize[1], center=true, $fn=50);

            up(boxDepth/2)
                left(sandpaperSize[0]/2 - 5)
                forward(sandpaperSize[1]/2)
                #boxSlits(boxSize = sandpaperSize, wallThickness = wallThickness);

            up(boxDepth/2)
                left(sandpaperSize[0]/8 - 5)
                forward(sandpaperSize[1]/2)
                #boxSlits(boxSize = sandpaperSize, wallThickness = wallThickness);

            down(boxDepth/2 + wallThickness)
                left(sandpaperSize[0]/2 - 5)
                forward(sandpaperSize[1]/2)
                #boxSlits(boxSize = sandpaperSize, wallThickness = wallThickness);

            down(boxDepth/2 + wallThickness)
                left(sandpaperSize[0]/8 - 5)
                forward(sandpaperSize[1]/2)
                #boxSlits(boxSize = sandpaperSize, wallThickness = wallThickness);

            down(boxDepth/2)
                left(sandpaperSize[0]/2 - 5)
                forward(sandpaperSize[1]/2)
                #boxSlits2(boxSize = sandpaperSize, wallThickness = wallThickness);

            down(boxDepth/2)
                left(sandpaperSize[0]/8 - 5)
                forward(sandpaperSize[1]/2)
                #boxSlits2(boxSize = sandpaperSize, wallThickness = wallThickness);

            down(boxDepth/2)
                left(sandpaperSize[0]/2 - 5)
                back(sandpaperSize[1]/2 + wallThickness)
                #boxSlits2(boxSize = sandpaperSize, wallThickness = wallThickness);

            down(boxDepth/2)
                left(sandpaperSize[0]/8 - 5)
                back(sandpaperSize[1]/2 + wallThickness)
                #boxSlits2(boxSize = sandpaperSize, wallThickness = wallThickness);
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
}

module boxSlits(boxSize, wallThickness){
    location = 0;
    spacing = 5;
    resize([boxSize[0]/3, boxSize[1] - (boxSize[1]/20 + 5), wallThickness])
    for(location = [5:location + boxSize[1]/20 + 5:boxSize[1]]){
        back(location){
            cube([boxSize[0]/1.5, boxSize[1]/20, wallThickness]);
        }
    }
}

module boxSlits2(boxSize, wallThickness){
    location = 0;
    spacing = 4;
    rotate([90,0,0])
    resize([boxSize[0]/3, boxSize[2] - (boxSize[2]/6 + spacing), wallThickness])
    for(location = [spacing:location + boxSize[2]/6 + spacing:boxSize[2]]){
        back(location)
            cube([boxSize[0]/1.5, boxSize[2]/6, wallThickness]);
    }
}

gritList = ["80", "120", "150", "220", "240"];
gritList2 = ["320", "400", "600", "800", "1000"];

for(i = [0:1:len(gritList)-1]){
    up(i * (boxDepth + wallThickness*2))
        sandpaperUnit(sandpaperWidth = sandpaperWidth, sandpaperLength = sandpaperLength, buffer = buffer, boxDepth = boxDepth, wallThickness = wallThickness, gritText = gritList2[i]);
}
