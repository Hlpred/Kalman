landing_site = [100;200;0];

marker_data = [];
n = 3;
r = 5;
for i = 1:n
    theta = (2*pi)/n;
    marker = [r*cos(theta*i); r*sin(theta*i); 0.5];
    marker_data = [marker_data, marker];
end
n = 3;
r = 5;
for i = 1:n
    theta = (2*pi)/n;
    marker = [landing_site(1) + r*cos(theta*i); landing_site(2) + r*sin(theta*i); 0.5];
    marker_data = [marker_data, marker];
end
n = 3;
r = 10;
for i = 1:n
    theta = (2*pi)/n;
    marker = [r*cos(theta*i + pi/3); r*sin(theta*i + pi/3); 0.5];
    marker_data = [marker_data, marker];
end

marker_data = [marker_data, [50;60;0.5]];
marker_data = [marker_data, [50;100;0.5]];
marker_data = [marker_data, [20;80;0.5]];

visualize = false;
N = size(marker_data, 2);
if visualize
    for i=1:N
        plot(marker_data(1,i),marker_data(2,i),'b*')
        hold on
    end
    plot(0,0,'r*')
    plot(landing_site(1),landing_site(2),'r*')
    
    axis equal
end

open("EKF.slx")