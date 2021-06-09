include <../Libs/BOSL-master/constants.scad>
use <../Libs/BOSL-master/masks.scad>
use <BevelCorner.scad>

module bevelSquare(width, depth, height, fillet, resolution){
    cube(size=[width, depth, height], center=false);
    translate([0,0,height]){
        difference(){
            fillet_mask_x(l=width, r=fillet, align=V_RIGHT, $fn=resolution);
            translate([-.1,-fillet,0]){
                cube([width+.2,fillet*2,fillet]);
            }
        }
        translate([width,depth,0]){
            difference(){
                fillet_mask_x(l=width, r=fillet, align=V_LEFT, $fn=resolution);
                translate([-width-.1,-fillet,0]){
                    cube([width+.2,fillet*2,fillet]);
                }
            }
        }
        difference(){
            fillet_mask_y(l=depth, r=fillet, align=V_BACK, $fn=resolution);
            rotate([0,0,90]){
                translate([-.1,-fillet,0]){
                    cube([depth+.2,fillet*2,fillet]);
                }
            }
        }
        translate([width,depth,0]){
            difference(){
                fillet_mask_y(l=depth, r=fillet, align=V_FWD, $fn=resolution);
                rotate([0,0,90]){
                    translate([-depth-.1,-fillet,0]){
                        cube([depth+.2,fillet*2,fillet]);
                    }
                }
            }
        }
        rotate([180,0,-90])
            concave_corner(fillet, resolution);
        translate([width,0,0])
            rotate([0,180,180])
                concave_corner(fillet, resolution);
        translate([0,depth,0])
            rotate([0,180,0])
                concave_corner(fillet, resolution);
        translate([width,depth,0])
            rotate([180,0,90])
                concave_corner(fillet, resolution);
        
    }
}

bevelSquare(50,100,50,5, 100);