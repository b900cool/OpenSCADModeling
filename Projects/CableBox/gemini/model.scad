// AI Agent: openscad-designer
// Project: CableBox
// Date: 2026-10-28
// User Verification Checklist
// - Geometry reviewed manually: [ ]
// - Render checked in OpenSCAD: [ ]
// - Printed successfully: [ ]
// - Notes: Dimensions are internal clear dimensions in millimeters.

$fn = $preview ? 32 : 64;

inch = 25.4;

/* [Box Dimensions] */
inside_x = 7 * inch;
inside_y = 7 * inch;
inside_height = 5 * inch;
wall_thickness = 2.4;
floor_thickness = 3;

/* [Lid and Snap Fit] */
lid_wall_thickness = 2.4;
lid_roof_thickness = 3;
lid_skirt_height = 12;
lid_fit_clearance = 0.4;
snap_tab_width = 18;
snap_tab_top_bridge = 2;
snap_tab_flex_thickness = 1.2;
snap_tooth_width = 14;
snap_tooth_height = 2.5;
snap_tooth_projection = 1;
snap_groove_width = 19;
snap_groove_height = 3.2;
snap_groove_depth = 0.8;
snap_position_offset = inside_x * 0.25;
pull_tab_width = 30;
pull_tab_projection = 12;
pull_tab_thickness = 1.8;

/* [Centered Block Retainer] */
block_size = 4 * inch;
block_clearance_per_side = 0.4;
retainer_wall_thickness = 3;
retainer_height = 6;

/* [Edge Bevels] */
edge_bevel = 0.8;

/* [Cable Openings] */
cable_notch_width = 0.5 * inch;
cable_notch_depth = 40;
cable_notch_bevel = edge_bevel;
large_slot_width = 1 * inch;
large_slot_depth = inside_height * 0.78;
large_slot_offset = 1 * inch;
large_slot_bevel = edge_bevel;

/* [Render Mode & Part Selector] */
part = "all"; // ["all": Assembled View, "body": Box Only, "lid": Lid in Assembly Orientation, "lid_print": Lid for Printing, "print_bed": Parts Flat on Z=0, "exploded": Exploded View]

/* [Hidden Dimensions] */
body_outer_x = inside_x + 2 * wall_thickness;
body_outer_y = inside_y + 2 * wall_thickness;
body_top = floor_thickness + inside_height;
retainer_inner = block_size + 2 * block_clearance_per_side;
retainer_outer = retainer_inner + 2 * retainer_wall_thickness;
retainer_offset_x = (inside_x - retainer_outer) / 4;
retainer_offset_y = -(inside_y - retainer_outer) / 4;
large_slot_center_x = retainer_offset_x - large_slot_offset;
small_notch_offset = inside_x * 0.4;
lid_inner_x = body_outer_x + 2 * lid_fit_clearance;
lid_inner_y = body_outer_y + 2 * lid_fit_clearance;
lid_outer_x = lid_inner_x + 2 * lid_wall_thickness;
lid_outer_y = lid_inner_y + 2 * lid_wall_thickness;
print_gap = 15;

module beveled_cuboid(size, bevel) {
    minkowski() {
        cube(size - [2 * bevel, 2 * bevel, 2 * bevel], center = true);
        polyhedron(
            points = [
                [bevel, 0, 0],
                [-bevel, 0, 0],
                [0, bevel, 0],
                [0, -bevel, 0],
                [0, 0, bevel],
                [0, 0, -bevel]
            ],
            faces = [
                [0, 2, 4], [2, 1, 4], [1, 3, 4], [3, 0, 4],
                [2, 0, 5], [1, 2, 5], [3, 1, 5], [0, 3, 5]
            ],
            convexity = 2
        );
    }
}

module open_slot_y(x_center, y_center, cut_depth, width, bottom_z) {
    hull() {
        translate([x_center, y_center, bottom_z + width / 2])
            rotate([90, 0, 0])
                cylinder(d = width, h = cut_depth, center = true);
        translate([x_center, y_center, body_top + width / 2])
            rotate([90, 0, 0])
                cylinder(d = width, h = cut_depth, center = true);
    }
}

