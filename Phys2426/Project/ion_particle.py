from __future__ import division
from visual import *
from visual.graph import *


# -----------------------------------------------------
# DRAW AXIS & DEFINE CONSTANTS
# -----------------------------------------------------
sp = .75
x = curve(pos = [(-sp,0,0),(sp,0,0)], color = color.red)
z = curve(pos = [(0,0,-sp),(0,0,sp)], color = color.cyan)

Bmag = 0.001            # Magnitude of the magnetic field. 
B0 = Bmag*vector(0,1,0) # Magnetic field vector. 
Vundef = 20000          # Average velocity in m/s of the beam of protons. 
Emag = Bmag*Vundef      # Magnitude of electric field (E = BV).
E = Emag*vector(0,0,-1) # E field is perpendicular to the B field.


# -----------------------------------------------------
# CREATES FLOOR, E, AND B FIELD
# -----------------------------------------------------

xmax = .4 # 0.8m x 0.8m velocity selector From -0.4m to 0.4m on xy plane.
dx = .1   # Draw grid with lines every 0.1m.

# Draw lines parallel to the z-axis.
for x in arange(-xmax, xmax+dx, dx):
   curve(pos=[(x,0,-xmax), (x,0,xmax)], color = (.7,.7,.7))

# Draw lines parallel to x-axis.
for z in arange(-xmax, xmax+dx, dx):
    curve(pos=[(-xmax, 0, z), (xmax, 0, z)], color = (.7, .7, .7))

bscale = 0.1 # Scale and length for drawings below magnetic field vectors.
Escale = 0.1 # Likewise for the E field.
z = 0

# Place arrows on the grid every 2dx.
for x in arange(-xmax, xmax+dx, 2*dx):
     arrow(pos = (x,0,z), axis = bscale*(B0/Bmag), color = color.cyan)
     arrow(pos = (x,0,z), axis = Escale*(E/Emag), color = color.red)

     for z in arange(-xmax, xmax+dx, 2*dx):
        arrow(pos = (x, 0, z), axis = bscale*(B0/Bmag), color = color.cyan)
        arrow(pos = (x, 0, z), axis = Escale*(E/Emag), color = color.red)

ClickLabel=label(pos=(0,0.5,0), text='Click on screen to continue.')
scene.mouse.getclick()
ClickLabel.visible=false


# -----------------------------------------------------
# MODEL PARTICLE DYNAMICS THROUGH E & B FIELD
# -----------------------------------------------------

deltat = 0.0000001      # Time step; minimum 6 0's.
q = 1.60e-19            # Charge of a proton.
m = 1.67e-27            # Mass of a proton.
rangedrag_tuples = []   # Define rangedrag_tuples.

for velocity in arange(.6*Vundef, 1.4*Vundef, 200):
    proton = sphere(pos =(-xmax+0.001, 0, 0), radius = 0.02, color = color.red, make_trail = true)
    proton.pos = vector(-xmax+0.001, 0, 0)
    proton.vel = velocity*vector(1, 0, 0)

    # Motion of proton while it is still inside the grid.
    while abs(proton.pos.x) <= xmax and abs(proton.pos.z) <= xmax:
        rate(10000)

        # Calculate net force and update proton's information.
        lorentz = (q)*(cross(proton.vel, B0))
        F_net = lorentz + q*E
        a_net = (F_net)/(m)
        proton.vel = proton.vel + a_net*deltat
        proton.pos = proton.pos + proton.vel*deltat + (0.5)*a_net*(deltat**2)

    # Store velocities & final z positions in array rangedrag_tuples.
    if velocity == .6*Vundef:
        rangedrag_tuples = [[velocity, proton.pos.z]]
    else:
        rangedrag_tuples.append([velocity, proton.pos.z])

# -----------------------------------------------------
# GRAPH EXIT LOCATION vs. VELOCITY
# -----------------------------------------------------

# Sort rangedrag_tuples in descending order & find dispersion range.
desc_tuples = sorted(rangedrag_tuples, key=lambda data: data[1], reverse=true)

maxloc = desc_tuples[0][1]
minloc = desc_tuples[-1][1]
dispersionrange = maxloc - minloc
print('For magnetic field = {0:.3f}T, the dispersion range is {1:.2f}m').format(Bmag, dispersionrange)

