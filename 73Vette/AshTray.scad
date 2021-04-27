use <../Models/BevelCorner.scad>
use <../Libs/obiscad-master/obiscad/bcube.scad>
use <../Libs/obiscad-master/obiscad/bevel.scad>

// 58mm long
length = 58;

// 41mm wide -- 44mm wide with tension bars 
width = 41;

// 36mm tall
squareHeight = 26;
roundedHeight = 10;
height = squareHeight + roundedHeight;

cornerRadius = 10;

brimDepth = 10;
brimThickness = 1;

tensionerDepth = 4;

// Mount Cylinder Diameter
mCylinderDiameter = 34;
mCylinderHeight = 8;

// Weight Cylinder Diameter
wCylinderDiameter = 23;
wCylinderHeight = 16;

mountExtraHeight = 10;
mountExtraDiameter = 6;

aCylinderDiameter = mCylinderDiameter + mountExtraDiameter;
aCylinderHeight = mCylinderHeight + wCylinderHeight + mountExtraHeight;

//Nub values
nubHeight = 2;
nubLowerD = 8;
nubUpperD = 3;

renderBottom = false;
renderMountCylinder = false;


/*
// Corners
translate([cornerRadius,cornerRadius,roundedHeight]){
    rotate([180,90,0]){
        convex_corner(cornerRadius,100);
    }
}

translate([length-cornerRadius,width-cornerRadius,roundedHeight]){
    rotate([0,90,0]){
        convex_corner(cornerRadius,100);
    }
}

translate([length-cornerRadius,cornerRadius,roundedHeight]){
    rotate([90,90,0]){
        convex_corner(cornerRadius,100);
    }
}

translate([cornerRadius,width-cornerRadius,roundedHeight]){
    rotate([270,90,0]){
        convex_corner(cornerRadius,100);
    }
}
*/


translate([length/2,width/2,squareHeight/2 + roundedHeight]){
    bcube([length,width,squareHeight], cornerRadius, 100);
}

if(renderBottom){
    // Bottom Center fill
    bottomCubeSize=[length,width,roundedHeight];

    ec1 = [[bottomCubeSize[0]/2, 0, bottomCubeSize[2]/2], [0,1,0], 0];
    en1 = [ ec1[0],                             [1,0,1], 0];

    //-- Top-left beveling (straight)
    ec2 = [ [-bottomCubeSize[0]/2, 0, bottomCubeSize[2]/2], [0,1,0], 0];
    en2 = [ ec2[0],                    [-1,0,1], 0];

    //-- Top-front beveling (straight)
    ec3 = [ [0, -bottomCubeSize[1]/2, bottomCubeSize[2]/2], [1,0,0], 0];
    en3 = [ ec3[0],                    [0,-1,1], 0];

    //-- Top-back beveling (rounded-low-res)
    ec4 = [ [0, bottomCubeSize[1]/2, bottomCubeSize[2]/2], [1,0,0], 0];
    en4 = [ ec4[0],                    [0,1,1], 0];




    translate([length/2,width/2,roundedHeight/2]){
        rotate([180,0,0]){
            difference(){
                
                bcube(bottomCubeSize, cornerRadius, 100);
                
                bevel(ec1, en1, cr=cornerRadius, cres=100, l=bottomCubeSize[1]+2);
                bevel(ec2, en2, cr=cornerRadius, cres=100, l=bottomCubeSize[1]+2);
                bevel(ec3, en3, cr=cornerRadius, cres=100, l=bottomCubeSize[0]+2);
                bevel(ec4, en4, cr=cornerRadius, cres=100, l=bottomCubeSize[0]+2);

                
            }
        }
    }
}
if(renderMountCylinder){
    translate([length/2,width/2,height + aCylinderHeight/2]){
        difference(){
            cylinder(aCylinderHeight, d=aCylinderDiameter, center = true, $fn = 100);
            translate([0,0,mountExtraHeight/2]){
            cylinder(wCylinderHeight, d=wCylinderDiameter, center = true, $fn = 100);
            }
            translate([0,0,aCylinderHeight/2]){
                cylinder(mCylinderHeight, d=mCylinderDiameter, center = true, $fn = 100);
            }
        }
          
    }
}

translate([length/2, 0, height - 5]){
    rotate([90,0,0]){
        cylinder(nubHeight, d1=nubLowerD, d2=nubUpperD, center = true, $fn = 100);
    }
}

translate([length/2,width/2,height]){
    bcube([length + brimDepth, width + brimDepth, brimThickness], cornerRadius, 100);
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

