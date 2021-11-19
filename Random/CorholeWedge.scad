frontHeight = 6.4;
backHeight = 9.4;
depth = 101.8;
width = 38.2;

point1 = [0, 0];
point2 = [0, frontHeight];
point3 = [width, backHeight];
point4 = [width, 0];

points = [point1, point2, point3, point4];

linear_extrude(height=depth, center=true){
    polygon(points);
}