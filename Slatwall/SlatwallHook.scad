module SlatwallHook(width=5, hookThickness = 2, hookDepth = 8, hookHeight = 14)
{
    cube([hookDepth,width,hookThickness]);
    translate([hookThickness,0,0])
        rotate([0,270,0])
            cube([hookHeight,width,hookThickness]);
}

SlatwallHook(100);