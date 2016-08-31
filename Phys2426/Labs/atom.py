#### AUTHORS
# Hunter Ducharme & Gustavo Castro
####

from visual import *

scene.width=800
scene.height=800

# Define charges
proton = sphere(pos=(0,0,0), radius=1e-11, color=color.red)
electron_a = sphere(pos=(1e-10,0,0), radius=1e-11, color=color.green, make_trail=true) 
electron_b = sphere(pos=(-1e-10,0,0), radius=1e-11, color=color.blue, make_trail=true) 

# Define intitial vectors
proton.pos = vector(0,0,0)
electron_a.pos = vector(1e-10,0,0)
electron_a.vel = vector(0,2e6,0)
electron_b.pos = vector(-1e-10,0,0)
electron_b.vel = vector(0,0,-2e6)

# Define constants
dt = 3.14e-20
mass_elec = 9.11e-31
q = 1.6e-19
K = 8.99e9

# Compute projectile motion
for t in arange(0,2.14e-15,dt):
  rate(10000)

  r_a = electron_a.pos
  F_a = ((-K*(q**2))/(mag(r_a)**3)) * (r_a)

  r_b = electron_b.pos
  F_b = ((-K*(q**2))/(mag(r_b)**3)) * (r_b)

  accel_a = (F_a)/(mass_elec)
  electron_a.pos = electron_a.pos + electron_a.vel*dt + (0.5)*(accel_a)*(dt**2)
  electron_a.vel = electron_a.vel + accel_a*dt

  accel_b = (F_b)/(mass_elec)
  electron_b.pos = electron_b.pos + electron_b.vel*dt + (0.5)*(accel_b)*(dt**2)
  electron_b.vel = electron_b.vel + accel_b*dt
  




