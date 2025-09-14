r = sym('r', [3, 1]);
r_dot = sym('r_dot', [3, 1]);
r_dot_dot = sym('r_dot_dot', [3, 1]);
eulers = sym('eulers', [3, 1]);
eulers_dot = sym('eulers_dot', [3, 1]);
omega = sym('omega', [3, 1]);
omega_dot = sym('omega_dot', [3, 1]);
syms dt;

R = [cos(eulers(3))*cos(eulers(2)), cos(eulers(2))*sin(eulers(3)), -sin(eulers(2));
     cos(eulers(3))*sin(eulers(2))*sin(eulers(1))-cos(eulers(1))*sin(eulers(3)), cos(eulers(3))*cos(eulers(1))+sin(eulers(3))*sin(eulers(2))*sin(eulers(1)), cos(eulers(2))*sin(eulers(1));
     sin(eulers(3))*sin(eulers(1))+cos(eulers(3))*cos(eulers(1))*sin(eulers(2)), cos(eulers(1))*sin(eulers(3))*sin(eulers(2))-cos(eulers(3))*sin(eulers(1)), cos(eulers(2))*cos(eulers(1))];

result = R*r_dot_dot;
J = jacobian(R*r_dot_dot, [r; r_dot; r_dot_dot; eulers; eulers_dot; omega; omega_dot]);
F_jacobian = matlabFunction(J, 'Vars', [r; r_dot; r_dot_dot; eulers; eulers_dot; omega; omega_dot; dt]);