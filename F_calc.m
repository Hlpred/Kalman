r = sym('r', [3, 1]);
r_dot = sym('r_dot', [3, 1]);
r_dot_dot = sym('r_dot_dot', [3, 1]);
eulers = sym('eulers', [3, 1]);
eulers_dot = sym('eulers_dot', [3, 1]);
omega = sym('omega', [3, 1]);
omega_dot = sym('omega_dot', [3, 1]);
torque = sym('torque', [3, 1]);
syms dt thrust mass;

L = [1 sin(eulers(1))*tan(eulers(2)) cos(eulers(1))*tan(eulers(2));
     0 cos(eulers(1)) -sin(eulers(1));
     0 sin(eulers(1))*sec(eulers(2)) cos(eulers(1))*sec(eulers(2))];
marker_data
L_prime = [0, sin(eulers(1))*(sec(eulers(2))^2)*eulers_dot(2) + tan(eulers(2))*cos(eulers(1))*eulers_dot(1), cos(eulers(1))*(sec(eulers(2))^2)*eulers_dot(2) - tan(eulers(2))*sin(eulers(1))*eulers_dot(1);
           0, -sin(eulers(1))*eulers_dot(1), -cos(eulers(1))*eulers_dot(1);
           0, sin(eulers(1))*(tan(eulers(2))*sec(eulers(2)))*eulers_dot(2) + sec(eulers(2))*cos(eulers(1))*eulers_dot(1), cos(eulers(1))*(tan(eulers(2))*sec(eulers(2)))*eulers_dot(2) - sec(eulers(2))*sin(eulers(1))*eulers_dot(1)];

A = [cos(eulers(3))*cos(eulers(2)), cos(eulers(2))*sin(eulers(3)), -sin(eulers(2));
     cos(eulers(3))*sin(eulers(2))*sin(eulers(1))-cos(eulers(1))*sin(eulers(3)), cos(eulers(3))*cos(eulers(1))+sin(eulers(3))*sin(eulers(2))*sin(eulers(1)), cos(eulers(2))*sin(eulers(1));
     sin(eulers(3))*sin(eulers(1))+cos(eulers(3))*cos(eulers(1))*sin(eulers(2)), cos(eulers(1))*sin(eulers(3))*sin(eulers(2))-cos(eulers(3))*sin(eulers(1)), cos(eulers(2))*cos(eulers(1))].';

%Assumes MOI of eye(3)
result = [r + r_dot*dt + 0.5*r_dot_dot*dt^2;
          r_dot + r_dot_dot*dt;
          (A)*([0;0;thrust]./mass);
          eulers + eulers_dot*dt;
          eulers_dot + dt*(L*omega_dot + L_prime*omega);
          omega + dt*omega_dot
          torque];

F = matlabFunction(result);

J = jacobian(result, [r; r_dot; r_dot_dot; eulers; eulers_dot; omega; omega_dot]);
F_jacobian = matlabFunction(J, 'Vars', [r; r_dot; r_dot_dot; eulers; eulers_dot; omega; omega_dot; dt; thrust; mass; torque]);