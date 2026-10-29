use<SocketBase.scad>
use<Socket.scad>

module createTray(trayWidth, trayDepth, trayBaseHeight, socketBuffer, socketCount12, connectionHeight12, connectionWidth12, baseDiameter12, socketCount38, connectionHeight38, connectionWidth38, baseDiameter38, socketCount14, connectionHeight14, connectionWidth14, baseDiameter14, resolution){
    
    //Initialize a few convenience variables
    socketBufferHalf = socketBuffer/2;
    
    baseRadius12 = baseDiameter12/2;
    baseRadius38 = baseDiameter38/2;
    baseRadius14 = baseDiameter14/2;
    
    //Create the base
    cube([trayWidth, trayDepth, trayBaseHeight], false);

    //Start creating sockets at proper height
    translate([0,0,trayBaseHeight]){
        
        socketsPerRow12 = floor(trayWidth/(baseDiameter12+socketBuffer));
        
        socketRows12 = ceil(socketCount12 / socketsPerRow12);
        
        socketSectionWidth12 = trayWidth / socketsPerRow12;
        socketSectionDepth12 = baseDiameter12+socketBuffer;
        
        renderBases(trayWidth, socketCount12, socketsPerRow12, socketSectionWidth12, socketSectionDepth12, connectionWidth12, connectionHeight12, 0, resolution);
        
        lastRowSockets12 = socketCount12 % socketsPerRow12;
        excessSpace12 = lastRowSockets12 ? trayWidth - (lastRowSockets12 * socketSectionWidth12) : 0;
        
        translate([0, socketSectionDepth12 * socketRows12, 0]){
            
            socketsPerRow38 = floor(trayWidth/(baseDiameter38+socketBuffer));
            
            socketRows38 = ceil(socketCount38 / socketsPerRow38);
            
            socketSectionWidth38 = trayWidth / socketsPerRow38;
            socketSectionDepth38 = baseDiameter38+socketBuffer;
            
            renderBases(trayWidth, socketCount38, socketsPerRow38, socketSectionWidth38, socketSectionDepth38, connectionWidth38, connectionHeight38, excessSpace12, resolution);
            
            socketsDisplaced38 = floor(excessSpace12 / socketSectionWidth38);
            lastRowSockets38 = (socketCount38-socketsDisplaced38) % socketsPerRow38;
            excessSpace38 = lastRowSockets38 ? trayWidth - (lastRowSockets38 * socketSectionWidth38) : 0;
            
            translate([0, socketSectionDepth38 * socketRows38, 0]){
            
                socketsPerRow14 = floor(trayWidth/(baseDiameter14+socketBuffer));
                
                socketRows14 = ceil(socketCount14 / socketsPerRow14);
                
                socketSectionWidth14 = trayWidth / socketsPerRow14;
                socketSectionDepth14 = baseDiameter14+socketBuffer;
                
                
                renderBases(trayWidth, socketCount14, socketsPerRow14, socketSectionWidth14, socketSectionDepth14, connectionWidth14, connectionHeight14, excessSpace38, resolution);
            }
        }
        

    }
}

module createTrayWithSockets(trayWidth, trayDepth, trayBaseHeight, socketBuffer, socketCount12, connectionHeight12, connectionWidth12, baseHeight12, baseDiameter12, transitionHeight12, upperHeight12, upperDiameter12, socketCount38, connectionHeight38, connectionWidth38, baseHeight38, baseDiameter38, transitionHeight38, upperHeight38, upperDiameter38, socketCount14, connectionHeight14, connectionWidth14, baseHeight14, baseDiameter14, transitionHeight14, upperHeight14, upperDiameter14, resolution, renderSockets){
    
    //Initialize a few convenience variables
    socketBufferHalf = socketBuffer/2;
    
    baseRadius12 = baseDiameter12/2;
    baseRadius38 = baseDiameter38/2;
    baseRadius14 = baseDiameter14/2;
    
    //Create the base
    cube([trayWidth, trayDepth, trayBaseHeight], false);

