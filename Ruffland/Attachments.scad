include <BOSL2/std.scad>
include <BOSL2/transforms.scad>
include <BOSL2/screws.scad>
use <PlugsAndWashers.scad>

$fn = 100;

LargeStandardFitting();
cylinder(r = 10);
up(6){
    rotate([0,90,0]){
        tube(ir=4,or=6, h=5, rounding=2);
    }
}
