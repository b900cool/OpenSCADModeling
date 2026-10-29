include <gridfinity-rebuilt/src/core/standard.scad>
use <gridfinity-rebuilt/gridfinity-rebuilt-baseplate.scad>
use <gridfinity-rebuilt/src/core/gridfinity-rebuilt-utility.scad>
use <gridfinity-rebuilt/src/core/gridfinity-rebuilt-holes.scad>
use <gridfinity-rebuilt/src/helpers/generic-helpers.scad>

drawerWidthIn = 11.5;
drawerLengthIn = 20.5;

drawerWidth = drawerWidthIn * 25.4;
drawerLength = drawerLengthIn * 25.4;

/* [Magnet Hole] */
// Baseplate will have holes for 6mm Diameter x 2mm high magnets.
enable_magnet = true;
// Magnet holes will have crush ribs to hold the magnet.
crush_ribs = true;
// Magnet holes will have a chamfer to ease insertion.
chamfer_holes = true;

hole_options = bundle_hole_options(refined_hole=false, magnet_hole=enable_magnet, screw_hole=false, crush_ribs=crush_ribs, chamfer=chamfer_holes, supportless=false);


gridfinityBaseplate([0,0], l_grid, [drawerWidth, drawerLength], 2, hole_options, 0);