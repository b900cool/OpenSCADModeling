include <BOSL2/std.scad>
include <BOSL2/hinges.scad>
include <BOSL2/transforms.scad>

$fn = 100;

layerHeight = 1.2;

olightWidth = 121;
olightHeight = 39;
olightDepth = 61;

olightBox = [olightWidth, olightDepth, olightHeight];

cupr1 = 72/2;
cupr2 = 83/2;
cupr3 = 89/2;
cupr4 = 89/2;

cuph1 = 68;
cuph2 = 4;
cuph3 = 57;

boxBuffer = 30;

boxInsetHeight = 40;


boxSides = olightWidth + 30;
boxBottomHeight = cuph1 + cuph2 + cuph3 - 20;
boxTopHeight = olightHeight + boxInsetHeight;



boxInset = [boxSides-boxBuffer/2, boxSides-boxBuffer/2, boxInsetHeight];
boxInsetOuter = [boxSides, boxSides, boxInsetHeight];

boxBottom = [boxSides, boxSides, boxBottomHeight];
boxTop = [boxSides, boxSides, boxTopHeight];

name = "Jake";
letter_size = 40;
font = "DejaVu Sans:style=Bold";
textExtrudeHeight = 5;

// boxBottom();

// up(300){
    boxTop();
// }

module light(){
    #cuboid(olightBox, anchor=BOTTOM);
}

module cup(){
    cylinder(cuph1, cupr1, cupr2)
        attach(TOP,BOT)
            cylinder(cuph2, cupr2, cupr3)
                attach(TOP,BOT)
                    cylinder(cuph3, cupr3, cupr4);
            
}


module boxBottom(){
    difference(){
        cuboid(boxBottom,anchor=BOTTOM, rounding=10, except=[TOP])
            position(TOP+RIGHT) orient(anchor=RIGHT)
                knuckle_hinge(length=boxSides/2, segs=5, offset=5, knuckle_diam=9, pin_diam="M4",
                    fill=false, inner=false, tap_depth=10, screw_head="socket");

        up(5) cup();
    }
}

module boxTop(){
    difference(){
        diff(){
            cuboid(boxTop, anchor=BOTTOM, rounding=10, except=[BOTTOM])
                position(BOTTOM+RIGHT) orient(spin=-90, anchor=RIGHT)
                    knuckle_hinge(length=boxSides/2, segs=5, offset=5, knuckle_diam=9, pin_diam="M4",
                        fill=false, inner=true, tap_depth=10, screw_head="socket");
        }
        up(boxInsetHeight - olightHeight/3){
            light();
        }
        diff(){
            cuboid(boxInset, anchor=BOTTOM)
                edge_profile(except=[BOTTOM, TOP])
                    mask2d_roundover(r=10, inset=0);
        }
    }

    
}

module boxOuterRing(){
    difference(){
        diff(){
            cube(boxInsetOuter, center=true)
                edge_profile(except=[BOTTOM, TOP])
                    mask2d_roundover(r=10, inset=0);
        }
        diff(){
            cube(boxInset, center=true)
                edge_profile(except=[BOTTOM, TOP])
                    mask2d_roundover(r=10, inset=0);
        }
    }
}

