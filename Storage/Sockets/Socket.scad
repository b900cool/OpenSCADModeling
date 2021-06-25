use<SocketBase.scad>

connectionHeight = 15;
connectionWidth = 9;

baseHeight = 15;
baseDiameter = 18;
resolution = 100;
transitionHeight = 3;
upperHeight = 9;
upperDiameter = 14;
offset = .001;

module socket(baseHeight, baseDiameter, upperHeight, upperDiameter, transitionHeight, connectionWidth, connectionHeight, resolution){
    difference(){
        
        cylinder(baseHeight, d=baseDiameter, true, $fn=resolution);
        

        socket_base(connectionWidth, connectionHeight, resolution);
        
    }
    translate([0,0,baseHeight]){
        cylinder(transitionHeight, d1=baseDiameter, d2=upperDiameter, true, $fn=resolution);
        translate([0,0,transitionHeight]){
            cylinder(upperHeight, d=upperDiameter, true, $fn=resolution);
        }
    }
}

socket(15, 18, 9, 14, 3, 9, 15, 100);

