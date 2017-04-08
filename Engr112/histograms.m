A = rand(1000,1);
B = rand(1000,1).^3;
C = rand(1000,1).^0.3;
d = rand(1000,1) + rand(1000,1) + rand(1000,1) + rand(1000,1);

subplot(2,2,1)
histogram(A)
title('Histogram of A')

subplot(2,2,2)
histogram(B)
title('Histogram of B')

subplot(2,2,3)
histogram(C)
title('Histogram of C')

subplot(2,2,4)
histogram(D)
title('Histogram of D')