%% Kalman Filter Implementation in MATLAB

% Define simulation parameters
n = 3;  % Number of state variables: [position; velocity; acceleration]
m = 1;  % Number of measurement variables (position)
dt = 0.1; % Time step
num_steps = 100; % Number of time steps

% State transition model (A)
A = [1 dt 0.5*dt^2;  
     0 1  dt;         
     0 0  1];

% Control input model (B) - assuming no control input
B = zeros(n, 1);

% Measurement model (H)
H = [1 0 0]; % Only position is measured

% Process noise covariance (Q)
q = 0.1; % Process noise strength
Q = q * [dt^4/4, dt^3/2, dt^2/2; 
          dt^3/2, dt^2,   dt;    
          dt^2/2, dt,     1];

% Measurement noise covariance (R)
r = 1; % Measurement noise strength
R = r;

% Initialize state estimate (x) and covariance (P)
x = [0; 0; 0]; % Initial state: [position; velocity; acceleration]
P = eye(n); % Initial covariance matrix

% Generate synthetic measurements (true position + noise)
true_position = zeros(num_steps, 1);
measurements = zeros(num_steps, 1);
true_state = [0; 1; 0.2]; % Initial true state: [position; velocity; acceleration]

for t = 1:num_steps
    % True state evolution
    true_state = A * true_state + B; % Assuming no control input
    true_position(t) = true_state(1);

    % Add measurement noise
    measurements(t) = true_position(t) + sqrt(R) * randn;
end

% Storage for estimates
estimates = zeros(num_steps, n);

%% Kalman Filter Loop
for t = 1:num_steps
    % Prediction step
    x = A * x;          % Predict state
    P = A * P * A' + Q; % Predict covariance

    % Measurement update step
    z = measurements(t); % Current measurement
    y = z - H * x;       % Measurement residual
    S = H * P * H' + R;  % Residual covariance
    K = P * H' / S;      % Kalman gain
    x = x + K * y;       % Update state estimate
    P = (eye(n) - K * H) * P; % Update covariance

    % Store estimates
    estimates(t, :) = x';
end

%% Plot results
time = (0:num_steps-1) * dt;
figure;
plot(time, true_position, 'g-', 'LineWidth', 2); hold on;
plot(time, measurements, 'rx', 'LineWidth', 1);
plot(time, estimates(:, 1), 'b-', 'LineWidth', 2);
legend('True Position', 'Measurements', 'Estimated Position');
xlabel('Time (s)');
ylabel('Position');
title('Kalman Filter Position Estimation');
grid on;
