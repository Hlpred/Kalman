syms phi theta psi phi_dot theta_dot psi_dot

L = [1 sin(phi)*tan(theta) cos(phi)*tan(theta);
     0 cos(phi) -sin(phi);
     0 sin(phi)*sec(theta) cos(phi)*sec(theta)];

L_prime = [0, sin(phi)*(sec(theta)^2)*theta_dot + tan(theta)*cos(phi)*phi_dot, cos(phi)*(sec(theta)^2)*theta_dot - tan(theta)*sin(phi)*phi_dot;
           0, -sin(phi)*phi_dot, -cos(phi)*phi_dot;
           0, sin(phi)*(tan(theta)*sec(theta))*theta_dot + sec(theta)*cos(phi)*phi_dot, cos(phi)*(tan(theta)*sec(theta))*theta_dot - sec(theta)*sin(phi)*phi_dot];

omega = [phi; theta; psi];
omega_dot = [phi_dot; theta_dot; psi_dot];

e_double_dot = (L*omega_dot) + (L_prime*omega);