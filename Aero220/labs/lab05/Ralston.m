function [ g ] = Ralston(  f, E, b,t, length, maxDeflection)
%RALSTON computes the maximum deflection of a wing.

momentOfInertia = (b*t^3)/(12);
g = maxDeflection - (f*length^4)/(8*E*momentOfInertia);


end

