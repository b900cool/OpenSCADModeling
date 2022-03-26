use<BOSL/masks.scad>
use<BOSL/transforms.scad>
include<BOSL/constants.scad>

$fn=30;

fillet = 1.5;

reflectorWidth = 53.5;
reflectorDepth = 53.5;
reflectorHeight = 8;

fullDepth = 63;

screwDepth = fullDepth - reflectorDepth;
screwHeight = 2.5;

screwSeperatorWidth = 10;
screwSeperatorHeight = 5.5 - screwHeight;

screwDiameter = 4;
screwSlotLength = 14;

screwSeperator = [screwSeperatorWidth, screwDepth, screwSeperatorHeight];
screwArea = [reflectorWidth, screwDepth, screwHeight];
reflector = [reflectorWidth, reflectorDepth, reflectorHeight];

shadeThickness = 2;

//shadeBase = [sensorWidth + shadeThickness, sensorDepth, sensorHeight + shadeThickness*2];
//shade = [sensorWidth + shadeThickness, sensorDepth/2, sensorHeight + shadeThickness*2];

reflectorDifference = [reflectorWidth + shadeThickness*2, fullDepth + shadeThickness*2, reflectorHeight - 2];

shadeWidth = reflectorWidth + shadeThickness*2;
shadeDepth = fullDepth + shadeThickness*2;
shadeHeight = reflectorHeight * 7;

shade = [shadeWidth, shadeDepth, shadeHeight];
shadeDifference = shade - [shadeThickness*2, shadeThickness, 0];

difference(){

    back(screwDepth/2)fillet(fillet = 1, size = reflectorDifference, edges = EDGES_ALL - EDGES_TOP)cube(reflectorDifference, center=true);
    
    left(screwSeperatorWidth/4 + reflectorWidth/4)back(reflectorDepth/2 + screwDepth/2){
            screwSlot(screwSlotLength, screwDiameter, reflectorHeight);
        }
        right(screwSeperatorWidth/4 + reflectorWidth/4)back(reflectorDepth/2 + screwDepth/2){
            screwSlot(screwSlotLength, screwDiameter, reflectorHeight);
        }

    // Reflector Model
    difference(){
        union(){
            cube(reflector, center = true);
            back(reflectorDepth/2 + screwDepth/2)down(reflectorHeight/2 - screwHeight/2)cube(screwArea, center = true);
            back(reflectorDepth/2 + screwDepth/2)cube(screwSeperator, center = true);
        }
        
        left(screwSeperatorWidth/4 + reflectorWidth/4)back(reflectorDepth/2 + screwDepth/2)down(reflectorHeight/2 - screwHeight/2){
            screwSlot(screwSlotLength, screwDiameter, screwHeight);
        }
        right(screwSeperatorWidth/4 + reflectorWidth/4)back(reflectorDepth/2 + screwDepth/2)down(reflectorHeight/2 - screwHeight/2){
            screwSlot(screwSlotLength, screwDiameter, screwHeight);
        }
    }
}
difference(){
    back(screwDepth/2)up(shadeHeight/2 + reflectorHeight/4)fillet(fillet = 1, size = shade)cube(shade, center = true);
    #back(screwDepth/2 - shadeThickness/2)up(shadeHeight/2 + reflectorHeight/4)cube(shadeDifference, center = true);
    
    up(31)rotate([40,0,0])back(screwDepth/2)up(shadeHeight/2 + reflectorHeight/4)cube(shade + [10,20,0], center = true);
}





module screwSlot(slotLength, slotDiameter, slotHeight){
    hull(){
            left(slotLength/2 - slotDiameter/2)cylinder(h = slotHeight, d = slotDiameter, center=true);
            right(slotLength/2 - slotDiameter/2)cylinder(h = slotHeight, d = slotDiameter, center=true);
        }
}


