from visual import *

scene.title="Drawing E vectors"
scene.width=800
scene.height=800


sp = 6
curve(pos = [(-sp,0,0),(sp,0,0)], color = color.cyan)
curve(pos = [(0,-sp,0),(0,sp,0)], color = color.cyan)
curve(pos = [(0,0,-sp),(0,0,sp)], color = color.cyan)
box(pos=(0,0,0), size=(0.05,2*sp,2*sp), color=color.cyan)

b1_pos = vector(-3,0,0)
ball1 = sphere(pos=b1_pos,color=color.red,radius=.2)

b2_pos = vector(3,0,0)
ball2 = sphere(pos=-b1_pos,color=color.blue,radius=.2)


k = 8.99*(10**9)
q1 = 2e-9
q2 = -q1
r_hat = 0
E = 0

for x in arange(-sp,sp):
    for y in arange(-sp,sp):
        for z in arange(-sp,sp):
            r = vector(x, y, z)
            r1 = r - b1_pos
            r2 = r - b2_pos

            if mag(r1) != 0 and mag(r2) != 0:

                    r1_hat = r1/mag(r1)
                    E1 = ( (k*q1)/(mag(r1)**2) )*(r1_hat)

                    r2_hat = r2/mag(r2)
                    E2 = ( (k*q2)/(mag(r2)**2) )*(r2_hat)

                    E_net = E1 + E2
                    E_hat = (E_net)/(mag(E_net))
                    arrow(pos=(x, y, z), axis=E_hat, shaftwidth=0.08, color=color.white)



ClickLabel=label(pos=(0,8,0), text='Click on screen to continue.')
scene.mouse.getclick()
ClickLabel.visible=false