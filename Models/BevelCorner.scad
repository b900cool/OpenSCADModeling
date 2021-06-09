module concave_corner(length, resolution){

    angle = 0;
    angleIncrement = 90 / resolution + 1;
    
    points = [
    [length, 0], [0, 0], [0, length],
    for (i = [180 : angleIncrement : 270]) [length + (length * cos(i)), length + (length * sin(i))]
    ];
    rotate_extrude(angle=90, $fn = resolution)
        polygon(points);
}

module convex_corner(length, resolution){

    angle = 0;
    angleIncrement = 90 / resolution + 1;
    
    points = [
    [length, 0], [0, 0], [0, length],
    for (i = [0 : angleIncrement : 90]) [(length * cos(i)), (length * sin(i))], [0,length]
    ];
    rotate_extrude(angle=90, $fn = resolution)
        polygon(points);
}

module cylinder_bezel(depth, radius, resolution){
    
    angle = 0;
    angleIncrement = 90 / resolution + 1;
    
    points = [
    [depth, 0], [0, 0], [0, depth],
    for (i = [180 : angleIncrement : 270]) [depth + (depth * cos(i)), depth + (depth * sin(i))]
    ];
    polygon(points);
    /*
    rotate_extrude(angle=360, $fn = resolution)
        translate([radius,0,0])
            polygon(points);
    */
}

concave_corner(10, 100);

translate([20,0,0])
    convex_corner(10, 100);

translate([0,20,0])
    cylinder_bezel(2, 10, 100);