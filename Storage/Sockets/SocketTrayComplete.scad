use <SocketRoundedBase.scad>
use <SocketTray.scad>

//Globals
renderSockets = false;

resolution = 10;
offset = .001;

socketCount12 = 0;
socketCount38 = 21;
socketCount14 = 3;

trayWidth = 90;
trayDepth = 150;
trayHeight = 1;
trayBaseHeight = 14;

socketBuffer = 4;

slopeSize = 20;

// 1/2 Dimesions
connectionHeight12 = 17;
connectionWidth12 = 12;

baseHeight12 = 17;
baseDiameter12 = 24;
transitionHeight12 = 5;
upperHeight12 = 10;
upperDiameter12 = 17;

// 3/8ths Dimesions
connectionHeight38 = 12.5;
connectionWidth38 = 9;

baseHeight38 = 15;
baseDiameter38 = 18;
transitionHeight38 = 3;
upperHeight38 = 9;
upperDiameter38 = 14;

// 1/4 Dimesions
connectionHeight14 = 10.5;
connectionWidth14 = 6;

baseHeight14 = 13;
baseDiameter14 = 12;
transitionHeight14 = 1;
upperHeight14 = 8.5;
upperDiameter14 = 11;


trayRoudedBase(trayWidth, trayDepth, trayBaseHeight, slopeSize, resolution, true);

translate([0,0,trayBaseHeight]){
    createTray(trayWidth, trayDepth, trayHeight, socketBuffer, socketCount12, connectionHeight12, connectionWidth12, baseDiameter12, socketCount38, connectionHeight38, connectionWidth38, baseDiameter38, socketCount14, connectionHeight14, connectionWidth14, baseDiameter14, resolution);
}