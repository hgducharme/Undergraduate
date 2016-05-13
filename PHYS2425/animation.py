from __future__ import division
from visual import *
from visual.graph import *


### Define constants. ###
speed = 20                 # Speed of 20 m/s.
g = vector(0, 9.8, 0)     # Defines gravity vector.
C = 0.5                    # Drag coefficient for a sphere.
diameter = .3              # Simulating a 1-ft diameter soccer ball.
area = pi*(diameter**2)/4  # Cross sectional area.
b = 0.5*C*1.2*area         # F_drag= -bv^2
m = 0.7                    # Weight of soccer ball (kg).
print('The drag constant b = {0:.3f} Kg/s').format ( b )



### Create animation objects. ###
ball = sphere(pos = vector(30, 1.25, -4), radius = 1.25, color = color.white)
field = box(pos = vector(0, -2.5, 0), length = 105, height = 5, width = 68.5, material = materials.earth)
goal = curve(pos = [ (52.5, 0, 20), (52.5, 14.2, 20), (52.5, 14.2, -20), (52.5, 0, -20) ], radius=.5, color = color.white)
rod = cylinder(pos=(52,0,33.25), axis=(0,7,0), radius=.5)## flag
rod = cylinder(pos=(52,0,-33.25), axis=(0,7,0), radius=.5)
pyramid(pos=(52.5,5.5,-33.25), size=(2,2,0), color=color.red)
pyramid(pos=(52.5,5.5,33.25), size=(2,2,0), color=color.red)



### Set up the animation display. ###
scene.center = vector(0, 1, 0)     # Scene remains centered around this point
scene.forward = vector(0, -5, -20)  # Angle of view



### Start animation with mouse. ###
ClickLabel = label(pos = (0, 5, 0), text = 'Click on screen to kick the ball.')
scene.mouse.getclick() 
ClickLabel.visible = false



### Launch angle of the projectile, and initialize the ball. ###
theta = 50
radian = (theta/180)*(math.pi)
ball.position = vector (30, 1.25, -4)
ball.velocity = vector (speed*cos(radian), speed*sin(radian), speed*cos(radian))
ball.acceleration = -g
ball.trail = curve(color = color.yellow)
dt = 0.001

while ball.position.x <= 52.5 and ball.position.y >= 0:
  rate(1000)
  ball.trail.append(pos = ball.position)

  # Forces on the ball.
  drag = b * ( (mag(ball.velocity)) ** 2 )
  drag_vector = vector( - drag*cos(theta), - drag*sin(theta), -drag*cos(theta) )
  force_net = (-m*g) + drag_vector
  drag_acceleration = (force_net/m)

  # Update the ball's position and velocity.
  ball.position = ball.position + (ball.velocity * dt) + (0.5)*(ball.acceleration)*(dt ** 2)
  ball.velocity = ball.velocity + (ball.acceleration * dt)



### Display goal or missed message. ###
if ball.position.x > 52.5 and ball.position.y < 14.2:
  disp_goal = label(pos = (0, 5, 0), text = u'\u00A1\u00A1\u00A1 GOOOOOAAAAALLLLL !!! \u00A1\u00A1\u00A1 GOOOOOAAAAALLLLL !!! \u00A1\u00A1\u00A1 GOOOOOAAAAALLLLL !!!')
else:
    disp_miss = label(pos = (0, 5, 0), text='Missed, try again')
