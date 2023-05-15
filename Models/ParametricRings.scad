use <HollowCylinder.scad>

module parametricRings(count, rows, diameter, height, ringThickness, overlapRatio, filletSize, holeChamferSize)
// Create Circles
// Translate to start at X = 0, y = depth
translate([diameter/2,diameter/2,0]){
    for (i = [0 : 1 : count - 1])
    {
        for(j = [0 : 1 : rows - 1])
        {   
            // Translate each ring in a row by a diameter - a fraction of the thickness to provide some overlap between rings
            translateX = (i * diameter) - ((ringThickness*overlapRatio) * i);
            
            // Translate each ring in a column by a diameter - a fraction of the thickness to provide some overlap between rings. Add one to j to get the overlap with the back piece
            translateY = (j * diameter) - ((ringThickness*overlapRatio) * j + 1);
            
            translate([translateX, translateY, 0]){
                hollowCylinder(diameter, height, ringThickness, filletSize, holeChamferSize);
            }
        }
    }
}

$fn=40;
diameter = 49;
height = 15;
thickness = 16;

parametricRings(2, 3, diameter, height, thickness, .1, 2, 2);