module open_slot_x(x_center, y_center, cut_depth, width, bottom_z) {
    hull() {
        translate([x_center, y_center, bottom_z + width / 2])
            rotate([0, 90, 0])
                cylinder(d = width, h = cut_depth, center = true);
        translate([x_center, y_center, body_top + width / 2])
            rotate([0, 90, 0])
                cylinder(d = width, h = cut_depth, center = true);
    }
}

module bevel_yz_wedge(x_start, x_length, points) {
    translate([x_start, 0, 0])
        rotate([0, 90, 0])
            linear_extrude(height = x_length, convexity = 2)
                polygon(points = [
                    [-points[0][1], points[0][0]],
                    [-points[1][1], points[1][0]],
                    [-points[2][1], points[2][0]]
                ]);
}

module bevel_xz_wedge(y_start, y_length, points) {
    translate([0, y_start, 0])
        rotate([-90, 0, 0])
            linear_extrude(height = y_length, convexity = 2)
                polygon(points = [
                    [points[0][0], points[0][1]],
                    [points[1][0], points[1][1]],
                    [points[2][0], points[2][1]]
                ]);
}

module body_inner_edge_bevel_tools() {
    bevel_yz_wedge(
        -inside_x / 2 - edge_bevel,
        inside_x + 2 * edge_bevel,
        [
            [-inside_y / 2, floor_thickness],
            [-inside_y / 2 + edge_bevel, floor_thickness],
            [-inside_y / 2, floor_thickness + edge_bevel]
        ]
    );
    bevel_yz_wedge(
        -inside_x / 2 - edge_bevel,
        inside_x + 2 * edge_bevel,
        [
            [inside_y / 2, floor_thickness],
            [inside_y / 2 - edge_bevel, floor_thickness],
            [inside_y / 2, floor_thickness + edge_bevel]
        ]
    );
    bevel_yz_wedge(
        -inside_x / 2 - edge_bevel,
        inside_x + 2 * edge_bevel,
        [
            [-inside_y / 2, body_top],
            [-inside_y / 2 + edge_bevel, body_top],
            [-inside_y / 2, body_top - edge_bevel]
        ]
    );
    bevel_yz_wedge(
        -inside_x / 2 - edge_bevel,
        inside_x + 2 * edge_bevel,
        [
            [inside_y / 2, body_top],
            [inside_y / 2 - edge_bevel, body_top],
            [inside_y / 2, body_top - edge_bevel]
        ]
    );

    bevel_xz_wedge(
        -inside_y / 2 - edge_bevel,
        inside_y + 2 * edge_bevel,
        [
            [-inside_x / 2, floor_thickness],
            [-inside_x / 2 + edge_bevel, floor_thickness],
            [-inside_x / 2, floor_thickness + edge_bevel]
        ]
    );
    bevel_xz_wedge(
        -inside_y / 2 - edge_bevel,
        inside_y + 2 * edge_bevel,
        [
            [inside_x / 2, floor_thickness],
            [inside_x / 2 - edge_bevel, floor_thickness],
            [inside_x / 2, floor_thickness + edge_bevel]
        ]
    );
    bevel_xz_wedge(
        -inside_y / 2 - edge_bevel,
        inside_y + 2 * edge_bevel,
        [
            [-inside_x / 2, body_top],
            [-inside_x / 2 + edge_bevel, body_top],
            [-inside_x / 2, body_top - edge_bevel]
        ]
    );
    bevel_xz_wedge(
        -inside_y / 2 - edge_bevel,
        inside_y + 2 * edge_bevel,
        [
            [inside_x / 2, body_top],
            [inside_x / 2 - edge_bevel, body_top],
            [inside_x / 2, body_top - edge_bevel]
        ]
    );

    for (sx = [-1, 1]) {
        for (sy = [-1, 1]) {
            translate([0, 0, floor_thickness])
                linear_extrude(height = inside_height + 0.1, convexity = 2)
                    polygon(points = [
                        [sx * inside_x / 2, sy * inside_y / 2],
                        [sx * (inside_x / 2 - edge_bevel), sy * inside_y / 2],
                        [sx * inside_x / 2, sy * (inside_y / 2 - edge_bevel)]
                    ]);
        }
    }
}

