function [ approximation ] = approximate_pi( k )
%APPROXIMATE_PI Approximates pi using a summation formula to the kth term.
%   $\pi \approx 2\sum_{n=0}^{\inf} \frac{n!}{(2n+1)!!}$

approximation = 0;

for i=0:1:k
    term = (2*factorial(i))/(semifactorial(2*i + 1));
    approximation = approximation + term;
end