# Graph exit location vs. velocity.
dispersion_vs_B = gdisplay(x=100, y=200, width=600, height=400, title='Exit Location vs. Velocity', xtitle='Velocity', ytitle='Exit Location')
func = gcurve(color = color.cyan)
func.plot(pos = rangedrag_tuples)


# -----------------------------------------------------
# OPTIMAL MAGNETIC FIELD FOR MAX DISPERSION
# -----------------------------------------------------

dispersion_ranges = []
velocities = [.6*Vundef, 1.4*Vundef] # Only use initial and final velocities.

for magnetic_field in arange(0, 10*Bmag, .0001):
    minloc = 0  # Define minloc.
    maxloc = 0  # Define maxloc.
    proton = sphere(pos=(-xmax+0.001, 0, 0), radius = 0.001, color=color.black)

    for velocity in velocities:
        proton.pos = vector(-xmax+0.001, 0, 0)
        proton.vel = velocity*vector(1, 0, 0)
        B_field = magnetic_field*vector(0,1,0)

        # Motion of proton while it is still inside the grid.
        while abs(proton.pos.x) <= xmax and abs(proton.pos.z) <= xmax:
            # Calculate net force and update proton's information.
            lorentz = (q)*(cross(proton.vel, B_field))
            E = velocity*B_field
            F_net = lorentz + q*E
            a_net = (F_net)/(m)
            proton.vel = proton.vel + a_net*deltat
            proton.pos = proton.pos + proton.vel*deltat + (0.5)*a_net*(deltat**2)

        # Find minloc & maxloc.
        if minloc > proton.pos.z:
            minloc = proton.pos.z
        if maxloc < proton.pos.z:
            maxloc = proton.pos.z

    # Find dispersion range and update array dispersion_ranges.
    dispersionrange = maxloc - minloc
    dispersion_ranges.append([magnetic_field, dispersionrange])


# -----------------------------------------------------
# GRAPH DISPERSION vs. MAGNETIC FIELD
# -----------------------------------------------------

# Sort array dispersion_ranges in descending order.
desc_dispersions = sorted(dispersion_ranges, key=lambda data: data[1], reverse=true)

# Graph dispersion range vs. magnetic field value.
dispersion_vs_B = gdisplay(x=100, y=200, width=600, height=400, title='Dispersion vs. Magnetic Field', xtitle='Magnetic Field', ytitle='Dispersion Range')
func = gcurve(color = color.green)
func.plot(pos = dispersion_ranges)
print("The optimal magnetic field value is {0:.4f}T with a maximised dispersion range of {1:.2f}m.").format(#
    desc_dispersions[0][0], desc_dispersions[0][1])


# -----------------------------------------------------
# WIDTH OF THE APERATURE
# -----------------------------------------------------

# Set up constants for the for loop.
velocities = [.9*Vundef, 1.1*Vundef] # Focus on the first and last velocity.
B_optimal = desc_dispersions[0][0]*vector(0,1,0)
proton_radius = 0.02
left_location = 1
right_location = -1

for velocity in velocities:
    proton.pos = vector(-xmax+0.001, 0, 0)
    proton.vel = velocity*vector(1, 0, 0)

    # Motion of proton while it is still inside the grid.
    while abs(proton.pos.x) <= xmax and abs(proton.pos.z) <= xmax:
        # Calculate net force and update proton's information.
        lorentz = q*cross(proton.vel, B_optimal)
        E = velocity*B_optimal
        F_net = (lorentz) + (q*E)
        a_net = (F_net)/(m)

        proton.pos = proton.pos + proton.vel*deltat + (0.5)*a_net*(deltat**2)
        proton.vel = proton.vel + a_net*deltat

    # Find left_location and right_location.
    if left_location > proton.pos.z:
        left_location = proton.pos.z
    if right_location < proton.pos.z:
        right_location = proton.pos.z

# Add the proton radius because the final z position is where the center of the proton is located. Add (1/2) of a radius to both sides (left side and right side) so the proton can fit.
width = right_location - left_location + proton_radius
print("The equation for the width is right location - left location + proton radius:")
print("{0:.3f}m - {1:.3f}m + {2:.3f}m").format(right_location, left_location, proton_radius)
print("The width of the aperature should be {0:.4f}m.").format(width)