module SlatwallHook(width=5)
{
    cube([8,width,2]);
    translate([2,0,0])
        rotate([0,270,0])
            cube([14,width,2]);
}

SlatwallHook(100);