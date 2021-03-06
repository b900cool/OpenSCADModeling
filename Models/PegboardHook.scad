include<BOSL\transforms.scad>

// hookDiameter: The Diameter of the hook pieces
// hookLength: The legth of the hook out form its connection point
// hookHeight: The height of the hook 
// $fn: Resolution of the hook
module pegboardHook(hookDiameter=4, hookLength=7, hookHeight=10, $fn=128)
{
    hookRadius = hookDiameter/2;
    
    translate([0,-hookLength,0])
    {
        rotate([180,180,0])
        {
            
            rotate([90,0,0]){
                translate([0,0,hookRadius]){
                    cylinder(hookLength-hookRadius, hookRadius, hookRadius);
                }
            }

            hull(){    
                forward(hookRadius)sphere(hookRadius);
                up(hookRadius)sphere(hookRadius);
            }
            up(hookRadius)cylinder(hookHeight-hookRadius, hookRadius, hookRadius);
            
            translate([0,0,hookHeight]){
                sphere(hookRadius);
            }
            
        }
    }
}

//pegboardHook();