module beveled_opening_y(x_center, side, width, bottom_z, bevel) {
    open_slot_y(
        x_center,
        side * (body_outer_y / 2 - wall_thickness / 2),
        wall_thickness + 2,
        width,
        bottom_z
    );
    open_slot_y(
        x_center,
        side * (body_outer_y / 2 - bevel / 2),
        bevel + 0.1,
        width + 2 * bevel,
        bottom_z
    );
    open_slot_y(
        x_center,
        side * (inside_y / 2 + bevel / 2),
        bevel + 0.1,
        width + 2 * bevel,
        bottom_z
    );
}

module beveled_opening_x(y_center, side, width, bottom_z, bevel) {
    open_slot_x(
        side * (body_outer_x / 2 - wall_thickness / 2),
        y_center,
        wall_thickness + 2,
        width,
        bottom_z
    );
    open_slot_x(
        side * (body_outer_x / 2 - bevel / 2),
        y_center,
        bevel + 0.1,
        width + 2 * bevel,
        bottom_z
    );
    open_slot_x(
        side * (inside_x / 2 + bevel / 2),
        y_center,
        bevel + 0.1,
        width + 2 * bevel,
        bottom_z
    );
}

module cable_opening_tools() {
    beveled_opening_y(
        large_slot_center_x,
        -1,
        large_slot_width,
        body_top - large_slot_depth,
        large_slot_bevel
    );

    for (offset = [-small_notch_offset, small_notch_offset]) {
        beveled_opening_y(
            offset,
            1,
            cable_notch_width,
            body_top - cable_notch_depth,
            cable_notch_bevel
        );
        for (side = [-1, 1]) {
            beveled_opening_x(
                offset,
                side,
                cable_notch_width,
                body_top - cable_notch_depth,
                cable_notch_bevel
            );
        }
    }
}

module snap_groove_tools() {
    for (offset = [-snap_position_offset, snap_position_offset]) {
        translate([
            offset - snap_groove_width / 2,
            -body_outer_y / 2 - 0.1,
            body_top - lid_skirt_height + 1.7
        ])
            cube([snap_groove_width, snap_groove_depth + 0.1, snap_groove_height]);
        translate([
            offset - snap_groove_width / 2,
            body_outer_y / 2 - snap_groove_depth,
            body_top - lid_skirt_height + 1.7
        ])
            cube([snap_groove_width, snap_groove_depth + 0.1, snap_groove_height]);

        translate([
            -body_outer_x / 2 - 0.1,
            offset - snap_groove_width / 2,
            body_top - lid_skirt_height + 1.7
        ])
            cube([snap_groove_depth + 0.1, snap_groove_width, snap_groove_height]);
        translate([
            body_outer_x / 2 - snap_groove_depth,
            offset - snap_groove_width / 2,
            body_top - lid_skirt_height + 1.7
        ])
            cube([snap_groove_depth + 0.1, snap_groove_width, snap_groove_height]);
    }
}

module retainer_inner_edge_bevel_tools() {
    hull() {
        translate([0, 0, 0.1])
            cube([retainer_inner + 2 * edge_bevel, retainer_inner + 2 * edge_bevel, 0.02], center = true);
        translate([0, 0, edge_bevel + 0.1])
            cube([retainer_inner, retainer_inner, 0.02], center = true);
    }
    hull() {
        translate([0, 0, retainer_height - edge_bevel])
            cube([retainer_inner, retainer_inner, 0.02], center = true);
        translate([0, 0, retainer_height + 0.1])
            cube([retainer_inner + 2 * edge_bevel, retainer_inner + 2 * edge_bevel, 0.02], center = true);
    }
    for (sx = [-1, 1]) {
        for (sy = [-1, 1]) {
            translate([0, 0, 0.1])
                linear_extrude(height = retainer_height + 0.1, convexity = 2)
                    polygon(points = [
                        [sx * retainer_inner / 2, sy * retainer_inner / 2],
                        [sx * (retainer_inner / 2 - edge_bevel), sy * retainer_inner / 2],
                        [sx * retainer_inner / 2, sy * (retainer_inner / 2 - edge_bevel)]
                    ]);
        }
    }
}

