use <obiscad/obiscad/bevel.scad>

module trayRoudedBase(trayWidth, trayDepth, trayHeight, slopeSize, resolution, printCenter){
    difference(){
        cube([trayWidth,trayDepth,trayHeight], false);
        translate([trayWidth/2,-slopeSize/16,0]){
            rotate([90,0,90]){
                bconcave_corner(slopeSize, resolution, 0, trayWidth, false, 90);
            }
        }
        translate([trayWidth/2,trayDepth+slopeSize/16,0]){
            rotate([90,0,-90]){
                bconcave_corner(slopeSize, resolution, 0, trayWidth, false, 90);
            }
        }
        if(!printCenter){
            translate([2.5, 2.5, 0]){
                cube([trayWidth-5, trayDepth-5, trayHeight]);
            }
        }
    }
}



module foot(footWidth, footDepth, footHeight){
    translate([footDepth,0,0]){
        rotate([0,0,90]){
            cube([footWidth, footDepth, footHeight], false);
        }
    }
}

trayRoudedBase(90, 150, 14, 20, 100, true);