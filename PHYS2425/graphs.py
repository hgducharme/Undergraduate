from __future__ import division
from visual import *
from visual.graph import *


############### DEFINING CONTSTANTS & VARIABLES ###############

# Define constants.
speed = 20                 # Speed of 20 m/s.
g = vector(0, 9.8, 0)     # Defines gravity vector.
C = 0.5                    # Drag coefficient for a sphere.
diameter = .3              # Simulating a 1-ft diameter soccer ball.
area = pi*(diameter**2)/4  # Cross sectional area.
b = 0.5*C*1.2*area         # F_drag= -bv^2
m = 0.7                    # Weight of soccer ball (kg).

# Defines variables.
range_nodrag_tuples = [ (0,0) ]   # An array with format (angle, range).
rangedrag_tuples = [ (0,0) ]      # An array with format (angle, range).
dt = 0.0001                       # The change in time between each timestamp.

############### END: DEFINING CONSTANTS & VARIABLES ###############





############### STATISTICS OF BALL WITHOUT AIRDRAG ###############

# Statistics for range of the ball without air drag.
range_no_drag = ( (speed**2) * sin(90) )/( mag(g) )
print('')
print('For a speed of {} m/s').format( str(speed) )
print('the maximum range without drag is: {0:.3f} m').format( range_no_drag )
print('at a launch angle of 45 degrees')

############### END: STATISTICS OF BALL WITHOUT AIRDRAG ###############





############### CALCULATE BEST ANGLE FOR BALL WITH DRAG ###############

# For all angles between 1 and 90 degrees, find the maximum range w/ drag.
for i in arange(0,90, 1):
  radian = (i/180)*(math.pi)
  position = vector(0,0,0)
  velocity = vector( speed*cos(radian), speed*sin(radian), 0 )

  # While the position of the ball is above the ground, plot the trajectory.
  while position.y >= 0:
    drag = b * ( (mag(velocity)) **2 )
    current_angle = atan( velocity.y / velocity.x )

    drag_vector = vector( - drag*cos(current_angle), - drag*sin(current_angle), 0 )

    force_net = (-m*g) + drag_vector
    drag_acceleration = (force_net/m)

    # Expressions to update position, velocity, and acceleration of the ball.
    acceleration = drag_acceleration
    position = position + (velocity*dt) + ( (1/2)*(acceleration)*(dt**2) )
    velocity = velocity + ( acceleration * dt )

  # Appends each angle and it's range counterpart to the array.
  rangedrag_tuples.append( (i, position[0]) )

##### END: FOR LOOP #####

# Sort the array from greatest to smallest range, and return greatest range.
datasorted = sorted(rangedrag_tuples, key=lambda rangedrag: rangedrag[1],reverse=true) 

print(' ')

# Statistics for range of the ball with air drag.
print('For a drag constant of b = {0:.3f} Kg/s').format( b )
print('the maximum range with drag is {0:.3f} m').format( datasorted[0][1] )
print('at a launch angle of {} degrees').format( str(datasorted[0][0]) )

############### END: CALCULATE BEST ANGLE FOR BALL WITH DRAG ###############





############### PLOT RANGE VS ANGLE ###############

# Plots each rangedrag_tuple; a range vs. angle plot. 
range_plot = gdisplay(x = 0, y = 0, width = 600, height = 400, title = 'Angle vs. Range Plot', xtitle = 'Projectile angle', ytitle = 'Rangle of the ball')
range_vs_angle = gcurve(color = color.red)
range_vs_angle.plot(pos = rangedrag_tuples)

############### END: PLOT RANGE VS ANGLE ###############





############### PLOT BALL TRAJECTORIES ###############

# Plots the trajectory of the ball with and without airdrag.
difference_plot = gdisplay(x = 0, y = 0, width = 600, height = 600, title = 'Range vs. Time Plot', xtitle = 'Range', ytitle = 'Height')
drag_vs_time = gcurve(color = color.red)
nodrag_vs_time = gcurve(color = color.green)

# For every .1 meter until max_range, plot the trajectory of the dragless ball.
for x in arange(0, range_no_drag,0.1):
  nodrag_vs_time.plot( pos = (x, (tan(45)*x - (9.8 / (2 * speed**2 * cos(45)**2 ) * (x**2)) ))) 

# For every .1 meter until max_range, plot the trajectory of the ball w/ drag.
optimum_theta = datasorted[0][0]  
max_drag_range = datasorted[0][1]
optimum_radian = (optimum_theta/180)*(math.pi)

funcPosi = vector(0, 0, 0)
funcVelocity = vector(speed*cos(optimum_radian), speed*sin(optimum_radian), 0)
posi_list = [ [funcPosi[0], funcPosi[1], funcPosi[2]] ]

while funcPosi.y >= 0:
  drag = b * funcVelocity * mag(funcVelocity)
  funcAccel = ( -drag - (m*g) )/m

  # Expressions to update position, and velocity of the ball.
  funcPosi = funcPosi + (funcVelocity * dt) + ( (1/2)*(funcAccel)*(dt**2) )
  funcVelocity = funcVelocity + ( funcAccel * dt )
  
  # Append new position to posi_list
  posi_list.append( [funcPosi[0], funcPosi[1], 0] )

# Plot the trajectory of the ball with drag.
drag_vs_time.plot(pos = posi_list)

############### END: PLOT BALL TRAJECTORIES ###############





############### Display percentage difference between the two trajectories.
percentage = ( (range_no_drag - max_drag_range)/(range_no_drag) ) * 100
print(' ')
print("The force of drag on a soccer ball reduces the maximum range by {0:.2f} %.").format( percentage )
print('')
