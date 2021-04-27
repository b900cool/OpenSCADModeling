use<../../Libs/obiscad-master/obiscad/bevel.scad>

offset = .001;

module socket_base(connectionWidth, connectionHeight, resolution){
    
    roundingDepth = .8 * (connectionWidth/2);

    difference(){
        translate([0,0,(connectionHeight/2)]){
            cube([connectionWidth, connectionWidth, connectionHeight], true);
        }
        
        translate([-connectionWidth/2,0,connectionHeight]){
            rotate([90,90,0]){
                bconcave_corner(roundingDepth, resolution, 0, connectionWidth, true, 90);
            }
        }
        translate([0,-connectionWidth/2,connectionHeight]){
            rotate([90,90,90]){
                bconcave_corner(roundingDepth, resolution, 0, connectionWidth, true, 90);
            }
        }
        translate([connectionWidth/2,0,connectionHeight]){
            rotate([90,90,180]){
                bconcave_corner(roundingDepth, resolution, 0, connectionWidth, true, 90);
            }
        }
        translate([0,connectionWidth/2,connectionHeight]){
            rotate([90,90,-90]){
                bconcave_corner(roundingDepth, resolution, 0, connectionWidth, true, 90);
            }
        }
    }
}

socket_base(9,15,100);
