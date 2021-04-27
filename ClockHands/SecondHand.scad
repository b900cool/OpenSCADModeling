innerDiameter = 2;
outerDiameter = 2;
width = 2.8;
resolution = 100;
length = 228;

difference(){
    
    hull(){
        linear_extrude(height = width, center = true, convexity = 10, twist = 0, $fn = resolution){
            circle(outerDiameter, $fn = resolution);
        }
        

        linear_extrude(height = width, center = true, convexity = 10, twist = 0, $fn = resolution){
            translate([length,0,0])
                circle(outerDiameter, $fn = resolution);
        }
    }
    

}
    
    
