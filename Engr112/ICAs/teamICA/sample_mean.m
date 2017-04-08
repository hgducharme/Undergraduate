function [ sampleMean ] = sample_mean( data_set )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

randomValues = randperm(length(data_set));
sampleMean = mean(randomValues);

end

