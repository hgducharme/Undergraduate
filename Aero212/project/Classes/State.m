classdef State
    properties
        temperature
        pressure
        enthalpy
        internalEnergy
        entropy
        relativePressure
        relativeSpecificVolume
        mass_flow_rate
    end
    methods
        function [T, h, u, s, pr, vr] = interpolate_all_properties(state)
            [T, h, u, s, pr, vr] = thermodynamicInterpolator(state.temperature);
        end    
    end
end