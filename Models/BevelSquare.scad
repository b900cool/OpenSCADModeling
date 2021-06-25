include <BOSL/constants.scad>
use <BOSL/masks.scad>
use <BevelCorner.scad>

//Creates a beveled Rectangle with or without fillet to be used as a difference for creating trays
// width: The width of the rectangle
// depth: The depth of the rectangle
// cubeFillet: The fillet size of the cube. Set to 0 for no fillet
// topFillet: The fillet size for the opening of the cube. Set to 0 for no fillet
// resolution: the resolution of all rounded surfaces
module bevelSquare(width, depth, height, cubeFillet, topFillet, resolution){
    
    cubeSize = [width, depth, height];
    
    translate(cubeSize/2){
        fillet(fillet=cubeFillet, size=cubeSize, $fn=resolution, edges=EDGES_ALL - EDGES_TOP){
            cube(size=cubeSize, center=true);
        }
    }
    translate([0,0,height]){
        translate([cubeFillet+.05,0,0]){
            difference(){
                fillet_mask_x(l=width-cubeFillet*2-.1, r=topFillet, align=V_RIGHT, $fn=resolution);
                translate([-.1,-topFillet,0]){
                    cube([width+.2,topFillet*2,topFillet]);
                }
            }
        }
        translate([width-cubeFillet-.05,depth,0]){
            difference(){
                fillet_mask_x(l=width-cubeFillet*2-.1, r=topFillet, align=V_LEFT, $fn=resolution);
                translate([-width-.1,-topFillet,0]){
                    cube([width+.2,topFillet*2,topFillet]);
                }
            }
        }
        translate([0,cubeFillet+.05,0]){
            difference(){
                fillet_mask_y(l=depth-cubeFillet*2-.1, r=topFillet, align=V_BACK, $fn=resolution);
                rotate([0,0,90]){
                    translate([-.1,-topFillet,0]){
                        cube([depth+.2,topFillet*2,topFillet]);
                    }
                }
            }
        }
        translate([width,depth-cubeFillet-.05,0]){
            difference(){
                fillet_mask_y(l=depth-cubeFillet*2-.1, r=topFillet, align=V_FWD, $fn=resolution);
                rotate([0,0,90]){
                    translate([-depth-.1,-topFillet,0]){
                        cube([depth+.2,topFillet*2,topFillet]);
                    }
                }
            }
        }
        translate([cubeFillet,cubeFillet,0]){
            rotate([180,0,-90])
                concave_corner2(topFillet, resolution, cubeFillet, true);
        }
        translate([width-cubeFillet,cubeFillet,0])
            rotate([0,180,180])
                concave_corner2(topFillet, resolution, cubeFillet, true);
        translate([cubeFillet,depth-cubeFillet,0])
            rotate([0,180,0])
                concave_corner2(topFillet, resolution, cubeFillet, true);
        translate([width-cubeFillet,depth-cubeFillet,0])
            rotate([180,0,90])
                concave_corner2(topFillet, resolution, cubeFillet, true);
        
    }
}

//bevelSquare(50,100,50,10,0,100);