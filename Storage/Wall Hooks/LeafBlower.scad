include<BOSL/transforms.scad>;
include<BOSL/masks.scad>;

$fn = 50;
filletSize = 3;

backPlateDepth = 15;

screwHoleSize = 4;
screwHeadSize = 9;
screwHeadDepth = 5;

hookOpening = 15;
hookBase = 15;
hookHeight = 80;
hookWidth = 50;


backPlate = [hookWidth, backPlateDepth, hookHeight];
hook = [hookWidth/3, hookOpening*2, hookHeight];
hookDiff = [hookWidth, hookOpening, hookHeight - hookBase];
slope = [[0,0,],[0,hookOpening/2],[hookOpening*1.5,0]];

difference(){

    fillet(size=backPlate, fillet=filletSize, edges = EDGES_ALL - EDGES_FRONT){
        cube(backPlate, center=true);
    }
    
    forward(backPlateDepth/2)down(10)
    rotate([-90,0,0]){
        back(10)
        screw(screwHeadSize, screwHoleSize, screwHeadDepth, 30);
        forward(40)
        screw(screwHeadSize, screwHoleSize, screwHeadDepth, 30);
    }
}

forward(backPlateDepth/2 + hookOpening){
    difference(){
        union(){
            left(hookWidth/3){
                fillet(size=hook, fillet=filletSize, edges = EDGES_ALL - EDGES_BACK){
                        cube(hook, center=true);
                    }
            }
            right(hookWidth/3){
                fillet(size=hook, fillet=filletSize, edges = EDGES_ALL - EDGES_BACK){
                    cube(hook, center=true);
                }
            }
        }
        up(hookBase/2)back(hookOpening/2)
            cube(hookDiff, center=true);
        up(hookHeight/2)
        rotate([90,90,-90])
            #linear_extrude(height=hookWidth, center=true){
                #polygon(slope);
}
    }
    
}



module screw(headDiameter, screwDiameter, headDepth, screwLength){
    union(){
        cylinder(r1=headDiameter/2, r2=screwDiameter/2, h=headDepth);
        cylinder(d=screwDiameter, h=screwLength);
    }
}
