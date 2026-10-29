include <BOSL2/std.scad>
include <BOSL2/transforms.scad>
include <BOSL2/screws.scad>
include <BOSL2/hooks.scad>
use <PlugsAndWashers.scad>

$fn = 100;

LargeStandardFitting(lip_texture=true);
cylinder(r = 10);
up(5){
    cyl(h=10, r1 = 3.5, r2 = 4.5, anchor = BOT, rounding1=-1){
        position(TOP)cyl(h=5, r1=4.5, r2=6, anchor = BOT, rounding2 = 1);
    }
    
}
