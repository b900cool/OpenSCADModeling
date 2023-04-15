use <obiscad/obiscad/bevel.scad>
use <../Models/BevelCorner.scad>

module usb_bevel(bevelDepth, bevelResolution){
    //Measurements are based on persepctive of looking at the end of the 
    //drive that would be inserted into a device
    usbHeight = 4.6; //Spec is 4.5 +- .05
    usbWidth = 12.1; //Spec is 12.1 +- .05
    usbDepth = 20; //Spec is 19 +- .05 however the depth is less important 
    offset = .01;   //to us here. Its more important that we are deep enough 
                   //for USBs to either rest by their housing in most cases 
                   //or by the end ofthe connector in the case housing-less 
                   //drives
    resolution = 100;
    cornerSize = 1.5;

    cube([usbHeight, usbWidth, usbDepth], false);

    // Concave corners to create a bevel for the usb drive
    translate([usbHeight-offset,usbWidth/2,usbDepth])
        rotate([90,90,0])
            bconcave_corner(cornerSize,resolution,0,usbWidth,true,90);
            
    translate([0+offset,usbWidth/2,usbDepth])
        rotate([-90,90,0])
            bconcave_corner(cornerSize,resolution,0,usbWidth,true,90);
            
    translate([usbHeight/2,usbWidth-offset,usbDepth])
        rotate([0,90,0])
            bconcave_corner(cornerSize,resolution,0,usbHeight,true,90);
            
    translate([usbHeight/2,0+offset,usbDepth])
        rotate([180,90,0])
            bconcave_corner(cornerSize,resolution,0,usbHeight,true,90);

    translate([usbHeight-offset,0+offset,usbDepth])
        rotate([180,0,0])
            concave_corner(cornerSize,resolution);
            
    translate([0+offset,usbWidth-offset,usbDepth])
        rotate([0,-180,0])
            concave_corner(cornerSize,resolution);
            
    translate([usbHeight-offset,usbWidth-offset,usbDepth])
        rotate([0,180,270])
            concave_corner(cornerSize,resolution);
            
    translate([0+offset,0+offset,usbDepth])
        rotate([0,180,90])
            concave_corner(cornerSize,resolution);
}

usb_bevel(1.5, 100);