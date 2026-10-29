use <HollowCylinder.scad>

module parametricRings(ringCount, ringRows, innerRingDiameter, ringHeight, ringThickness, overlapRatio, filletSize, holeChamferSize){
// Create Circles
// Translate to start at X = 0, y = depth
    for (i = [0 : 1 : ringCount - 1])
    {
        for(j = [0 : 1 : ringRows - 1])
        {   
            // Translate each ring in a row by a diameter - a fraction of the thickness to provide some overlap between rings
            translateX = (i * (innerRingDiameter + ringThickness*2)) - ((ringThickness*overlapRatio) * i) + innerRingDiameter/2 + ringThickness;
            
            // Translate each ring in a column by a diameter - a fraction of the thickness to provide some overlap between rings. Add one to j to get the overlap with the back piece
            translateY = (j * (innerRingDiameter + ringThickness*2)) - ((ringThickness*overlapRatio) * j) + innerRingDiameter/2 + ringThickness;
            
            translate([translateX, translateY, 0]){
                hollowCylinder(innerRingDiameter, ringHeight, ringThickness, filletSize, holeChamferSize);
            }
        }
    }
}

innerRingDiameter = 10;
ringHeight = 15;
thickness = 10;

parametricRings(3, 3, innerRingDiameter, ringHeight, thickness, .1, 2, 2);