module block_retainer() {
    translate([retainer_offset_x, retainer_offset_y, floor_thickness - 0.1])
        difference() {
            translate([0, 0, retainer_height / 2])
                beveled_cuboid(
                    [retainer_outer, retainer_outer, retainer_height],
                    edge_bevel
                );
            translate([-retainer_inner / 2, -retainer_inner / 2, 0.1])
                cube([retainer_inner, retainer_inner, retainer_height + 0.1]);
            retainer_inner_edge_bevel_tools();
        }
}

module box_body() {
    union() {
        difference() {
            translate([0, 0, body_top / 2])
                beveled_cuboid(
                    [body_outer_x, body_outer_y, body_top],
                    edge_bevel
                );

            translate([-inside_x / 2, -inside_y / 2, floor_thickness])
                cube([inside_x, inside_y, inside_height + 0.1]);

            body_inner_edge_bevel_tools();
            cable_opening_tools();
            snap_groove_tools();
        }
        block_retainer();
    }
}

module lid_flex_slit_tools() {
    for (offset = [-snap_position_offset, snap_position_offset]) {
        for (edge = [-1, 1]) {
            translate([
                offset + edge * snap_tab_width / 2 - 0.5,
                -lid_outer_y / 2 - 0.1,
                -0.1
            ])
                cube([1, lid_wall_thickness + 2 * lid_fit_clearance + 0.2, lid_skirt_height - snap_tab_top_bridge + 0.1]);
            translate([
                offset + edge * snap_tab_width / 2 - 0.5,
                lid_inner_y / 2 - 0.1,
                -0.1
            ])
                cube([1, lid_wall_thickness + 2 * lid_fit_clearance + 0.2, lid_skirt_height - snap_tab_top_bridge + 0.1]);

            translate([
                -lid_outer_x / 2 - 0.1,
                offset + edge * snap_tab_width / 2 - 0.5,
                -0.1
            ])
                cube([lid_wall_thickness + 2 * lid_fit_clearance + 0.2, 1, lid_skirt_height - snap_tab_top_bridge + 0.1]);
            translate([
                lid_inner_x / 2 - 0.1,
                offset + edge * snap_tab_width / 2 - 0.5,
                -0.1
            ])
                cube([lid_wall_thickness + 2 * lid_fit_clearance + 0.2, 1, lid_skirt_height - snap_tab_top_bridge + 0.1]);
        }
    }
}

module lid_flex_thinning_tools() {
    flex_recess_width = snap_tab_width - 2;
    flex_recess_depth = lid_wall_thickness - snap_tab_flex_thickness + 0.1;
    flex_recess_height = lid_skirt_height - snap_tab_top_bridge - 0.5;

    for (offset = [-snap_position_offset, snap_position_offset]) {
        translate([
            offset - flex_recess_width / 2,
            -lid_outer_y / 2 - 0.1,
            0.5
        ])
            cube([flex_recess_width, flex_recess_depth, flex_recess_height]);
        translate([
            offset - flex_recess_width / 2,
            lid_outer_y / 2 - flex_recess_depth + 0.1,
            0.5
        ])
            cube([flex_recess_width, flex_recess_depth, flex_recess_height]);

        translate([
            -lid_outer_x / 2 - 0.1,
            offset - flex_recess_width / 2,
            0.5
        ])
            cube([flex_recess_depth, flex_recess_width, flex_recess_height]);
        translate([
            lid_outer_x / 2 - flex_recess_depth + 0.1,
            offset - flex_recess_width / 2,
            0.5
        ])
            cube([flex_recess_depth, flex_recess_width, flex_recess_height]);
    }
}

