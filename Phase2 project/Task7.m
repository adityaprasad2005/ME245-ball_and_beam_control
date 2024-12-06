clc;
clear all;
close all;

% Hardcoded Parameters
Mp = 0.14; % Maximum overshoot
val1 = (log(1/Mp)^2) * (1/pi^2); % Intermediate calculation for damping ratio
eta = sqrt(val1 / (1 + val1)); % Damping ratio
disp('Damping ratio (eta):');
disp(eta);

% Gain value
K1 = 0.8936; % Open-loop gain

% Settling time (s)
t_settle = 0.45; % Example: Settling time
wn = 4 / (t_settle * eta); % Natural frequency
disp('Natural frequency (wn):');
disp(wn);

% Open-loop transfer function
TF = tf(K1, [1 0 0]);  
disp('Open-loop transfer function:');
disp(TF);

% Characteristic equation coefficients for second-order system
coeff = [1, 2 * eta * wn, wn^2];
roots_sys = roots(coeff); % Roots of the characteristic equation
disp('System poles:');
disp(roots_sys);

% Real and imaginary parts of desired root
x = real(roots_sys(1));
y = imag(roots_sys(1));
desired_root = roots_sys(1);
disp('Desired root:');
disp(desired_root);

% Phase angle calculations
thetap = atan2(imag(desired_root), real(desired_root)); % Root phase angle (radians)
thetap_deg = rad2deg(thetap); % Convert to degrees
disp('Phase angle of desired root (deg):');
disp(thetap_deg);

% Open-loop transfer function phase at desired root
thetags = angle(evalfr(TF, desired_root)); % Evaluate TF phase in radians
thetags_deg = rad2deg(thetags); % Convert to degrees
disp('Open-loop TF phase at desired root (deg):');
disp(thetags_deg);

% Desired additional phase
thetad = thetags_deg; % Additional phase for compensator design
disp('Additional phase angle (deg):');
disp(thetad);

% Compensator zero and pole calculation
z = x - y / tan((thetap + thetags) / 2);
p = x - y / tan((thetap - thetags) / 2);
comp = tf([1 -z], [1 -p]); % Lead compensator transfer function
disp('Compensator zero:');
disp(z);
disp('Compensator pole:');
disp(p);
disp('Lead compensator transfer function:');
disp(comp);

% Total system with compensator
total = comp * TF;
mag = abs(evalfr(total, desired_root)); % Magnitude at desired root
Kc = 1 / mag; % Compensator gain adjustment
disp('Compensator gain (Kc):');
disp(Kc);
total = Kc * total; % Adjust total system
disp('Total system with compensator:');
disp(total);

% Closed-loop system
closed_loop = feedback(total, 1);
disp('Closed-loop transfer function:');
disp(closed_loop);

% Step response and settling time calculation
figure;
step(closed_loop);
grid on;
title('Unit Step Response');
xlabel('Time (s)');
ylabel('Amplitude');
[response, time] = step(closed_loop); % Get step response data
[peak, peakIndex] = max(response); % Find overshoot
overshoot = (peak - 1) * 100; % Percentage overshoot
tolerance = 0.02; % 2% settling time tolerance
steady_state = response(end); % Steady-state value
settling_time_index = find(abs(response - steady_state) <= tolerance, 1, 'last'); % Settling time index
settling_time = time(settling_time_index); % Settling time
disp('Settling time (s):');
disp(settling_time);
disp('Overshoot (%):');
disp(overshoot);

% Bode plot
figure;
bode(total);
grid on;
title('Bode Plot');

% Root locus plot
figure;
rlocus(total);
grid on;
title('Root Locus');
