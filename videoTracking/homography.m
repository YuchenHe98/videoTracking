clc;
clear all;

height = 1080;
width = 1920;

first_filename = './Annotation/CAM1-GOPR0333-21157.csv';
first_mtx = csvread(first_filename, 3, 0);

second_filename = './Annotation/CAM2-GOPR0288-21180.csv';
second_mtx = csvread(second_filename, 1, 0);

third_filename = './Annotation/CAM3-GOPR0342-21108.csv';
third_mtx = csvread(third_filename, 2, 0);

R1 = [0.96428667991264605 -0.26484969138677328 -0.0024165916859785336
      -0.089795446022112396 -0.31832382771611223 -0.94371961862719200
      0.24917459103354755 0.91023325674273947 -0.33073772313234923];
t1 = [0.13305621037591506; -0.25319578738559911; 2.2444637695699150];
f1 = 870.14531487461625;
u10 = 949.42001822880479;
v10 = 487.20049852775117;

R2 = [0.94962278945631540 0.31338395965783683 -0.0026554800661627576;
      0.11546856489995427 -0.35774736713426591 -0.92665194751235791;
      -0.29134784753821596 0.87966318277945221 -0.37591104878304971];
t2 = [-0.042633372670025989; -0.35441906393933242; 2.2750378317324982];
f2 = 893.34367240024267;
u20 = 949.96816131377727;
v20 = 546.79562177577259;

R3 = [-0.99541881789113029 0.038473906154401757 -0.087527912881817604
      0.091201836523849486 0.65687400820094410 -0.74846426926387233
      0.028698466908561492 -0.75301812454631367 -0.65737363964632056];
t3 = [-0.060451734755080713; -0.39533167111966377; 2.2979640654841407];
f3 = 872.90852997159800;
u30 = 944.45161471037636;
v30 = 564.47334036925656;

x_points = zeros(98, 1);
y_points = zeros(98, 1);
z_points = zeros(98, 1);

for frame = 1 : 98
   mtx = zeros(4, 3);
   vector = zeros(4, 1);
   u = first_mtx(frame, 2) + width / 2 - u10;
   v = height / 2 - first_mtx(frame, 3) - v10;
   
   mtx(1, 1) = f1 * R1(1, 1);
   mtx(1, 2) = f1 * R1(1, 2);
   mtx(1, 3) = f1 * R1(1, 3);
   vector(1, 1) = u * R1(3, 1) + u * R1(3, 2) + u * R1(3, 3);
   
   mtx(2, 1) = f1 * R1(2, 1);
   mtx(2, 2) = f1 * R1(2, 2);
   mtx(2, 3) = f1 * R1(2, 3);
   vector(2, 1) = v * R1(3, 1) + v * R1(3, 2) + v * R1(3, 3);
   
   u = second_mtx(frame, 2) + width / 2 - u20;
   v = height / 2 - second_mtx(frame, 3) - v20;
   
   mtx(3, 1) = f2 * R2(1, 1);
   mtx(3, 2) = f2 * R2(1, 2);
   mtx(3, 3) = f2 * R2(1, 3);
   vector(3, 1) = u * R2(3, 1) + u * R2(3, 2) + u * R2(3, 3);
   
   mtx(4, 1) = f2 * R2(2, 1);
   mtx(4, 2) = f2 * R2(2, 2);
   mtx(4, 3) = f2 * R2(2, 3);
   vector(4, 1) = v * R2(3, 1) + v * R2(3, 2) + v * R2(3, 3);
   
   sp = inv(transpose(mtx) * mtx) * transpose(mtx) * vector;
   x_points(frame, 1) = sp(1);
   y_points(frame, 1) = sp(2);
   z_points(frame, 1) = sp(3) * -1;
end

result = [x_points y_points z_points];
scatter3(x_points, y_points, z_points);

