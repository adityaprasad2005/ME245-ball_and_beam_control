clc;
clear all;
close all;

%% Question 1

K = 0.7791;  
P = tf(K, [1 0 0]);  

% ----------- Proportional Controller (P) -------------
Kp_values = [5, 10, 20];  
figure;
for i = 1:length(Kp_values)
    Kp = Kp_values(i); 
    C_P = Kp;  
    T_P = feedback(C_P * P, 1);  
    
    
    subplot(3,1,i);
    step(T_P);
    xlim([0, 10]);  
    title(['Proportional Controller with Kp = ', num2str(Kp)]);
end

% ----------- Proportional-Derivative Controller (PD) -------------
Kp = 5;  
Kd_values = [ 5, 10 , 20];  
figure;
for i = 1:length(Kd_values)
    Kd = Kd_values(i);
    C_PD = Kp + Kd * tf([1 0], 1);  
    T_PD = feedback(C_PD * P, 1);  
    
    info_PD = stepinfo(T_PD);
    
    subplot(3,1,i);
    step(T_PD);
    title(['Proportional-Derivative Controller with Kp = ', num2str(Kp), ', Kd = ', num2str(Kd)]);
    
    % performance metrics on the plot
    text(0.1, 0.8, ['Settling Time: ', num2str(info_PD.SettlingTime), ' s'], 'Units', 'normalized');
    text(0.1, 0.7, ['Overshoot: ', num2str(info_PD.Overshoot), ' %'], 'Units', 'normalized');
end

% ----------- Proportional-Integral-Derivative Controller (PID) -------------
Kp = 5;  
Kd = 10;   
Ki_values = [1, 5, 10];  
figure;
for i = 1:length(Kd_values)
    Ki = Ki_values(i);
    C_PID = Kp + Ki * tf(1, [1 0]) + Kd * tf([1 0], 1); 
    T_PID = feedback(C_PID * P, 1); 
    
    info_PID = stepinfo(T_PID);
    
    subplot(3,1,i);
    step(T_PID);
    title(['PID Controller with Kp = ', num2str(Kp), ', Ki = ', num2str(Ki), ', Kd = ', num2str(Kd)]);
    
    % performance metrics on the plot
    text(0.1, 0.8, ['Settling Time: ', num2str(info_PID.SettlingTime), ' s'], 'Units', 'normalized');
    text(0.1, 0.7, ['Overshoot: ', num2str(info_PID.Overshoot), ' %'], 'Units', 'normalized');
end


%% Question 3

K = 0.7791;  
P = tf(K, [1 0 0]);  % P(s) = K / s^2

% Desired target settling time and overshoot
desired_ts = 2.5;  % Desired settling time in seconds
desired_os = 4.5;  % Desired overshoot in percentage

[C_PID, info] = pidtune(P, 'PID', 1/desired_ts);  

disp('Initial Tuned PID Gains:');
disp(['Kp: ', num2str(C_PID.Kp)]);
disp(['Ki: ', num2str(C_PID.Ki)]); 
disp(['Kd: ', num2str(C_PID.Kd)]);

T_PID = feedback(C_PID * P, 1);

Kp = C_PID.Kp; 
Ki = 0;         
Kd = C_PID.Kd;  

overshoot = 10;  
settling_time = 10;  

% Analyze the system response
info = stepinfo(T_PID);
overshoot = info.Overshoot;
settling_time = info.SettlingTime;

while overshoot > desired_os || settling_time > desired_ts

    disp('Current Performance Metrics:');
    disp(['Settling Time (s): ', num2str(settling_time)]);
    disp(['Overshoot (%): ', num2str(overshoot)]);
    
    if overshoot > desired_os
        Kp = Kp * 0.8;  
        Kd = Kd * 1.1;  
    end
    
    if settling_time > desired_ts
        Kp = Kp * 1.2;  
    end
    
    C_PID_manual = pid(Kp, Ki, Kd);
    
    T_PID = feedback(C_PID_manual * P, 1);
    info = stepinfo(T_PID);
    overshoot = info.Overshoot;
    settling_time = info.SettlingTime;
end

% Final results
disp('Final Performance Metrics:');
disp(['Overshoot (%): ', num2str(overshoot)]);
disp(['Settling Time (s): ', num2str(settling_time)]);
disp('Final Tuned PID Gains:');
disp(['Kp: ', num2str(Kp)]);
disp(['Ki: ', num2str(Ki)]);
disp(['Kd: ', num2str(Kd)]);

figure;
step(T_PID);
title('Step Response with PID Controller Meeting Criteria');
grid on;