module snap_teeth() {
    for (offset = [-snap_position_offset, snap_position_offset]) {
        // The tooth grows inward toward its upper edge, forming an insertion ramp.
        hull() {
            translate([
                offset - snap_tooth_width / 2,
                -lid_inner_y / 2,
                1.7
            ])
                cube([snap_tooth_width, 0.15, 0.2]);
            translate([
                offset - snap_tooth_width / 2,
                -lid_inner_y / 2 + snap_tooth_projection,
                1.7 + snap_tooth_height - 0.2
            ])
                cube([snap_tooth_width, 0.15, 0.2]);
        }
        hull() {
            translate([
                offset - snap_tooth_width / 2,
                lid_inner_y / 2 - 0.15,
                1.7
            ])
                cube([snap_tooth_width, 0.15, 0.2]);
            translate([
                offset - snap_tooth_width / 2,
                lid_inner_y / 2 - snap_tooth_projection,
                1.7 + snap_tooth_height - 0.2
            ])
                cube([snap_tooth_width, 0.15, 0.2]);
        }

        hull() {
            translate([
                -lid_inner_x / 2,
                offset - snap_tooth_width / 2,
                1.7
            ])
                cube([0.15, snap_tooth_width, 0.2]);
            translate([
                -lid_inner_x / 2 + snap_tooth_projection,
                offset - snap_tooth_width / 2,
                1.7 + snap_tooth_height - 0.2
            ])
                cube([0.15, snap_tooth_width, 0.2]);
        }
        hull() {
            translate([
                lid_inner_x / 2 - 0.15,
                offset - snap_tooth_width / 2,
                1.7
            ])
                cube([0.15, snap_tooth_width, 0.2]);
            translate([
                lid_inner_x / 2 - snap_tooth_projection,
                offset - snap_tooth_width / 2,
                1.7 + snap_tooth_height - 0.2
            ])
                cube([0.15, snap_tooth_width, 0.2]);
        }
    }
}

module lid_inner_edge_bevel_tools() {
    hull() {
        translate([0, 0, 0.01])
            cube([lid_inner_x + 2 * edge_bevel, lid_inner_y + 2 * edge_bevel, 0.02], center = true);
        translate([0, 0, edge_bevel + 0.01])
            cube([lid_inner_x, lid_inner_y, 0.02], center = true);
    }
    hull() {
        translate([0, 0, lid_skirt_height - edge_bevel])
            cube([lid_inner_x, lid_inner_y, 0.02], center = true);
        translate([0, 0, lid_skirt_height + 0.1])
            cube([lid_inner_x + 2 * edge_bevel, lid_inner_y + 2 * edge_bevel, 0.02], center = true);
    }
    for (sx = [-1, 1]) {
        for (sy = [-1, 1]) {
            translate([0, 0, -0.1])
                linear_extrude(height = lid_skirt_height + 0.2, convexity = 2)
                    polygon(points = [
                        [sx * lid_inner_x / 2, sy * lid_inner_y / 2],
                        [sx * (lid_inner_x / 2 - edge_bevel), sy * lid_inner_y / 2],
                        [sx * lid_inner_x / 2, sy * (lid_inner_y / 2 - edge_bevel)]
                    ]);
        }
    }
}

module lid() {
    difference() {
        union() {
            translate([0, 0, (lid_skirt_height + lid_roof_thickness) / 2])
                beveled_cuboid(
                    [lid_outer_x, lid_outer_y, lid_skirt_height + lid_roof_thickness],
                    edge_bevel
                );
            snap_teeth();

            // This flat pull lip prints directly on the bed when the lid is inverted.
            translate([
                0,
                -lid_outer_y / 2 - pull_tab_projection / 2 + 0.6,
                lid_skirt_height + lid_roof_thickness - pull_tab_thickness / 2
            ])
                beveled_cuboid(
                    [pull_tab_width, pull_tab_projection + 1.2, pull_tab_thickness],
                    min(edge_bevel, pull_tab_thickness / 4)
                );
        }

        translate([-lid_inner_x / 2, -lid_inner_y / 2, -0.1])
            cube([lid_inner_x, lid_inner_y, lid_skirt_height + 0.1]);
        lid_inner_edge_bevel_tools();
        lid_flex_slit_tools();
        lid_flex_thinning_tools();
    }
}

module assembled_model() {
    box_body();
    translate([0, 0, body_top - lid_skirt_height])
        lid();
}

module lid_print_orientation() {
    translate([0, 0, lid_skirt_height + lid_roof_thickness])
        rotate([180, 0, 0])
            lid();
}

module print_bed_layout() {
    box_body();
    translate([(body_outer_x + lid_outer_x) / 2 + print_gap, 0, 0])
        lid_print_orientation();
}

if (part == "all") {
    assembled_model();
} else if (part == "body") {
    box_body();
} else if (part == "lid") {
    lid();
} else if (part == "lid_print") {
    lid_print_orientation();
} else if (part == "print_bed") {
    print_bed_layout();
} else if (part == "exploded") {
    box_body();
    translate([0, 0, body_top + 20])
        lid();
}
