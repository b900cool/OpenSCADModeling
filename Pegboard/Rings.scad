//Global Variables
Count = 2;
Rows = 2;

//Cylinder Variables
diameter = 49;
height = 10;
thickness = 4;
resolution = 100;

//Cylider Base Variables
BaseHeight = 0;

//Backplate Variables
depth = 5;
BackHeight = 20;

//Pegboard Variables
HookDiameter = 4;
HoleDiameter = 6.3;
HoleSpacing = 19.2;
HookSpacing = HoleDiameter + HoleSpacing;
TotalBasketWidth = (diameter * Count) - (thickness * (Count - 1)) - HookDiameter;
Excess = TotalBasketWidth % HookSpacing;

//Hook Variables
H1x = (0 - diameter/2) + Excess/2 + HookDiameter/2;
H1y = (0 - diameter/2) - depth + thickness/2;
H1z = (BackHeight + BaseHeight) - 4;

H2x = TotalBasketWidth - Excess/2 - diameter/2 + HookDiameter/2;
H2y = (0 - diameter/2) - depth + thickness/2;
H2z = (BackHeight + BaseHeight) - HookDiameter;

//Checks
echo(HookSpacing);
echo(TotalBasketWidth);
echo(Excess);
echo(H1x);
echo(H2x);


for (i = [0 : 1 : Count - 1])
{
    for(j = [0 : 1 : Rows - 1])
    {   
        translate([(i * diameter) - ((thickness/2) * i), (j * diameter) - ((thickness/2) * j), BaseHeight])
            hollowCylinder(diameter, height, thickness, resolution);
        translate([(i * diameter) - ((thickness/2) * i), (j * diameter) - ((thickness/2) * j), 0])
            cylinder(BaseHeight, diameter/2, diameter/2, $fn=resolution);
    }
    translate([(0 - (diameter/2) + (i * diameter) - (i * (thickness))), (0 - (diameter/2) - depth + thickness/2), 0])
        cube([diameter, depth, BackHeight + BaseHeight], false); 
}



translate([H1x, H1y, H1z])
    PegboardHook();
translate([H2x, H2y, H2z])
    PegboardHook();



module hollowCylinder(d=5, h=10, wallWidth=1, $fn=128)
{
	difference()
	{
		cylinder(d=d, h=h);
		translate([0, 0, -0.1]) { cylinder(d=d-(wallWidth*2), h=h+0.2); }
	}
}

module PegboardHook($fn=128)
{
    translate([0,-7,0])
    {
        rotate([180,180,0])
        {
            rotate([90,0,0])
                cylinder(7, 2, 2);
            hull(){
            sphere(2);
            translate([0,0,10])
                sphere(2);
            }
        }
    }
}
