from visual import *

scene.width=800
scene.height=800

sp = 2

# Define capcitor plates & charge
cap_one = box(pos=(0,sp,0), size=(10,0.1,sp))
pos_one = vector(0,sp,0)
cap_two = box(pos=(0,-sp,0), size=(10,0.1,sp))
pos_two = vector(0,-sp,0)
charge = sphere(pos=(-20,0,0), radius=0.25, color=color.blue)

# Define charge equations
charge.vel = vector(1,0,0)
charge.pos = vector(0,0,0)
dt = 0.01
m = 1.67e-27

# Define electric field constants
q = 1.6e-19
r_hat = 0
gravity = vector(0,-9.807,0)
epsilon = 8.85e-12
eta = 9.06e-19

# Compute projectile motion
for t in arange(0,5,dt):
  rate(50)

  r1 = charge.pos - pos_one
  r2 = charge.pos - pos_two
  r1_hat = r1/mag(r1)
  r2_hat = r2/mag(r2)

  E = vector(0, (eta/(epsilon)), 0)
  F_net = q*E + m*gravity

  if mag(charge.pos) < 1.5*sp:
    a_net = (F_net)/(m)
    charge.vel = charge.vel + a_net*dt
    charge.pos = charge.pos + charge.vel*dt + (0.5)*(a_net)*(dt**2)