    //Start creating sockets at proper height
    translate([0,0,trayBaseHeight]){
        
        socketsPerRow12 = floor(trayWidth/(baseDiameter12+socketBuffer));
        
        socketRows12 = ceil(socketCount12 / socketsPerRow12);
        
        socketSectionWidth12 = trayWidth / socketsPerRow12;
        socketSectionDepth12 = baseDiameter12+socketBuffer;
        
        renderBases(trayWidth, socketCount12, socketsPerRow12, socketSectionWidth12, socketSectionDepth12, baseHeight12, baseDiameter12, upperHeight12, upperDiameter12, transitionHeight12, connectionWidth12, connectionHeight12, 0, , resolution, renderSockets);
        
        lastRowSockets12 = socketCount12 % socketsPerRow12;
        excessSpace12 = lastRowSockets12 ? trayWidth - (lastRowSockets12 * socketSectionWidth12) : 0;
        
        translate([0, socketSectionDepth12 * socketRows12, 0]){
            
            socketsPerRow38 = floor(trayWidth/(baseDiameter38+socketBuffer));
            
            socketRows38 = ceil(socketCount38 / socketsPerRow38);
            
            socketSectionWidth38 = trayWidth / socketsPerRow38;
            socketSectionDepth38 = baseDiameter38+socketBuffer;
            
            renderBases(trayWidth, socketCount38, socketsPerRow38, socketSectionWidth38, socketSectionDepth38, baseHeight38, baseDiameter38, upperHeight38, upperDiameter38, transitionHeight38, connectionWidth38, connectionHeight38, excessSpace12, resolution, renderSockets);
            
            socketsDisplaced38 = floor(excessSpace12 / socketSectionWidth38);
            lastRowSockets38 = (socketCount38-socketsDisplaced38) % socketsPerRow38;
            excessSpace38 = lastRowSockets38 ? trayWidth - (lastRowSockets38 * socketSectionWidth38) : 0;
            
            translate([0, socketSectionDepth38 * socketRows38, 0]){
            
                socketsPerRow14 = floor(trayWidth/(baseDiameter14+socketBuffer));
                
                socketRows14 = ceil(socketCount14 / socketsPerRow14);
                
                socketSectionWidth14 = trayWidth / socketsPerRow14;
                socketSectionDepth14 = baseDiameter14+socketBuffer;
                
                
                renderBases(trayWidth, socketCount14, socketsPerRow14, socketSectionWidth14, socketSectionDepth14, baseHeight14, baseDiameter14, upperHeight14, upperDiameter14, transitionHeight14, connectionWidth14, connectionHeight14, excessSpace38, resolution, renderSockets);
            }
        }
        

    }
}

module renderBases(trayWidth, socketCount, socketsPerRow, socketSectionWidth, socketSectionDepth, connectionWidth, connectionHeight, excessSpace, resolution){
    
    socketSectionWidthHalf = socketSectionWidth/2;
    socketSectionDepthHalf = socketSectionDepth/2;
    
    excessSocketCount = socketCount < floor(excessSpace/socketSectionWidth) ? socketCount : floor(excessSpace/socketSectionWidth);

    

    if(excessSocketCount > 0){
        translate([trayWidth-excessSpace, -socketSectionDepth,0]){
            for(sockets = [0:excessSocketCount-1]){
                
                translate([socketSectionWidthHalf + (socketSectionWidth * sockets),socketSectionDepthHalf ,0]){
                    socket_base(connectionWidth, connectionHeight, resolution);
                }
                
            }
        }
    }
    
    if(socketCount > 0){
        socketsToRender = socketCount-1-excessSocketCount;
        if(socketsToRender >= 0){
            for(sockets = [0:socketsToRender]){
                socketRowRaw = sockets/socketsPerRow;
                socketRow = floor(socketRowRaw);
                
                socketRowCount = sockets % socketsPerRow;
                
                translate([socketSectionWidthHalf + (socketSectionWidth * socketRowCount),socketSectionDepthHalf + (socketSectionDepth * socketRow),0]){
                    socket_base(connectionWidth, connectionHeight, resolution);
                }
                
            }
                    
        }
    }
}


module renderBasesWithSockets(trayWidth, socketCount, socketsPerRow, socketSectionWidth, socketSectionDepth, baseHeight, baseDiameter, upperHeight, upperDiameter, transitionHeight, connectionWidth, connectionHeight, excessSpace, resolution, renderSockets){
    
    socketSectionWidthHalf = socketSectionWidth/2;
    socketSectionDepthHalf = socketSectionDepth/2;
    
    excessSocketCount = socketCount < floor(excessSpace/socketSectionWidth) ? socketCount : floor(excessSpace/socketSectionWidth);

    

    if(excessSocketCount > 0){
        translate([trayWidth-excessSpace, -socketSectionDepth,0]){
            for(sockets = [0:excessSocketCount-1]){
                
                translate([socketSectionWidthHalf + (socketSectionWidth * sockets),socketSectionDepthHalf ,0]){
                        if(renderSockets){
                            socket(baseHeight, baseDiameter, upperHeight, upperDiameter, transitionHeight, connectionWidth, connectionHeight, resolution);
                        }
                        socket_base(connectionWidth, connectionHeight, resolution);
                }
                
            }
        }
    }
    
    if(socketCount > 0){
        socketsToRender = socketCount-1-excessSocketCount;
        if(socketsToRender >= 0){
            for(sockets = [0:socketsToRender]){
                socketRowRaw = sockets/socketsPerRow;
                socketRow = floor(socketRowRaw);
                
                socketRowCount = sockets % socketsPerRow;
                
                translate([socketSectionWidthHalf + (socketSectionWidth * socketRowCount),socketSectionDepthHalf + (socketSectionDepth * socketRow),0]){
                    if(renderSockets){
                        socket(baseHeight, baseDiameter, upperHeight, upperDiameter, transitionHeight, connectionWidth, connectionHeight, resolution);
                    }
                    socket_base(connectionWidth, connectionHeight, resolution);
                    }
                    
                }
            }
        }
}


createTray(120, 150, 10, 4, 10, 17, 12, 24, 5, 12.5, 9, 18, 10, 10.5, 6, 12, 10);