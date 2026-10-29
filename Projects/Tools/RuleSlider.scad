use <BOSL\transforms.scad>
use <BOSL\masks.scad>
use <BOSL\constants.scad>
use <threads-scad/threads.scad>

$fn=100;

fillet = 2;

ruleWidth = 41.5;
ruleDepth = 4;
ruleLength = 1219.2;

rule = [ruleLength, ruleWidth, ruleDepth];

triangleSideLength = ruleWidth*3;
triangleHeight = 5;

sliderThickness = 8; //Divides by 2 on each side of the rule, resulting in 2 on each side of the rule.
sliderWidth = ruleWidth + sliderThickness;
sliderDepth = ruleDepth + sliderThickness;
sliderLength = 30;

slider = [sliderLength, sliderWidth, sliderDepth];

sliderCutoutSize = sliderWidth / 1.5;

sliderCutout = [sliderLength, sliderCutoutSize, sliderThickness/2];

boltLength = triangleHeight + sliderThickness/2 + 1;
boltDiameter = 20;


difference(){
    union(){
        difference(){
            fillet(fillet, slider, edges=EDGES_ALL-EDGES_TOP){
                cube(slider, center=true);
            }
            cube(rule, center=true);
            translate([0,0,-sliderDepth/2 + 1]){
                cube([sliderLength, sliderWidth, sliderThickness/2-2], center = true);
            }


            down(sliderDepth/2 - sliderThickness/4)cube(sliderCutout, center=true);
        }

        difference(){
            rotate([0,0,90]){
                translate([-sliderWidth/2, -sliderLength, sliderDepth/2 - sliderThickness/2]){
                    rightTriangle(triangleSideLength,fillet,triangleHeight);
                }
            }
            translate([-triangleSideLength/2 - sliderLength/2,-sliderThickness/4,sliderDepth/2 + triangleHeight/2 - sliderThickness/2]){
                #cube([triangleSideLength, sliderWidth - sliderThickness/2, triangleHeight], center = true);
            }
        }
    }

    translate([0,0,triangleHeight*2 + sliderThickness -8 ]){
        up(boltDiameter){
            rotate([0,180,0]){
                #MetricBolt(boltDiameter, boltLength);
            }
        }
    }
}

module rightTriangle(sideLength, fillet, triangleHeight){
    
    triangle = [[0,0],[0,sideLength],[sideLength,0],[0,0]];
    
    hypotenuse = sqrt(2*(sideLength*sideLength));
    
    difference(){
        linear_extrude(triangleHeight){
            polygon(points=triangle);
        }
        
        rotate([0,0,45]){
            height = hypotenuse/2;
            
            translate([height,0,triangleHeight]){
                fillet_mask_y(l=hypotenuse, r=fillet);
            }
        }
        
        translate([0,sideLength/2,triangleHeight]){
            fillet_mask_y(l=sideLength, r=fillet);
        }
        
        rotate([0,0,90]){
            height = hypotenuse/2;
            
            translate([0,-sideLength/2,triangleHeight]){
                fillet_mask_y(l=sideLength, r=fillet);
            }
        }
        
        rotate([0,0,0]){
            translate([0,0,triangleHeight]){
                fillet_angled_corner_mask(fillet=fillet, ang=90);
            }
        }
        fillet_mask(l=triangleHeight, r=fillet, orient=ORIENT_Z, align=V_UP);
        
        translate([sideLength,0,triangleHeight/2]){
            rotate([0,0,180]){
                fillet_angled_edge_mask(h=triangleHeight, r=fillet, ang=45, center=true);
                rotate([0,0,-45]){
                    translate([0,0,triangleHeight/2]){
                        fillet_angled_corner_mask(fillet=fillet, ang=45);
                    }
                }
            }
        }
        translate([0,sideLength,triangleHeight/2]){
            rotate([0,0,-90]){
                fillet_angled_edge_mask(h=triangleHeight, r=fillet, ang=45, center=true);
                rotate([0,0,0]){
                    translate([0,0,triangleHeight/2]){
                        fillet_angled_corner_mask(fillet=fillet, ang=45);
                    }
                }
            }
        }
        
    }
    
}

module right_triangle(side1,side2,corner_radius,triangle_height){
  translate([corner_radius,corner_radius,0]){  
    hull(){  
    cylinder(r=corner_radius,h=triangle_height);
      translate([side1 - corner_radius * 2,0,0])cylinder(r=corner_radius,h=triangle_height);
          translate([0,side2 - corner_radius * 2,0])cylinder(r=corner_radius,h=triangle_height);  
    }
  }
    
}