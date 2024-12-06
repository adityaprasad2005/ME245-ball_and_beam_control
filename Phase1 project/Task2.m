clc;
clear all;
close all;

%% Tasks 2.1 

% Plot open loop poles and zeros
% Plot the open loop step response

m= 0.01; % mass of ball
g= 9.81; % gravity
R= 0.02; % radius of the ball
J= 16e-7;% Icm of spherical ball
d= 0.07; % lever-arm offset
L= 0.15; % length of the beam

s= tf('s');
openloopTF= -(m*g*d/L)/(s^2*(m+ J/R^2));

figure;
rlocus(openloopTF);

figure;
step(openloopTF);
disp(stepinfo(openloopTF));

%% Task 2.2

% This is a second order system(Type-II) having both of its open poles at zero.
% The root locus branches start from s=0 (location of the common poles) and branch out 
% towards the open zeros located at +Inf/-Inf respectively .
% Using the above system parameters, the unit step response is seen to
% montonically deviating away from its intended value.
% Hence this system(PlantTf=G(s) + FeedbackTf=1) necessities a controller to
% counter the growing errors.