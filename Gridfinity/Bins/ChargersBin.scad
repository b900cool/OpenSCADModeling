include <gridfinity-rebuilt/src/core/standard.scad>
use <gridfinity-rebuilt/gridfinity-rebuilt-bins.scad>
use <gridfinity-rebuilt/src/core/gridfinity-rebuilt-utility.scad>
use <gridfinity-rebuilt/src/core/gridfinity-rebuilt-holes.scad>
use <gridfinity-rebuilt/src/helpers/generic-helpers.scad>

/* [Base Hole Options] */
// only cut magnet/screw holes at the corners of the bin to save uneccesary print time
only_corners = true;
//Use gridfinity refined hole style. Not compatible with magnet_holes!
refined_holes = false;
// Base will have holes for 6mm Diameter x 2mm high magnets.
magnet_holes = true;
// Base will have holes for M3 screws.
screw_holes = false;
// Magnet holes will have crush ribs to hold the magnet.
crush_ribs = false;
// Magnet/Screw holes will have a chamfer to ease insertion.
chamfer_holes = true;
// Magnet/Screw holes will be printed so supports are not needed.
printable_hole_top = true;
// Enable "gridfinity-refined" thumbscrew hole in the center of each base: https://www.printables.com/model/413761-gridfinity-refined
enable_thumbscrew = false;

hole_options = bundle_hole_options(refined_holes, magnet_holes, screw_holes, crush_ribs, chamfer_holes, printable_hole_top);

gridfinityInit(2, 6, height(6), 0, 42) {
	cutEqual(n_divx = 1, n_divy = 1, style_tab = 0, scoop_weight = 0);
}
gridfinityBase([2, 6], hole_options=hole_options);