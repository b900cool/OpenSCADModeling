include <BOSL/constants.scad>
include <BOSL/transforms.scad>
use <BOSL/masks.scad>

// d: Diameter of the outer cylinder wall
// h: Height of the cylinder
// wallWidth: Width of the wall of the resulting hollow cylinder
// $fn: resolution of the cylinder
// filletSize: Size of the fillet on the top and bottom of the cylinder
// holeFilletSize: size of the fillet on the opening of the top of the cylinder
// filletOverage: Overage added to the hole fillet. Only required if the default overage (.2) is not enough to remove artifacting over the fillet
module hollowCylinder(d=5, h=10, wallWidth=2, filletSize=1, holeFilletSize=3, filletOverage=.2)
{
	difference()
	{
        up(h/2){
            difference(){
                cylinder(d=d, h=h, center=true);
                translate([0,0,0])
                    cylinder_mask(l=h, d=d, fillet2=filletSize, fillet1=filletSize, from_end=true);
        }
        }
        translate([0, 0, -0.1]) { 
            innerCylinderDiameter = d-wallWidth/2;
            cylinder(d=innerCylinderDiameter, h=h+0.2); 
            up(h)fillet_hole_mask(d=innerCylinderDiameter, fillet=holeFilletSize, overage=filletOverage); 
        }   
	}
    
}

//hollowCylinder(49, 15, 16, 128, 2, 3);