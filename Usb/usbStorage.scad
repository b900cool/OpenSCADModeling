use<USB.scad>

difference(){
    cube([10,17.5,25]);
    translate([2.5,2.5,5])
        usb_bevel(1.5, 100);
}