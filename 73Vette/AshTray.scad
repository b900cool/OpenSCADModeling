use <../Models/BevelSquare.scad>
use <../Libs/BOSL-master/masks.scad>
use <../Libs/obiscad-master/obiscad/bcube.scad>
use <../Libs/obiscad-master/obiscad/bevel.scad>

// 58mm long
length = 58;

// 41mm wide -- 44mm wide with tension bars 
width = 41;

// 36mm tall
height = 36;

cornerRadius = 10;

brimDepth = 10;
brimThickness = 3;

tensionerDepth = 4;

// Mount Cylinder Diameter
mCylinderDiameter = 34;
mCylinderHeight = 8;

// Weight Cylinder Diameter
wCylinderDiameter = 23;
wCylinderHeight = 16;

mountExtraHeight = 50;
mountExtraDiameter = 6;

aCylinderDiameter = mCylinderDiameter + mountExtraDiameter;
aCylinderHeight = mCylinderHeight + wCylinderHeight + mountExtraHeight;

//Nub values
nubHeight = 2;
nubLowerD = 8;
nubUpperD = 3;

renderMountCylinder = true;

resolution = 100;

bevelSquare(length, width, height, cornerRadius, 0, resolution);

if(renderMountCylinder){
    translate([length/2,width/2,height + aCylinderHeight/2 + brimThickness]){
        difference(){
            cylinder(aCylinderHeight, d=aCylinderDiameter, center = true, $fn = resolution);
            translate([0,0,mountExtraHeight/2]){
            cylinder(wCylinderHeight, d=wCylinderDiameter, center = true, $fn = resolution);
            }
            translate([0,0,aCylinderHeight/2]){
                cylinder(mCylinderHeight, d=mCylinderDiameter, center = true, $fn = resolution);
            }
        }
          
    }
}

// Tensioner Nub
translate([length/2, 0, height - 5]){
    rotate([0,0,0]){
        fillet(fillet=1, size=[length - cornerRadius*2, 2, 3], $fn=resolution){
            cube(size=[length - cornerRadius*2,2,3], center=true);
        }
        //cylinder(nubHeight, d1=nubLowerD, d2=nubUpperD, center = true, $fn = resolution);
    }
}
translate([0, width/2, height - 5]){
    rotate([0,0,90]){
        fillet(fillet=1, size=[width - cornerRadius*2, 2, 3], $fn=resolution){
            cube(size=[width - cornerRadius*2,2,3], center=true);
        }
        //cylinder(nubHeight, d1=nubLowerD, d2=nubUpperD, center = true, $fn = resolution);
    }
}

// Top Cube Brim
translate([length/2,width/2,height + brimThickness/2]){
    bcube([length + brimDepth, width + brimDepth, brimThickness], cornerRadius, resolution);
}



// Tensioner Cube
tensionerCube=[15,22,tensionerDepth];

ec5 = [[tensionerCube[0]/2, 0, tensionerCube[2]/2], [0,1,0], 0];
en5 = [ ec5[0],                             [1,0,1], 0];


translate([length/2,width,height - 15/2]){
    rotate([90,90,180]){
        difference() {

          //-- Main cube
          cube(tensionerCube,center=true);

          //-- concave_corners for doing the beveling
          bevel(ec5, en5, cr = 8, cres=100, l=tensionerCube[1]+2);

        }
    }
}
translate([length,width/2,height - 15/2]){
    rotate([90,90,90]){
        difference() {

          //-- Main cube
          cube(tensionerCube,center=true);

          //-- concave_corners for doing the beveling
          bevel(ec5, en5, cr = 8, cres=100, l=tensionerCube[1]+2);

        }
    }
}
