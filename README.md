# Ball and Beam System Control

**Problem Statement:**

This project focuses on designing a control system for a ball and beam system. The system consists of a ball placed on a beam, and a servo motor that can adjust the angle of the beam. The control system's objective is to manipulate the ball's position along the beam by adjusting the beam angle.

**Files:**

* **Task2.m:** This MATLAB script analyzes the system dynamics. It includes the following:
    - Plotting the system's poles and zeros
    - Plotting the open-loop step response of the system

* **Task3.m:** This MATLAB script designs and analyzes different control strategies for the ball and beam system. It covers the following controllers:
    - Proportional (P) controller
    - Proportional-Derivative (PD) controller
    - Proportional-Integral-Derivative (PID) controller
    - The script evaluates the performance of these controllers in terms of transient response, steady-state error, and overshoot.

* **Arduino_control.ino:** This Arduino code implements the PID control algorithm to control the servo motor based on the calculated control signal.

* **Task6.m:** This MATLAB script performs root locus and Bode plot analysis of the system's open-loop transfer function. It analyzes the system's stability margins and recommends compensator design based on the plots and design criteria.

* **Task7.m:** This MATLAB script designs a first-order lead/lag compensator based on the recommendations from Task 6. It plots the root locus and Bode plot of the compensated system, analyzes the pole-zero placement strategy, and verifies the system's performance against the design criteria.

**Project Report:**

The project report contains a detailed description of all tasks, including:

* **Task 1: System Dynamics**
    - Derivation of the system's dynamic equations
    - Linearization of the system and representation in state-space form
* **Task 4: Simulation in MATLAB**
    - Building the ball and beam model in Simulink
    - Linearizing the model and designing a compensator to meet the specified performance requirements
    - Developing a Simscape model for the ball and beam system
* **Task 5: Physical System**
    - Designing and building the physical ball and beam system
    - Implementing the PID control algorithm on the physical system
    - Analyzing the performance of the physical system and addressing challenges encountered during implementation
* **Task 6: Root Locus and Bode Plot**
    - Plotting the system's open-loop root locus and bode plot
    - Analyzing the system's stability margins
    - Recommending compensator design based on the plots and design criteria
* **Task 7: Controller Design using Root Locus and Bode Plot Approaches**
    - Designing a first-order lead/lag compensator to meet the design criteria
    - Plotting the root locus and Bode plot of the compensated system
    - Analyzing the pole-zero placement strategy and its impact on the system's response
    - Verifying the system's performance against the design criteria
* **Task 8: Demonstration of the Physical Project Setup**
    - Tuning the PID controller to stabilize the ball at a desired position
    - Demonstrating the controller's ability to respond to minor perturbations
