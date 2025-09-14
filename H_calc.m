r = sym('r', [3, 1]);
r_dot = sym('r_dot', [3, 1]);
r_dot_dot = sym('r_dot_dot', [3, 1]);
eulers = sym('eulers', [3, 1]);
eulers_dot = sym('eulers_dot', [3, 1]);
omega = sym('omega', [3, 1]);
omega_dot = sym('omega_dot', [3, 1]);
marker = sym('marker', [3, 1]);
syms dt;


A = [cos(eulers(3))*cos(eulers(2)), cos(eulers(2))*sin(eulers(3)), -sin(eulers(2));
     cos(eulers(3))*sin(eulers(2))*sin(eulers(1))-cos(eulers(1))*sin(eulers(3)), cos(eulers(3))*cos(eulers(1))+sin(eulers(3))*sin(eulers(2))*sin(eulers(1)), cos(eulers(2))*sin(eulers(1));
     sin(eulers(3))*sin(eulers(1))+cos(eulers(3))*cos(eulers(1))*sin(eulers(2)), cos(eulers(1))*sin(eulers(3))*sin(eulers(2))-cos(eulers(3))*sin(eulers(1)), cos(eulers(2))*cos(eulers(1))];

delta = marker - r;
magnitude = sqrt((delta.')*delta);

final_matrix = (A*delta)/magnitude;
H = matlabFunction(final_matrix);

J = jacobian(final_matrix, [r; r_dot; r_dot_dot; eulers; eulers_dot; omega; omega_dot]);

H_jacobian = matlabFunction(J, 'Vars', [eulers; r; marker]);
